using System;
using System.ComponentModel;

namespace ES3Internal;

internal class ES3CacheWriter : ES3Writer
{
	private ES3File es3File;

	internal ES3CacheWriter(ES3Settings settings, bool writeHeaderAndFooter, bool mergeKeys)
		: base(settings, writeHeaderAndFooter, mergeKeys)
	{
		es3File = new ES3File(settings);
	}

	public override void Write<T>(string key, object value)
	{
		es3File.Save(key, (T)value);
	}

	internal override void Write(string key, Type type, byte[] value)
	{
		ES3Debug.LogError("Not implemented");
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public override void Write(Type type, string key, object value)
	{
		es3File.Save(key, value);
	}

	internal override void WritePrimitive(int value)
	{
	}

	internal override void WritePrimitive(float value)
	{
	}

	internal override void WritePrimitive(bool value)
	{
	}

	internal override void WritePrimitive(decimal value)
	{
	}

	internal override void WritePrimitive(double value)
	{
	}

	internal override void WritePrimitive(long value)
	{
	}

	internal override void WritePrimitive(ulong value)
	{
	}

	internal override void WritePrimitive(uint value)
	{
	}

	internal override void WritePrimitive(byte value)
	{
	}

	internal override void WritePrimitive(sbyte value)
	{
	}

	internal override void WritePrimitive(short value)
	{
	}

	internal override void WritePrimitive(ushort value)
	{
	}

	internal override void WritePrimitive(char value)
	{
	}

	internal override void WritePrimitive(byte[] value)
	{
	}

	internal override void WritePrimitive(string value)
	{
	}

	internal override void WriteNull()
	{
	}

	private static bool CharacterRequiresEscaping(char c)
	{
		return false;
	}

	private void WriteCommaIfRequired()
	{
	}

	internal override void WriteRawProperty(string name, byte[] value)
	{
	}

	internal override void StartWriteFile()
	{
	}

	internal override void EndWriteFile()
	{
	}

	internal override void StartWriteProperty(string name)
	{
		base.StartWriteProperty(name);
	}

	internal override void EndWriteProperty(string name)
	{
	}

	internal override void StartWriteObject(string name)
	{
	}

	internal override void EndWriteObject(string name)
	{
	}

	internal override void StartWriteCollection()
	{
	}

	internal override void EndWriteCollection()
	{
	}

	internal override void StartWriteCollectionItem(int index)
	{
	}

	internal override void EndWriteCollectionItem(int index)
	{
	}

	internal override void StartWriteDictionary()
	{
	}

	internal override void EndWriteDictionary()
	{
	}

	internal override void StartWriteDictionaryKey(int index)
	{
	}

	internal override void EndWriteDictionaryKey(int index)
	{
	}

	internal override void StartWriteDictionaryValue(int index)
	{
	}

	internal override void EndWriteDictionaryValue(int index)
	{
	}

	public override void Dispose()
	{
	}
}
