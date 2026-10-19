using System.Globalization;

namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public sealed class EditorAttribute : Attribute
{
	private string _typeId;

	public string EditorBaseTypeName { get; }

	public string EditorTypeName { get; }

	public override object TypeId
	{
		get
		{
			if (_typeId == null)
			{
				string text = EditorBaseTypeName;
				int num = text.IndexOf(',');
				if (num != -1)
				{
					text = text.Substring(0, num);
				}
				_typeId = GetType().FullName + text;
			}
			return _typeId;
		}
	}

	public EditorAttribute(string typeName, string baseTypeName)
	{
		typeName.ToUpper(CultureInfo.InvariantCulture);
		EditorTypeName = typeName;
		EditorBaseTypeName = baseTypeName;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj is EditorAttribute editorAttribute && editorAttribute.EditorTypeName == EditorTypeName)
		{
			return editorAttribute.EditorBaseTypeName == EditorBaseTypeName;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}
}
