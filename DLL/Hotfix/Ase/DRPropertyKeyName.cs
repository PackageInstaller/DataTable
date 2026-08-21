using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRPropertyKeyName : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, string>[] m_PropertyName;

	public override int Id => m_Id;

	public string PropertyKey { get; private set; }

	public float Scale { get; private set; }

	public string PropertyName { get; private set; }

	public string PropertyName2 { get; private set; }

	public int PropertyNameCount => m_PropertyName.Length;

	public override bool ParseDataRow(string dataRowString, object userData)
	{
		string[] array = dataRowString.Split(DataTableExtension.DataSplitSeparators);
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = array[i].Trim(DataTableExtension.DataTrimSeparators);
		}
		int num = 0;
		num++;
		m_Id = int.Parse(array[num++]);
		PropertyKey = array[num++];
		Scale = float.Parse(array[num++]);
		PropertyName = array[num++];
		PropertyName2 = array[num++];
		num++;
		GeneratePropertyArray();
		return true;
	}

	public override bool ParseDataRow(byte[] dataRowBytes, int startIndex, int length, object userData)
	{
		using (MemoryStream memoryStream = new MemoryStream(dataRowBytes, startIndex, length, writable: false))
		{
			byte[] array = AesXorEncryption.DecryptAllData(memoryStream.ToArray());
			using MemoryStream input = new MemoryStream(array, 0, array.Length, writable: false);
			using BinaryReader binaryReader = new BinaryReader(input, Encoding.UTF8);
			m_Id = binaryReader.Read7BitEncodedInt32();
			PropertyKey = binaryReader.ReadString();
			Scale = binaryReader.ReadSingle();
			PropertyName = binaryReader.ReadString();
			PropertyName2 = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	public string GetPropertyName(int id)
	{
		KeyValuePair<int, string>[] propertyName = m_PropertyName;
		for (int i = 0; i < propertyName.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = propertyName[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetPropertyName with invalid id '{0}'.", id));
	}

	public string GetPropertyNameAt(int index)
	{
		if (index < 0 || index >= m_PropertyName.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetPropertyNameAt with invalid index '{0}'.", index));
		}
		return m_PropertyName[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_PropertyName = new KeyValuePair<int, string>[1]
		{
			new KeyValuePair<int, string>(2, PropertyName2)
		};
	}
}
