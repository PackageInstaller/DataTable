using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class FilePathAttribute : Attribute
{
	public bool AbsolutePath;

	public string Extensions;

	public string ParentFolder;

	[Obsolete("Use RequireExistingPath instead.", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public bool RequireValidPath;

	public bool RequireExistingPath;

	public bool UseBackslashes;

	public bool IncludeFileExtension = true;

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Add a ReadOnly attribute to the property instead.", true)]
	public bool ReadOnly { get; set; }
}
