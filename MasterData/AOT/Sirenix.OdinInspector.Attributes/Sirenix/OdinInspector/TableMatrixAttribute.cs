using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false)]
public class TableMatrixAttribute : Attribute
{
	public bool IsReadOnly;

	public bool ResizableColumns = true;

	public string VerticalTitle;

	public string HorizontalTitle;

	public string DrawElementMethod;

	public int RowHeight;

	public bool SquareCells;

	public bool HideColumnIndices;

	public bool HideRowIndices;

	public bool RespectIndentLevel = true;

	public bool Transpose;

	public string Labels;
}
