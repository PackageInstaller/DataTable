using System;
using System.Linq;

namespace Unity.VisualScripting;

public static class XUnit
{
	public static ValueInput CompatibleValueInput(this IUnit unit, Type outputType)
	{
		Ensure.That("outputType").IsNotNull(outputType);
		return unit.valueInputs.Where((ValueInput valueInput) => ConversionUtility.CanConvert(outputType, valueInput.type, guaranteed: false)).OrderBy((ValueInput valueInput) =>
		{
			bool flag = outputType == valueInput.type;
			bool flag2 = !valueInput.hasValidConnection;
			if (flag2 & flag)
			{
				return 1;
			}
			if (flag2)
			{
				return 2;
			}
			return flag ? 3 : 4;
		}).FirstOrDefault();
	}

	public static ValueOutput CompatibleValueOutput(this IUnit unit, Type inputType)
	{
		Ensure.That("inputType").IsNotNull(inputType);
		return unit.valueOutputs.Where((ValueOutput valueOutput) => ConversionUtility.CanConvert(valueOutput.type, inputType, guaranteed: false)).OrderBy((ValueOutput valueOutput) =>
		{
			bool flag = inputType == valueOutput.type;
			bool flag2 = !valueOutput.hasValidConnection;
			if (flag2 & flag)
			{
				return 1;
			}
			if (flag2)
			{
				return 2;
			}
			return flag ? 3 : 4;
		}).FirstOrDefault();
	}
}
