using System;
using System.ComponentModel;

namespace Sirenix.Serialization;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
[Obsolete("Use [HideInInspector] instead - it now also excludes the member completely from becoming a property in the property tree.", false)]
[EditorBrowsable(EditorBrowsableState.Never)]
public sealed class ExcludeDataFromInspectorAttribute : Attribute
{
}
