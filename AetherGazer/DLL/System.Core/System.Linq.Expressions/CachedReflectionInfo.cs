using System.Dynamic;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal static class CachedReflectionInfo
{
	private static MethodInfo s_String_Format_String_ObjectArray;

	private static ConstructorInfo s_InvalidCastException_Ctor_String;

	private static MethodInfo s_CallSiteOps_SetNotMatched;

	private static MethodInfo s_CallSiteOps_CreateMatchmaker;

	private static MethodInfo s_CallSiteOps_GetMatch;

	private static MethodInfo s_CallSiteOps_ClearMatch;

	private static MethodInfo s_CallSiteOps_UpdateRules;

	private static MethodInfo s_CallSiteOps_GetRules;

	private static MethodInfo s_CallSiteOps_GetRuleCache;

	private static MethodInfo s_CallSiteOps_GetCachedRules;

	private static MethodInfo s_CallSiteOps_AddRule;

	private static MethodInfo s_CallSiteOps_MoveRule;

	private static MethodInfo s_CallSiteOps_Bind;

	private static MethodInfo s_DynamicObject_TryGetMember;

	private static MethodInfo s_DynamicObject_TrySetMember;

	private static MethodInfo s_DynamicObject_TryDeleteMember;

	private static MethodInfo s_DynamicObject_TryGetIndex;

	private static MethodInfo s_DynamicObject_TrySetIndex;

	private static MethodInfo s_DynamicObject_TryDeleteIndex;

	private static MethodInfo s_DynamicObject_TryConvert;

	private static MethodInfo s_DynamicObject_TryInvoke;

	private static MethodInfo s_DynamicObject_TryInvokeMember;

	private static MethodInfo s_DynamicObject_TryBinaryOperation;

	private static MethodInfo s_DynamicObject_TryUnaryOperation;

	private static MethodInfo s_DynamicObject_TryCreateInstance;

	private static MethodInfo s_String_op_Equality_String_String;

	private static MethodInfo s_Object_GetType;

	private static MethodInfo s_Math_Pow_Double_Double;

	public static MethodInfo String_Format_String_ObjectArray => s_String_Format_String_ObjectArray ?? (s_String_Format_String_ObjectArray = typeof(string).GetMethod("Format", new Type[2]
	{
		typeof(string),
		typeof(object[])
	}));

	public static ConstructorInfo InvalidCastException_Ctor_String => s_InvalidCastException_Ctor_String ?? (s_InvalidCastException_Ctor_String = typeof(InvalidCastException).GetConstructor(new Type[1] { typeof(string) }));

	public static MethodInfo CallSiteOps_SetNotMatched => s_CallSiteOps_SetNotMatched ?? (s_CallSiteOps_SetNotMatched = typeof(CallSiteOps).GetMethod("SetNotMatched"));

	public static MethodInfo CallSiteOps_CreateMatchmaker => s_CallSiteOps_CreateMatchmaker ?? (s_CallSiteOps_CreateMatchmaker = typeof(CallSiteOps).GetMethod("CreateMatchmaker"));

	public static MethodInfo CallSiteOps_GetMatch => s_CallSiteOps_GetMatch ?? (s_CallSiteOps_GetMatch = typeof(CallSiteOps).GetMethod("GetMatch"));

	public static MethodInfo CallSiteOps_ClearMatch => s_CallSiteOps_ClearMatch ?? (s_CallSiteOps_ClearMatch = typeof(CallSiteOps).GetMethod("ClearMatch"));

	public static MethodInfo CallSiteOps_UpdateRules => s_CallSiteOps_UpdateRules ?? (s_CallSiteOps_UpdateRules = typeof(CallSiteOps).GetMethod("UpdateRules"));

	public static MethodInfo CallSiteOps_GetRules => s_CallSiteOps_GetRules ?? (s_CallSiteOps_GetRules = typeof(CallSiteOps).GetMethod("GetRules"));

	public static MethodInfo CallSiteOps_GetRuleCache => s_CallSiteOps_GetRuleCache ?? (s_CallSiteOps_GetRuleCache = typeof(CallSiteOps).GetMethod("GetRuleCache"));

	public static MethodInfo CallSiteOps_GetCachedRules => s_CallSiteOps_GetCachedRules ?? (s_CallSiteOps_GetCachedRules = typeof(CallSiteOps).GetMethod("GetCachedRules"));

	public static MethodInfo CallSiteOps_AddRule => s_CallSiteOps_AddRule ?? (s_CallSiteOps_AddRule = typeof(CallSiteOps).GetMethod("AddRule"));

	public static MethodInfo CallSiteOps_MoveRule => s_CallSiteOps_MoveRule ?? (s_CallSiteOps_MoveRule = typeof(CallSiteOps).GetMethod("MoveRule"));

	public static MethodInfo CallSiteOps_Bind => s_CallSiteOps_Bind ?? (s_CallSiteOps_Bind = typeof(CallSiteOps).GetMethod("Bind"));

	public static MethodInfo DynamicObject_TryGetMember => s_DynamicObject_TryGetMember ?? (s_DynamicObject_TryGetMember = typeof(DynamicObject).GetMethod("TryGetMember"));

	public static MethodInfo DynamicObject_TrySetMember => s_DynamicObject_TrySetMember ?? (s_DynamicObject_TrySetMember = typeof(DynamicObject).GetMethod("TrySetMember"));

	public static MethodInfo DynamicObject_TryDeleteMember => s_DynamicObject_TryDeleteMember ?? (s_DynamicObject_TryDeleteMember = typeof(DynamicObject).GetMethod("TryDeleteMember"));

	public static MethodInfo DynamicObject_TryGetIndex => s_DynamicObject_TryGetIndex ?? (s_DynamicObject_TryGetIndex = typeof(DynamicObject).GetMethod("TryGetIndex"));

	public static MethodInfo DynamicObject_TrySetIndex => s_DynamicObject_TrySetIndex ?? (s_DynamicObject_TrySetIndex = typeof(DynamicObject).GetMethod("TrySetIndex"));

	public static MethodInfo DynamicObject_TryDeleteIndex => s_DynamicObject_TryDeleteIndex ?? (s_DynamicObject_TryDeleteIndex = typeof(DynamicObject).GetMethod("TryDeleteIndex"));

	public static MethodInfo DynamicObject_TryConvert => s_DynamicObject_TryConvert ?? (s_DynamicObject_TryConvert = typeof(DynamicObject).GetMethod("TryConvert"));

	public static MethodInfo DynamicObject_TryInvoke => s_DynamicObject_TryInvoke ?? (s_DynamicObject_TryInvoke = typeof(DynamicObject).GetMethod("TryInvoke"));

	public static MethodInfo DynamicObject_TryInvokeMember => s_DynamicObject_TryInvokeMember ?? (s_DynamicObject_TryInvokeMember = typeof(DynamicObject).GetMethod("TryInvokeMember"));

	public static MethodInfo DynamicObject_TryBinaryOperation => s_DynamicObject_TryBinaryOperation ?? (s_DynamicObject_TryBinaryOperation = typeof(DynamicObject).GetMethod("TryBinaryOperation"));

	public static MethodInfo DynamicObject_TryUnaryOperation => s_DynamicObject_TryUnaryOperation ?? (s_DynamicObject_TryUnaryOperation = typeof(DynamicObject).GetMethod("TryUnaryOperation"));

	public static MethodInfo DynamicObject_TryCreateInstance => s_DynamicObject_TryCreateInstance ?? (s_DynamicObject_TryCreateInstance = typeof(DynamicObject).GetMethod("TryCreateInstance"));

	public static MethodInfo String_op_Equality_String_String => s_String_op_Equality_String_String ?? (s_String_op_Equality_String_String = typeof(string).GetMethod("op_Equality", new Type[2]
	{
		typeof(string),
		typeof(string)
	}));

	public static MethodInfo Object_GetType => s_Object_GetType ?? (s_Object_GetType = typeof(object).GetMethod("GetType"));

	public static MethodInfo Math_Pow_Double_Double => s_Math_Pow_Double_Double ?? (s_Math_Pow_Double_Double = typeof(Math).GetMethod("Pow", new Type[2]
	{
		typeof(double),
		typeof(double)
	}));
}
