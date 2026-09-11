using System;
using System.Reflection;
using ParadoxNotion;

namespace FlowCanvas.Nodes;

public abstract class UniversalDelegateParam
{
	public ParamDef paramDef;

	public bool paramsArrayNeeded;

	public int paramsArrayCount;

	public UniversalDelegate referencedDelegate;

	public UniversalDelegateParam[] referencedParams;

	public abstract FieldInfo ValueField { get; }

	public abstract Type GetCurrentType();

	public abstract void RegisterAsInput(FlowNode node);

	public abstract void RegisterAsOutput(FlowNode node);

	public abstract void RegisterAsOutput(FlowNode node, Action beforeReturn);

	public abstract void RegisterAsOutput(FlowNode node, Action<UniversalDelegateParam> beforeReturn);

	public abstract void SetFromInput();

	public abstract void SetFromValue(object value);
}
public class UniversalDelegateParam<T> : UniversalDelegateParam
{
	public T value;

	private ValueInput<T> valueInput;

	private static FieldInfo _fieldInfo;

	public override FieldInfo ValueField => _fieldInfo ?? (_fieldInfo = GetType().RTGetField("value"));

	public override Type GetCurrentType()
	{
		return typeof(T);
	}

	public override void RegisterAsInput(FlowNode node)
	{
		if (paramDef.paramMode == ParamMode.Instance || paramDef.paramMode == ParamMode.In || paramDef.paramMode == ParamMode.Ref || paramDef.paramMode == ParamMode.Result)
		{
			valueInput = node.AddValueInput<T>(paramDef.portName, paramDef.portId);
		}
	}

	private void RegisterAsOutputInternal(FlowNode node, Delegate beforeReturn)
	{
		if (paramDef.paramMode != ParamMode.Instance && paramDef.paramMode != ParamMode.Out && paramDef.paramMode != ParamMode.Ref && paramDef.paramMode != ParamMode.Result)
		{
			return;
		}
		ValueHandler<T> getter = delegate
		{
			if (beforeReturn is Action action)
			{
				action();
			}
			if (beforeReturn is Action<UniversalDelegateParam> action2)
			{
				action2(this);
			}
			return value;
		};
		node.AddValueOutput(paramDef.portName, getter, paramDef.portId);
	}

	public override void RegisterAsOutput(FlowNode node)
	{
		RegisterAsOutputInternal(node, null);
	}

	public override void RegisterAsOutput(FlowNode node, Action beforeReturn)
	{
		RegisterAsOutputInternal(node, beforeReturn);
	}

	public override void RegisterAsOutput(FlowNode node, Action<UniversalDelegateParam> beforeReturn)
	{
		RegisterAsOutputInternal(node, beforeReturn);
	}

	public override void SetFromInput()
	{
		if (valueInput != null)
		{
			value = valueInput.value;
		}
	}

	public override void SetFromValue(object newValue)
	{
		value = (T)newValue;
	}
}
public class UniversalDelegateParam<TArray, TValue> : UniversalDelegateParam<TArray>
{
	private ValueInput<TValue>[] valueInputs;

	public override void RegisterAsInput(FlowNode node)
	{
		valueInputs = null;
		if (paramsArrayNeeded && paramsArrayCount >= 0)
		{
			valueInputs = new ValueInput<TValue>[paramsArrayCount];
			for (int i = 0; i <= paramsArrayCount - 1; i++)
			{
				valueInputs[i] = node.AddValueInput<TValue>(paramDef.portName + " #" + i, paramDef.portId + i);
			}
		}
		else
		{
			base.RegisterAsInput(node);
		}
	}

	public override void SetFromInput()
	{
		if (paramsArrayNeeded && paramsArrayCount >= 0 && valueInputs != null && valueInputs.Length == paramsArrayCount)
		{
			TValue[] array = new TValue[paramsArrayCount];
			for (int i = 0; i <= paramsArrayCount - 1; i++)
			{
				array[i] = valueInputs[i].value;
			}
			try
			{
				value = (TArray)(object)array;
				return;
			}
			catch
			{
				base.SetFromInput();
				return;
			}
		}
		base.SetFromInput();
	}
}
