using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRScreenSettings : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, int>[] m_Value;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int Value1 { get; private set; }

	public int Value2 { get; private set; }

	public int Value3 { get; private set; }

	public int ValueCount => m_Value.Length;

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
		Name = array[num++];
		Value1 = int.Parse(array[num++]);
		Value2 = int.Parse(array[num++]);
		Value3 = int.Parse(array[num++]);
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
			Name = binaryReader.ReadString();
			Value1 = binaryReader.Read7BitEncodedInt32();
			Value2 = binaryReader.Read7BitEncodedInt32();
			Value3 = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	public int GetValue(int id)
	{
		KeyValuePair<int, int>[] value = m_Value;
		for (int i = 0; i < value.Length; i++)
		{
			KeyValuePair<int, int> keyValuePair = value[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetValue with invalid id '{0}'.", id));
	}

	public int GetValueAt(int index)
	{
		if (index < 0 || index >= m_Value.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetValueAt with invalid index '{0}'.", index));
		}
		return m_Value[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_Value = new KeyValuePair<int, int>[3]
		{
			new KeyValuePair<int, int>(1, Value1),
			new KeyValuePair<int, int>(2, Value2),
			new KeyValuePair<int, int>(3, Value3)
		};
	}
}
