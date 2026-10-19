using System;
using System.Collections.Generic;
using System.Reflection;
using JetBrains.Annotations;
using Unity.VisualScripting.FullSerializer.Internal;

namespace Unity.VisualScripting.FullSerializer;

public class fsConverterRegistrar
{
	public static AnimationCurve_DirectConverter Register_AnimationCurve_DirectConverter;

	public static Bounds_DirectConverter Register_Bounds_DirectConverter;

	public static Gradient_DirectConverter Register_Gradient_DirectConverter;

	public static GUIStyleState_DirectConverter Register_GUIStyleState_DirectConverter;

	public static GUIStyle_DirectConverter Register_GUIStyle_DirectConverter;

	[UsedImplicitly]
	public static InputAction_DirectConverter Register_InputAction_DirectConverter;

	public static Keyframe_DirectConverter Register_Keyframe_DirectConverter;

	public static LayerMask_DirectConverter Register_LayerMask_DirectConverter;

	public static RectOffset_DirectConverter Register_RectOffset_DirectConverter;

	public static Rect_DirectConverter Register_Rect_DirectConverter;

	public static List<Type> Converters;

	static fsConverterRegistrar()
	{
		Converters = new List<Type>();
		FieldInfo[] declaredFields = typeof(fsConverterRegistrar).GetDeclaredFields();
		foreach (FieldInfo fieldInfo in declaredFields)
		{
			if (fieldInfo.Name.StartsWith("Register_"))
			{
				Converters.Add(fieldInfo.FieldType);
			}
		}
		MethodInfo[] declaredMethods = typeof(fsConverterRegistrar).GetDeclaredMethods();
		foreach (MethodInfo methodInfo in declaredMethods)
		{
			if (methodInfo.Name.StartsWith("Register_"))
			{
				methodInfo.Invoke(null, null);
			}
		}
	}
}
