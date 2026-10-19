using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal abstract class CallInstruction : Instruction
{
	public abstract int ArgumentCount { get; }

	public override string InstructionName => "Call";

	public override int ConsumedStack => ArgumentCount;

	public static CallInstruction Create(MethodInfo info)
	{
		return Create(info, info.GetParametersCached());
	}

	public static CallInstruction Create(MethodInfo info, ParameterInfo[] parameters)
	{
		int num = parameters.Length;
		if (!info.IsStatic)
		{
			num++;
		}
		if (info.DeclaringType != null && info.DeclaringType.IsArray && (info.Name == "Get" || info.Name == "Set"))
		{
			return GetArrayAccessor(info, num);
		}
		return new MethodInfoCallInstruction(info, num);
	}

	private static CallInstruction GetArrayAccessor(MethodInfo info, int argumentCount)
	{
		Type declaringType = info.DeclaringType;
		bool flag = info.Name == "Get";
		MethodInfo methodInfo = null;
		switch (declaringType.GetArrayRank())
		{
		case 1:
			methodInfo = (flag ? declaringType.GetMethod("GetValue", new Type[1] { typeof(int) }) : typeof(CallInstruction).GetMethod("ArrayItemSetter1"));
			break;
		case 2:
			methodInfo = (flag ? declaringType.GetMethod("GetValue", new Type[2]
			{
				typeof(int),
				typeof(int)
			}) : typeof(CallInstruction).GetMethod("ArrayItemSetter2"));
			break;
		case 3:
			methodInfo = (flag ? declaringType.GetMethod("GetValue", new Type[3]
			{
				typeof(int),
				typeof(int),
				typeof(int)
			}) : typeof(CallInstruction).GetMethod("ArrayItemSetter3"));
			break;
		}
		if ((object)methodInfo == null)
		{
			return new MethodInfoCallInstruction(info, argumentCount);
		}
		return Create(methodInfo);
	}

	public static void ArrayItemSetter1(Array array, int index0, object value)
	{
		array.SetValue(value, index0);
	}

	public static void ArrayItemSetter2(Array array, int index0, int index1, object value)
	{
		array.SetValue(value, index0, index1);
	}

	public static void ArrayItemSetter3(Array array, int index0, int index1, int index2, object value)
	{
		array.SetValue(value, index0, index1, index2);
	}

	protected static bool TryGetLightLambdaTarget(object instance, out LightLambda lightLambda)
	{
		if (instance is Delegate { Target: Func<object[], object> target })
		{
			lightLambda = target.Target as LightLambda;
			if (lightLambda != null)
			{
				return true;
			}
		}
		lightLambda = null;
		return false;
	}

	protected object InterpretLambdaInvoke(LightLambda targetLambda, object[] args)
	{
		if (ProducedStack > 0)
		{
			return targetLambda.Run(args);
		}
		return targetLambda.RunVoid(args);
	}
}
