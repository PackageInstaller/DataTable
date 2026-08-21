using System;
using System.Reflection;

namespace ParadoxNotion.Serialization.FullSerializer;

public class fsMetaProperty
{
	public FieldInfo Field { get; private set; }

	public string JsonName { get; private set; }

	public Type StorageType => Field.FieldType;

	public string MemberName => Field.Name;

	public bool ReadOnly { get; private set; }

	public bool WriteOnly { get; private set; }

	public bool AutoInstance { get; private set; }

	public bool AsReference { get; private set; }

	internal fsMetaProperty(FieldInfo field)
	{
		Field = field;
		fsSerializeAsAttribute fsSerializeAsAttribute2 = Field.RTGetAttribute<fsSerializeAsAttribute>(inherited: true);
		JsonName = ((fsSerializeAsAttribute2 != null && !string.IsNullOrEmpty(fsSerializeAsAttribute2.Name)) ? fsSerializeAsAttribute2.Name : field.Name);
		ReadOnly = Field.RTIsDefined<fsReadOnlyAttribute>(inherited: true);
		WriteOnly = Field.RTIsDefined<fsWriteOnlyAttribute>(inherited: true);
		fsAutoInstance fsAutoInstance2 = StorageType.RTGetAttribute<fsAutoInstance>(inherited: true);
		AutoInstance = fsAutoInstance2 != null && fsAutoInstance2.makeInstance && !StorageType.IsAbstract;
		AsReference = Field.RTIsDefined<fsSerializeAsReference>(inherited: true);
	}

	public object Read(object context)
	{
		return Field.GetValue(context);
	}

	public void Write(object context, object value)
	{
		Field.SetValue(context, value);
	}
}
