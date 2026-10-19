using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace Proxima;

internal class ProximaInternalCommands
{
	[Serializable]
	private struct CommandsDump
	{
		public List<CommandDump> Commands;
	}

	[Serializable]
	private struct CommandDump
	{
		public string Name;

		public string Category;

		public string Alias;

		public string Description;

		public string ExampleInput;

		public string ExampleOutput;

		public List<ParameterDump> Parameters;
	}

	[Serializable]
	private struct ParameterDump
	{
		public string Name;

		public string Type;

		public string Default;
	}

	private static bool _paused;

	private static float _timeScale;

	private static string HelpCommand(string command)
	{
		if (!ProximaInspector.Commands.TryGetValue(command, out var value))
		{
			return "Unknown command: " + command;
		}
		ProximaCommandAttribute customAttribute = value.GetCustomAttribute<ProximaCommandAttribute>();
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine(value.Name);
		stringBuilder.AppendLine("Category: " + customAttribute.Category);
		if (!string.IsNullOrWhiteSpace(customAttribute.Alias))
		{
			stringBuilder.AppendLine("Alias: " + customAttribute.Alias);
		}
		if (!string.IsNullOrWhiteSpace(customAttribute.Description))
		{
			stringBuilder.AppendLine("Description: " + customAttribute.Description);
		}
		ParameterInfo[] parameters = value.GetParameters();
		if (parameters.Length != 0)
		{
			stringBuilder.AppendLine("Parameters:");
		}
		foreach (ParameterInfo parameterInfo in parameters)
		{
			stringBuilder.Append("  ");
			Type type = parameterInfo.ParameterType;
			object value2 = (parameterInfo.HasDefaultValue ? parameterInfo.DefaultValue : null);
			if (typeof(IPropertyOrValue).IsAssignableFrom(parameterInfo.ParameterType))
			{
				type = parameterInfo.ParameterType.GetGenericArguments()[0];
				value2 = (type.IsValueType ? Activator.CreateInstance(type) : "null");
			}
			stringBuilder.Append(parameterInfo.Name);
			stringBuilder.Append(": ");
			stringBuilder.Append(type.Name);
			if (parameterInfo.HasDefaultValue)
			{
				stringBuilder.Append(" (default: ");
				stringBuilder.Append(value2);
				stringBuilder.Append(")");
			}
			stringBuilder.AppendLine();
		}
		if (!string.IsNullOrWhiteSpace(customAttribute.ExampleInput))
		{
			stringBuilder.AppendLine();
			stringBuilder.AppendLine("Example:");
			stringBuilder.AppendLine("  > " + customAttribute.ExampleInput);
			if (!string.IsNullOrWhiteSpace(customAttribute.ExampleOutput))
			{
				stringBuilder.AppendLine("  " + customAttribute.ExampleOutput.Replace("\n", "\n  "));
			}
		}
		return stringBuilder.ToString();
	}

	private static string HelpAll()
	{
		StringBuilder stringBuilder = new StringBuilder();
		Dictionary<string, List<(string, MethodInfo)>> dictionary = new Dictionary<string, List<(string, MethodInfo)>>();
		foreach (KeyValuePair<string, MethodInfo> command in ProximaInspector.Commands)
		{
			string key = command.Key;
			MethodInfo value = command.Value;
			ProximaCommandAttribute customAttribute = value.GetCustomAttribute<ProximaCommandAttribute>();
			if (!(customAttribute.Alias == key) && !(customAttribute.Category == "Internal"))
			{
				if (!dictionary.TryGetValue(customAttribute.Category, out var value2))
				{
					value2 = new List<(string, MethodInfo)>();
					dictionary.Add(customAttribute.Category, value2);
				}
				value2.Add((key, value));
			}
		}
		List<string> list = new List<string>(dictionary.Keys);
		list.Sort();
		foreach (string item3 in list)
		{
			List<(string, MethodInfo)> list2 = dictionary[item3];
			list2.Sort(((string, MethodInfo) a, (string, MethodInfo) b) => a.Item1.CompareTo(b.Item1));
			stringBuilder.AppendLine(item3 + " Commands:");
			foreach (var item4 in list2)
			{
				string item = item4.Item1;
				MethodInfo item2 = item4.Item2;
				ProximaCommandAttribute customAttribute2 = item2.GetCustomAttribute<ProximaCommandAttribute>();
				ParameterInfo[] parameters = item2.GetParameters();
				stringBuilder.Append("  ");
				stringBuilder.Append(item);
				stringBuilder.Append(" ");
				if (!string.IsNullOrEmpty(customAttribute2.Alias))
				{
					stringBuilder.Append("(");
					stringBuilder.Append(customAttribute2.Alias);
					stringBuilder.Append(") ");
				}
				for (int num = 0; num < parameters.Length; num++)
				{
					ParameterInfo parameterInfo = parameters[num];
					if (parameterInfo.HasDefaultValue)
					{
						stringBuilder.Append("<");
						stringBuilder.Append(parameterInfo.Name);
						stringBuilder.Append(">");
					}
					else
					{
						stringBuilder.Append(parameterInfo.Name);
					}
					if (num < parameters.Length - 1)
					{
						stringBuilder.Append(" ");
					}
				}
				stringBuilder.AppendLine();
			}
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("Internal", "?", "", "", "")]
	public static string Help(string command = null)
	{
		if (!string.IsNullOrWhiteSpace(command))
		{
			return HelpCommand(command);
		}
		return HelpAll();
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static string Ping()
	{
		return "Pong";
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static bool IsPaused()
	{
		return _paused;
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static string Pause()
	{
		if (!_paused)
		{
			_timeScale = Time.timeScale;
			Time.timeScale = 0f;
			_paused = true;
			return "Paused.";
		}
		return "Already paused.";
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static string Resume()
	{
		if (_paused)
		{
			Time.timeScale = _timeScale;
			_paused = false;
			return "Resumed.";
		}
		return "Already resume.";
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static object DumpCommands()
	{
		CommandsDump commandsDump = new CommandsDump
		{
			Commands = new List<CommandDump>()
		};
		foreach (KeyValuePair<string, MethodInfo> command in ProximaInspector.Commands)
		{
			string key = command.Key;
			MethodInfo value = command.Value;
			ProximaCommandAttribute customAttribute = value.GetCustomAttribute<ProximaCommandAttribute>();
			if (customAttribute.Category == "Internal" || customAttribute.Alias == key)
			{
				continue;
			}
			CommandDump item = new CommandDump
			{
				Name = value.Name,
				Category = customAttribute.Category,
				Alias = customAttribute.Alias,
				Description = customAttribute.Description,
				ExampleInput = customAttribute.ExampleInput,
				ExampleOutput = customAttribute.ExampleOutput,
				Parameters = new List<ParameterDump>()
			};
			ParameterInfo[] parameters = value.GetParameters();
			foreach (ParameterInfo parameterInfo in parameters)
			{
				Type type = parameterInfo.ParameterType;
				object obj = (parameterInfo.HasDefaultValue ? parameterInfo.DefaultValue : null);
				if (typeof(IPropertyOrValue).IsAssignableFrom(parameterInfo.ParameterType))
				{
					type = parameterInfo.ParameterType.GetGenericArguments()[0];
					obj = (type.IsValueType ? Activator.CreateInstance(type) : "null");
				}
				item.Parameters.Add(new ParameterDump
				{
					Name = parameterInfo.Name,
					Type = type.Name,
					Default = ((obj != null) ? ProximaSerialization.Serialize(obj) : null)
				});
			}
			commandsDump.Commands.Add(item);
		}
		return commandsDump;
	}
}
