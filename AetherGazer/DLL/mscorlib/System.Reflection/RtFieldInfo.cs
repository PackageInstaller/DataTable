using System.Globalization;

namespace System.Reflection;

internal abstract class RtFieldInfo : FieldInfo
{
	internal abstract object UnsafeGetValue(object obj);

	internal abstract void UnsafeSetValue(object obj, object value, BindingFlags invokeAttr, Binder binder, CultureInfo culture);

	internal abstract void CheckConsistency(object target);
}
