using System;
using System.Collections.Generic;
using System.Reflection;
using ParadoxNotion;

namespace FlowCanvas.Nodes;

public static class ReflectedNodesHelper
{
	private const string RETURN_VALUE_NAME = "Value";

	public static ParamDef GetGetterDefFromInfo(MemberInfo info)
	{
		ParamDef result = new ParamDef
		{
			presentedInfo = info,
			paramMode = ParamMode.Undefined
		};
		if (info != null)
		{
			result.paramMode = ParamMode.Out;
			MethodInfo methodInfo = info as MethodInfo;
			if (methodInfo != null)
			{
				string text = methodInfo.Name;
				if (text.StartsWith("get_"))
				{
					text = text.Substring("get_".Length);
				}
				result.portName = text;
				result.paramType = methodInfo.ReturnType;
			}
			FieldInfo fieldInfo = info as FieldInfo;
			if (fieldInfo != null)
			{
				result.portName = fieldInfo.Name;
				result.paramType = fieldInfo.FieldType;
			}
		}
		return result;
	}

	public static ParamDef GetDefFromInfo(ParameterInfo info, bool last)
	{
		ParamDef result = default(ParamDef);
		if (info != null)
		{
			Type parameterType = info.ParameterType;
			bool flag = false;
			if (last && parameterType.RTIsArray())
			{
				flag = info.IsDefined(typeof(ParamArrayAttribute), inherit: false);
			}
			Type type = parameterType.RTGetElementType();
			if (flag)
			{
				result.arrayType = parameterType.GetEnumerableElementType();
			}
			result.isParamsArray = flag;
			Type paramType = ((parameterType.RTIsByRef() && type != null) ? type : parameterType);
			result.paramType = paramType;
			if (info.IsOut && parameterType.RTIsByRef())
			{
				result.paramMode = ParamMode.Out;
			}
			else if (!info.IsOut && info.ParameterType.RTIsByRef())
			{
				result.paramMode = ParamMode.Ref;
			}
			else
			{
				result.paramMode = ParamMode.In;
			}
			result.portName = info.Name;
		}
		return result;
	}

	public static bool InitParams(Type targetType, bool isStatic, MemberInfo[] infos, out ParametresDef parametres)
	{
		parametres = default(ParametresDef);
		if (targetType == null)
		{
			return false;
		}
		parametres = new ParametresDef
		{
			paramDefinitions = new List<ParamDef>()
		};
		if (!isStatic)
		{
			parametres.resultDef = new ParamDef
			{
				paramMode = ParamMode.Undefined
			};
			parametres.instanceDef = new ParamDef
			{
				paramType = targetType,
				portName = targetType.FriendlyName(),
				portId = "Instance",
				paramMode = ParamMode.Instance
			};
		}
		for (int i = 0; i <= infos.Length - 1; i++)
		{
			ParamDef getterDefFromInfo = GetGetterDefFromInfo(infos[i]);
			if (getterDefFromInfo.paramMode != ParamMode.Undefined)
			{
				parametres.paramDefinitions.Add(getterDefFromInfo);
			}
		}
		return true;
	}

	private static bool InitParams(ParameterInfo[] prms, Type returnType, ref ParametresDef parametres)
	{
		bool flag = false;
		for (int i = 0; i <= prms.Length - 1; i++)
		{
			ParamDef defFromInfo = GetDefFromInfo(prms[i], i == prms.Length - 1);
			if (defFromInfo.portName == "Value" && !flag)
			{
				flag = true;
			}
			if (parametres.instanceDef.paramMode != ParamMode.Undefined && defFromInfo.portName == parametres.instanceDef.portName && (defFromInfo.paramMode == ParamMode.In || defFromInfo.paramMode == ParamMode.Ref || defFromInfo.paramMode == ParamMode.Out))
			{
				defFromInfo.portId = defFromInfo.portName + " ";
			}
			parametres.paramDefinitions.Add(defFromInfo);
		}
		if (returnType != typeof(void))
		{
			parametres.resultDef.paramType = returnType;
			parametres.resultDef.portName = "Value";
			parametres.resultDef.portId = (flag ? "*Value" : null);
			parametres.resultDef.paramMode = ParamMode.Result;
		}
		return true;
	}

	public static bool InitParams(ConstructorInfo constructor, out ParametresDef parametres)
	{
		parametres = new ParametresDef
		{
			paramDefinitions = new List<ParamDef>(),
			instanceDef = new ParamDef
			{
				paramMode = ParamMode.Undefined
			},
			resultDef = new ParamDef
			{
				paramMode = ParamMode.Undefined
			}
		};
		if (constructor == null || constructor.ContainsGenericParameters || constructor.IsGenericMethodDefinition)
		{
			return false;
		}
		ParameterInfo[] parameters = constructor.GetParameters();
		Type returnType = constructor.RTReflectedType();
		return InitParams(parameters, returnType, ref parametres);
	}

	public static bool InitParams(MethodInfo method, out ParametresDef parametres)
	{
		parametres = new ParametresDef
		{
			paramDefinitions = new List<ParamDef>(),
			instanceDef = new ParamDef
			{
				paramMode = ParamMode.Undefined
			},
			resultDef = new ParamDef
			{
				paramMode = ParamMode.Undefined
			}
		};
		if (method == null || method.ContainsGenericParameters || method.IsGenericMethodDefinition)
		{
			return false;
		}
		ParameterInfo[] parameters = method.GetParameters();
		Type returnType = method.ReturnType;
		if (!method.IsStatic)
		{
			parametres.instanceDef.paramType = method.DeclaringType;
			parametres.instanceDef.portName = method.DeclaringType.FriendlyName();
			parametres.instanceDef.paramMode = ParamMode.Instance;
		}
		return InitParams(parameters, returnType, ref parametres);
	}

	public static bool InitParams(FieldInfo field, out ParametresDef parametres)
	{
		parametres = new ParametresDef
		{
			paramDefinitions = null,
			instanceDef = new ParamDef
			{
				paramMode = ParamMode.Undefined
			},
			resultDef = new ParamDef
			{
				paramMode = ParamMode.Undefined
			}
		};
		if (field == null || field.FieldType.ContainsGenericParameters || field.FieldType.IsGenericTypeDefinition)
		{
			return false;
		}
		if (!field.IsStatic)
		{
			parametres.instanceDef.paramMode = ParamMode.Instance;
			parametres.instanceDef.paramType = field.DeclaringType;
			parametres.instanceDef.portName = field.DeclaringType.FriendlyName();
		}
		parametres.resultDef.paramMode = ParamMode.Result;
		parametres.resultDef.paramType = field.FieldType;
		parametres.resultDef.portName = "Value";
		return true;
	}

	public static string GetGeneratedKey(MemberInfo memberInfo)
	{
		if (memberInfo != null)
		{
			return $"{memberInfo.DeclaringType.FullName} {memberInfo.MemberType} {memberInfo}";
		}
		return string.Empty;
	}
}
