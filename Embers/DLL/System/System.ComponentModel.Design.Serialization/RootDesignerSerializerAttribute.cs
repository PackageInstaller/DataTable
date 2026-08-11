using System.Runtime.CompilerServices;

namespace System.ComponentModel.Design.Serialization;

[Obsolete("This attribute has been deprecated. Use DesignerSerializerAttribute instead.  For example, to specify a root designer for CodeDom, use DesignerSerializerAttribute(...,typeof(TypeCodeDomSerializer)).  https://go.microsoft.com/fwlink/?linkid=14202")]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Interface, AllowMultiple = true, Inherited = true)]
public sealed class RootDesignerSerializerAttribute : Attribute
{
	private string _typeId;

	[CompilerGenerated]
	private readonly bool _003CReloadable_003Ek__BackingField;

	[CompilerGenerated]
	private readonly string _003CSerializerTypeName_003Ek__BackingField;

	public string SerializerBaseTypeName { get; }

	public override object TypeId
	{
		get
		{
			if (_typeId == null)
			{
				string text = SerializerBaseTypeName;
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

	public RootDesignerSerializerAttribute(string serializerTypeName, string baseSerializerTypeName, bool reloadable)
	{
		_003CSerializerTypeName_003Ek__BackingField = serializerTypeName;
		SerializerBaseTypeName = baseSerializerTypeName;
		_003CReloadable_003Ek__BackingField = reloadable;
	}
}
