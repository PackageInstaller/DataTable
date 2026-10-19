using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal static class CachedReflectionInfo
{
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

	private static MethodInfo s_String_op_Equality_String_String;

	private static MethodInfo s_Math_Pow_Double_Double;

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

	public static MethodInfo String_op_Equality_String_String => s_String_op_Equality_String_String ?? (s_String_op_Equality_String_String = typeof(string).GetMethod("op_Equality", new Type[2]
	{
		typeof(string),
		typeof(string)
	}));

	public static MethodInfo Math_Pow_Double_Double => s_Math_Pow_Double_Double ?? (s_Math_Pow_Double_Double = typeof(Math).GetMethod("Pow", new Type[2]
	{
		typeof(double),
		typeof(double)
	}));
}
