using System;

namespace Sirenix.Serialization;

public sealed class TypeFormatter : MinimalBaseFormatter<Type>
{
	protected override void Read(ref Type value, IDataReader reader)
	{
		if (reader.PeekEntry(out var name) == EntryType.String)
		{
			reader.ReadString(out name);
			value = reader.Context.Binder.BindToType(name, reader.Context.Config.DebugContext);
			if (value != null)
			{
				RegisterReferenceID(value, reader);
			}
		}
	}

	protected override void Write(ref Type value, IDataWriter writer)
	{
		writer.WriteString(null, writer.Context.Binder.BindToName(value, writer.Context.Config.DebugContext));
	}

	protected override Type GetUninitializedObject()
	{
		return null;
	}
}
