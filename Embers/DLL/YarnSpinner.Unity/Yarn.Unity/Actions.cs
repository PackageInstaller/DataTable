using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using UnityEngine;

namespace Yarn.Unity;

public class Actions : ICommandDispatcher, IActionRegistration
{
	internal class CommandRegistration : ICommand
	{
		public enum CommandType
		{
			IsVoid,
			ReturnsCoroutine,
			IsCoroutine,
			Invalid
		}

		public readonly Func<string, object>[] Converters;

		private readonly Dictionary<Type, string> TypeFriendlyNames = new Dictionary<Type, string>
		{
			{
				typeof(int),
				"number"
			},
			{
				typeof(float),
				"number"
			},
			{
				typeof(double),
				"number"
			},
			{
				typeof(decimal),
				"number"
			},
			{
				typeof(string),
				"string"
			},
			{
				typeof(bool),
				"bool"
			}
		};

		public string Name { get; set; }

		public MethodInfo Method { get; set; }

		private object Target { get; set; }

		public Type DeclaringType => Method.DeclaringType;

		public Type ReturnType => Method.ReturnType;

		public bool IsStatic => Method.IsStatic;

		private bool DynamicallyFindsTarget { get; }

		public CommandType Type
		{
			get
			{
				Type returnType = ReturnType;
				if (typeof(void).IsAssignableFrom(returnType))
				{
					return CommandType.IsVoid;
				}
				if (typeof(IEnumerator).IsAssignableFrom(returnType))
				{
					return CommandType.IsCoroutine;
				}
				if (typeof(Coroutine).IsAssignableFrom(returnType))
				{
					return CommandType.ReturnsCoroutine;
				}
				return CommandType.Invalid;
			}
		}

		private (int Min, int Max) ParameterCount
		{
			get
			{
				ParameterInfo[] parameters = Method.GetParameters();
				int num = 0;
				ParameterInfo[] array = parameters;
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i].IsOptional)
					{
						num++;
					}
				}
				int item = parameters.Length - num;
				int item2 = parameters.Length;
				return (Min: item, Max: item2);
			}
		}

		public string UsageString
		{
			get
			{
				List<string> list = new List<string>();
				list.Add(Name);
				if (DynamicallyFindsTarget)
				{
					string name = DeclaringType.Name;
					list.Add("target <i>(" + name + ")</i>");
				}
				ParameterInfo[] parameters = Method.GetParameters();
				foreach (ParameterInfo parameterInfo in parameters)
				{
					Type parameterType = parameterInfo.ParameterType;
					if (!TypeFriendlyNames.TryGetValue(parameterType, out var value))
					{
						value = parameterType.Name;
					}
					string text = parameterInfo.Name + " <i>(" + value + ")</i>";
					if (parameterInfo.IsOptional)
					{
						text = $"[{text} = {parameterInfo.DefaultValue}]";
					}
					list.Add(text);
				}
				return string.Join(" ", list);
			}
		}

		public CommandRegistration(string name, Delegate @delegate)
		{
			Name = name;
			Method = @delegate.Method;
			Target = @delegate.Target;
			Converters = CreateConverters(Method);
			DynamicallyFindsTarget = false;
		}

		public CommandRegistration(string name, MethodInfo method)
		{
			if (method.IsStatic)
			{
				DynamicallyFindsTarget = false;
			}
			else
			{
				if (!typeof(Component).IsAssignableFrom(method.DeclaringType))
				{
					throw new ArgumentException("Cannot register method " + GetFullMethodName(method) + " as a command: instance methods must declared on Component classes.");
				}
				DynamicallyFindsTarget = true;
			}
			Name = name;
			Method = method;
			Target = null;
			Converters = CreateConverters(method);
		}

		public bool TryParseArgs(string[] args, out object[] result, out string message)
		{
			ParameterInfo[] parameters = Method.GetParameters();
			(int Min, int Max) parameterCount = ParameterCount;
			int item = parameterCount.Min;
			int item2 = parameterCount.Max;
			bool flag = parameters.Length != 0 && parameters[parameters.Length - 1].ParameterType.IsArray;
			int num = args.Length;
			if (num < item || (num > item2 && !flag))
			{
				string text = ((item == 0) ? string.Format("at most {0} {1}", item2, DiagnosticUtility.EnglishPluraliseNounCount(item2, "parameter")) : ((item == item2) ? string.Format("{0} {1}", item, DiagnosticUtility.EnglishPluraliseNounCount(item2, "parameter")) : string.Format("between {0} and {1} {2}", item, item2, DiagnosticUtility.EnglishPluraliseNounCount(item2, "parameter"))));
				message = $"{Name} requires {text}, but {num} {DiagnosticUtility.EnglishPluraliseWasVerb(num)} provided.";
				result = null;
				return false;
			}
			object[] array = new object[parameters.Length];
			List<object> list = new List<object>();
			for (int i = 0; i < num; i++)
			{
				string text2 = args[i];
				try
				{
					if ((i >= parameters.Length - 1) & flag)
					{
						Func<string, object> func = Converters[parameters.Length - 1];
						object item3 = ((func == null) ? text2 : func?.Invoke(text2));
						list.Add(item3);
					}
					else
					{
						Func<string, object> func = Converters[i];
						object item3 = ((func == null) ? text2 : func?.Invoke(text2));
						array[i] = item3;
					}
				}
				catch (Exception ex)
				{
					message = $"Can't convert parameter {i} to {parameters[i].ParameterType.Name}: {ex.Message}";
					result = null;
					return false;
				}
			}
			if (flag)
			{
				Array array2 = Array.CreateInstance(parameters[parameters.Length - 1].ParameterType.GetElementType(), list.Count);
				Array.Copy(list.ToArray(), array2, list.Count);
				array[parameters.Length - 1] = array2;
			}
			for (int j = num; j < array.Length; j++)
			{
				array[j] = System.Type.Missing;
			}
			result = array;
			message = null;
			return true;
		}

		internal CommandDispatchResult Invoke(DialogueRunner dispatcher, List<string> parameters, out Coroutine commandCoroutine)
		{
			object obj;
			if (DynamicallyFindsTarget)
			{
				if (parameters.Count == 0)
				{
					commandCoroutine = null;
					return new CommandDispatchResult
					{
						Message = Name + " needs a target, but none was specified",
						Status = CommandDispatchResult.StatusType.InvalidParameterCount
					};
				}
				string text = parameters[0];
				parameters.RemoveAt(0);
				GameObject gameObject = GameObject.Find(text);
				if (gameObject == null)
				{
					commandCoroutine = null;
					return new CommandDispatchResult
					{
						Message = "No game object named \"" + text + "\" exists",
						Status = CommandDispatchResult.StatusType.TargetMissingComponent
					};
				}
				Component component = gameObject.GetComponent(DeclaringType);
				if (component == null)
				{
					commandCoroutine = null;
					return new CommandDispatchResult
					{
						Message = Name + " can't be called on " + text + ", because it doesn't have a " + DeclaringType.Name,
						Status = CommandDispatchResult.StatusType.TargetMissingComponent
					};
				}
				obj = component;
			}
			else if (Method.IsStatic)
			{
				obj = null;
			}
			else
			{
				if (Target == null)
				{
					throw new InvalidOperationException(string.Format("Internal error: {0} \"{1}\" has no {2}, but method is not static and ${3} is false", "CommandRegistration", Name, "Target", DynamicallyFindsTarget));
				}
				obj = Target;
			}
			if (!TryParseArgs(parameters.ToArray(), out var result, out var message))
			{
				commandCoroutine = null;
				return new CommandDispatchResult
				{
					Status = CommandDispatchResult.StatusType.InvalidParameterCount,
					Message = message
				};
			}
			object obj2 = Method.Invoke(obj, result);
			if (obj2 is Coroutine coroutine)
			{
				commandCoroutine = coroutine;
				return new CommandDispatchResult
				{
					Status = CommandDispatchResult.StatusType.SucceededAsync
				};
			}
			if (obj2 is IEnumerator routine)
			{
				commandCoroutine = dispatcher.StartCoroutine(routine);
				return new CommandDispatchResult
				{
					Status = CommandDispatchResult.StatusType.SucceededAsync
				};
			}
			commandCoroutine = null;
			return new CommandDispatchResult
			{
				Status = CommandDispatchResult.StatusType.SucceededSync
			};
		}
	}

	private class LibraryRegistrationProxy : IActionRegistration
	{
		private Library library;

		public LibraryRegistrationProxy(Library library)
		{
			this.library = library;
		}

		public void AddCommandHandler(string commandName, Delegate handler)
		{
		}

		public void AddCommandHandler(string commandName, Func<Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler(string commandName, MethodInfo methodInfo)
		{
			AddCommandHandler(commandName, (Delegate)null);
		}

		public void AddCommandHandler<T1>(string commandName, Func<T1, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2>(string commandName, Func<T1, T2, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3>(string commandName, Func<T1, T2, T3, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4>(string commandName, Func<T1, T2, T3, T4, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Func<T1, T2, T3, T4, T5, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Func<T1, T2, T3, T4, T5, T6, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, Coroutine> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler(string commandName, Func<IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1>(string commandName, Func<T1, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2>(string commandName, Func<T1, T2, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3>(string commandName, Func<T1, T2, T3, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4>(string commandName, Func<T1, T2, T3, T4, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Func<T1, T2, T3, T4, T5, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Func<T1, T2, T3, T4, T5, T6, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, IEnumerator> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler(string commandName, Action handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1>(string commandName, Action<T1> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2>(string commandName, Action<T1, T2> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3>(string commandName, Action<T1, T2, T3> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4>(string commandName, Action<T1, T2, T3, T4> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Action<T1, T2, T3, T4, T5> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Action<T1, T2, T3, T4, T5, T6> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8, T9> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> handler)
		{
			AddCommandHandler(commandName, (Delegate)handler);
		}

		public void AddFunction(string name, Delegate implementation)
		{
			if (library.FunctionExists(name))
			{
				throw new ArgumentException("Cannot register function " + name + ": a function with this name already exists");
			}
			library.RegisterFunction(name, implementation);
		}

		public void AddFunction<TResult>(string name, Func<TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, TResult>(string name, Func<T1, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, T2, TResult>(string name, Func<T1, T2, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, T2, T3, TResult>(string name, Func<T1, T2, T3, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, T2, T3, T4, TResult>(string name, Func<T1, T2, T3, T4, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, T2, T3, T4, T5, TResult>(string name, Func<T1, T2, T3, T4, T5, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, T2, T3, T4, T5, T6, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, T2, T3, T4, T5, T6, T7, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult> implementation)
		{
			AddFunction(name, (Delegate)implementation);
		}

		public void RemoveCommandHandler(string commandName)
		{
			throw new InvalidOperationException("This class does not support removing actions.");
		}

		public void RemoveFunction(string name)
		{
			throw new InvalidOperationException("This class does not support removing actions.");
		}
	}

	private Dictionary<string, CommandRegistration> _commands = new Dictionary<string, CommandRegistration>();

	internal static HashSet<Action<IActionRegistration>> ActionRegistrationMethods = new HashSet<Action<IActionRegistration>>();

	public Library Library { get; }

	public DialogueRunner DialogueRunner { get; }

	public IEnumerable<ICommand> Commands => _commands.Values;

	public Actions(DialogueRunner dialogueRunner, Library library)
	{
		Library = library;
		DialogueRunner = dialogueRunner;
	}

	private static string GetFullMethodName(MethodInfo method)
	{
		return method.DeclaringType.FullName + "." + method.Name;
	}

	public void RegisterActions()
	{
		foreach (Action<IActionRegistration> actionRegistrationMethod in ActionRegistrationMethods)
		{
			actionRegistrationMethod(DialogueRunner);
		}
	}

	public void AddCommandHandler(string commandName, Delegate handler)
	{
		if (commandName.Contains(' '))
		{
			Debug.LogError("Failed to register command " + commandName + ": command names are not allowed to contain spaces.");
		}
		else if (_commands.ContainsKey(commandName))
		{
			Debug.LogError("Failed to register command " + commandName + ": a command by this name has already been registered.");
		}
		else
		{
			_commands.Add(commandName, new CommandRegistration(commandName, handler));
		}
	}

	public void AddFunction(string name, Delegate implementation)
	{
		if (name.Contains(' '))
		{
			Debug.LogError("Cannot add function " + name + ": command names are not allowed to contain spaces.");
		}
		else if (Library.FunctionExists(name))
		{
			Debug.LogError("Cannot add function " + name + ": one already exists");
		}
		else
		{
			Library.RegisterFunction(name, implementation);
		}
	}

	public void AddCommandHandler(string commandName, MethodInfo methodInfo)
	{
		if (commandName.Contains(' '))
		{
			Debug.LogError("Failed to register command " + commandName + ": command names are not allowed to contain spaces.");
		}
		else if (_commands.ContainsKey(commandName))
		{
			Debug.LogError("Failed to register command " + commandName + ": a command by this name has already been registered.");
		}
		else
		{
			_commands.Add(commandName, new CommandRegistration(commandName, methodInfo));
		}
	}

	public void AddCommandHandler(string commandName, Func<Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1>(string commandName, Func<T1, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2>(string commandName, Func<T1, T2, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3>(string commandName, Func<T1, T2, T3, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4>(string commandName, Func<T1, T2, T3, T4, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Func<T1, T2, T3, T4, T5, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Func<T1, T2, T3, T4, T5, T6, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, Coroutine> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler(string commandName, Action handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1>(string commandName, Action<T1> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2>(string commandName, Action<T1, T2> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3>(string commandName, Action<T1, T2, T3> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4>(string commandName, Action<T1, T2, T3, T4> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Action<T1, T2, T3, T4, T5> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Action<T1, T2, T3, T4, T5, T6> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8, T9> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddFunction<TResult>(string name, Func<TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, TResult>(string name, Func<T1, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, T2, TResult>(string name, Func<T1, T2, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, T2, T3, TResult>(string name, Func<T1, T2, T3, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, T2, T3, T4, TResult>(string name, Func<T1, T2, T3, T4, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, TResult>(string name, Func<T1, T2, T3, T4, T5, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, T7, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult> implementation)
	{
		AddFunction(name, (Delegate)implementation);
	}

	public void RemoveCommandHandler(string commandName)
	{
		if (!_commands.Remove(commandName))
		{
			Debug.LogError("Can't remove command " + commandName + ", because no command with this name is currently registered.");
		}
	}

	public void RemoveFunction(string name)
	{
		if (!Library.FunctionExists(name))
		{
			Debug.LogError("Cannot remove function " + name + ": no function with that name exists in the library");
		}
		else
		{
			Library.DeregisterFunction(name);
		}
	}

	public void SetupForProject(YarnProject yarnProject)
	{
	}

	CommandDispatchResult ICommandDispatcher.DispatchCommand(string command, out Coroutine commandCoroutine)
	{
		List<string> list = new List<string>(DialogueRunner.SplitCommandText(command));
		if (list.Count == 0)
		{
			commandCoroutine = null;
			return new CommandDispatchResult
			{
				Status = CommandDispatchResult.StatusType.CommandUnknown
			};
		}
		if (_commands.TryGetValue(list[0], out var value))
		{
			list.RemoveAt(0);
			return value.Invoke(DialogueRunner, list, out commandCoroutine);
		}
		commandCoroutine = null;
		return new CommandDispatchResult
		{
			Status = CommandDispatchResult.StatusType.CommandUnknown
		};
	}

	private static Func<string, object>[] CreateConverters(MethodInfo method)
	{
		ParameterInfo[] parameters = method.GetParameters();
		Func<string, object>[] array = (Func<string, object>[])Array.CreateInstance(typeof(Func<string, object>), parameters.Length);
		int num = 0;
		ParameterInfo[] array2 = parameters;
		foreach (ParameterInfo parameterInfo in array2)
		{
			if (parameterInfo.ParameterType.IsArray)
			{
				if (num != parameters.Length - 1)
				{
					throw new ArgumentException($"Can't register method {method.Name}: Parameter {num + 1} ({parameterInfo.Name}): array parameters are required to be last.");
				}
				if (parameterInfo.ParameterType.GetElementType() != typeof(string))
				{
					throw new ArgumentException($"Can't register method {method.Name}: Parameter {num + 1} ({parameterInfo.Name}): array parameters are required to be string arrays.");
				}
				array[num] = (string arg) => arg;
			}
			else
			{
				array[num] = CreateConverter(parameterInfo, num);
			}
			num++;
		}
		return array;
	}

	private static Func<string, object> CreateConverter(ParameterInfo parameter, int index)
	{
		Type targetType = parameter.ParameterType;
		if (targetType == typeof(string))
		{
			return (string arg) => arg;
		}
		if (typeof(GameObject).IsAssignableFrom(targetType))
		{
			return GameObject.Find;
		}
		if (typeof(Component).IsAssignableFrom(targetType))
		{
			return delegate(string arg)
			{
				GameObject gameObject = GameObject.Find(arg);
				return (gameObject == null) ? null : gameObject.GetComponentInChildren(targetType);
			};
		}
		if (typeof(bool).IsAssignableFrom(targetType))
		{
			return delegate(string arg)
			{
				if (arg.Equals(parameter.Name, StringComparison.InvariantCultureIgnoreCase))
				{
					return true;
				}
				if (bool.TryParse(arg, out var result))
				{
					return result;
				}
				throw new ArgumentException($"Can't convert the given parameter at position {index + 1} (\"{arg}\") to parameter " + parameter.Name + " of type " + typeof(bool).FullName + ".");
			};
		}
		return delegate(string arg)
		{
			try
			{
				return Convert.ChangeType(arg, targetType, CultureInfo.InvariantCulture);
			}
			catch (Exception ex)
			{
				throw new ArgumentException($"Can't convert the given parameter at position {index + 1} (\"{arg}\") to parameter " + $"{parameter.Name} of type {targetType.FullName}: {ex}", ex);
			}
		};
	}

	public static void AddRegistrationMethod(Action<IActionRegistration> registerActions)
	{
		ActionRegistrationMethods.Add(registerActions);
	}

	public static Library GetLibrary()
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Expected O, but got Unknown
		Library val = new Library();
		LibraryRegistrationProxy obj = new LibraryRegistrationProxy(val);
		foreach (Action<IActionRegistration> actionRegistrationMethod in ActionRegistrationMethods)
		{
			actionRegistrationMethod(obj);
		}
		return val;
	}

	public void AddCommandHandler(string commandName, Func<IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1>(string commandName, Func<T1, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2>(string commandName, Func<T1, T2, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3>(string commandName, Func<T1, T2, T3, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4>(string commandName, Func<T1, T2, T3, T4, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Func<T1, T2, T3, T4, T5, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Func<T1, T2, T3, T4, T5, T6, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, IEnumerator> handler)
	{
		AddCommandHandler(commandName, (Delegate)handler);
	}
}
