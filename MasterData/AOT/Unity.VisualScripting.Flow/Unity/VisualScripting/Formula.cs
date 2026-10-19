using System;
using Unity.VisualScripting.Dependencies.NCalc;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Unity.VisualScripting;

public sealed class Formula : MultiInputUnit<object>
{
	[SerializeAs("Formula")]
	private string _formula;

	private Expression ncalc;

	[DoNotSerialize]
	[Inspectable]
	[UnitHeaderInspectable]
	[InspectorTextArea]
	public string formula
	{
		get
		{
			return _formula;
		}
		set
		{
			_formula = value;
			InitializeNCalc();
		}
	}

	[Serialize]
	[Inspectable(order = int.MaxValue)]
	[InspectorExpandTooltip]
	public bool cacheArguments { get; set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput result { get; private set; }

	protected override int minInputCount => 0;

	protected override void Definition()
	{
		base.Definition();
		result = ValueOutput("result", Evaluate);
		InputsAllowNull();
		foreach (ValueInput multiInput in multiInputs)
		{
			Requirement(multiInput, result);
		}
		InitializeNCalc();
	}

	private void InitializeNCalc()
	{
		if (string.IsNullOrEmpty(formula))
		{
			ncalc = null;
			return;
		}
		ncalc = new Expression(formula);
		ncalc.Options = EvaluateOptions.IgnoreCase;
		ncalc.EvaluateParameter += EvaluateTreeParameter;
		ncalc.EvaluateFunction += EvaluateTreeFunction;
	}

	private object Evaluate(Flow flow)
	{
		if (ncalc == null)
		{
			throw new InvalidOperationException("No formula provided.");
		}
		ncalc.UpdateUnityTimeParameters();
		return ncalc.Evaluate(flow);
	}

	private void EvaluateTreeFunction(Flow flow, string name, FunctionArgs args)
	{
		switch (name)
		{
		case "v2":
		case "V2":
			if (args.Parameters.Length != 2)
			{
				throw new ArgumentException($"v2() takes at exactly 2 arguments. {args.Parameters.Length} provided.");
			}
			args.Result = new Vector2(ConversionUtility.Convert<float>(args.Parameters[0].Evaluate(flow)), ConversionUtility.Convert<float>(args.Parameters[1].Evaluate(flow)));
			break;
		case "v3":
		case "V3":
			if (args.Parameters.Length != 3)
			{
				throw new ArgumentException($"v3() takes at exactly 3 arguments. {args.Parameters.Length} provided.");
			}
			args.Result = new Vector3(ConversionUtility.Convert<float>(args.Parameters[0].Evaluate(flow)), ConversionUtility.Convert<float>(args.Parameters[1].Evaluate(flow)), ConversionUtility.Convert<float>(args.Parameters[2].Evaluate(flow)));
			break;
		case "v4":
		case "V4":
			if (args.Parameters.Length != 4)
			{
				throw new ArgumentException($"v4() takes at exactly 4 arguments. {args.Parameters.Length} provided.");
			}
			args.Result = new Vector4(ConversionUtility.Convert<float>(args.Parameters[0].Evaluate(flow)), ConversionUtility.Convert<float>(args.Parameters[1].Evaluate(flow)), ConversionUtility.Convert<float>(args.Parameters[2].Evaluate(flow)), ConversionUtility.Convert<float>(args.Parameters[3].Evaluate(flow)));
			break;
		}
	}

	public object GetParameterValue(Flow flow, string name)
	{
		if (name.Length == 1)
		{
			char c = name[0];
			if (char.IsLetter(c))
			{
				c = char.ToLower(c);
				int argumentIndex = GetArgumentIndex(c);
				if (argumentIndex < multiInputs.Count)
				{
					ValueInput valueInput = multiInputs[argumentIndex];
					if (cacheArguments && !flow.IsLocal(valueInput))
					{
						flow.SetValue(valueInput, flow.GetValue<object>(valueInput));
					}
					return flow.GetValue<object>(valueInput);
				}
			}
		}
		else
		{
			if (Variables.Graph(flow.stack).IsDefined(name))
			{
				return Variables.Graph(flow.stack).Get(name);
			}
			GameObject self = flow.stack.self;
			if (self != null && Variables.Object(self).IsDefined(name))
			{
				return Variables.Object(self).Get(name);
			}
			Scene? scene = flow.stack.scene;
			if (scene.HasValue && Variables.Scene(scene).IsDefined(name))
			{
				return Variables.Scene(scene).Get(name);
			}
			if (Variables.Application.IsDefined(name))
			{
				return Variables.Application.Get(name);
			}
			if (Variables.Saved.IsDefined(name))
			{
				return Variables.Saved.Get(name);
			}
		}
		throw new InvalidOperationException("Unknown expression tree parameter: '" + name + "'.\nSupported parameter names are alphabetical indices and variable names.");
	}

	private void EvaluateTreeParameter(Flow flow, string name, ParameterArgs args)
	{
		if (name.Contains("."))
		{
			string[] array = name.Split('.');
			if (array.Length != 2)
			{
				throw new InvalidOperationException("Cannot parse expression tree parameter: [" + name + "]");
			}
			string text = array[0];
			string text2 = array[1].TrimEnd("()");
			object parameterValue = GetParameterValue(flow, text);
			Member member = new Member(parameterValue.GetType(), text2, Type.EmptyTypes);
			object target = parameterValue;
			if (member.isInvocable)
			{
				args.Result = member.Invoke(target);
				return;
			}
			if (!member.isGettable)
			{
				throw new InvalidOperationException("Cannot get or invoke expression tree parameter: [" + text + "." + text2 + "]");
			}
			args.Result = member.Get(target);
		}
		else
		{
			args.Result = GetParameterValue(flow, name);
		}
	}

	public static string GetArgumentName(int index)
	{
		if (index > 25)
		{
			throw new NotImplementedException("Argument indices above 26 are not yet supported.");
		}
		return ((char)(97 + index)).ToString();
	}

	public static int GetArgumentIndex(char name)
	{
		if (name < 'a' || name > 'z')
		{
			throw new NotImplementedException("Unalphabetical argument names are not yet supported.");
		}
		return name - 97;
	}
}
