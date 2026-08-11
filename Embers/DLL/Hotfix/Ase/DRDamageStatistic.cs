using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRDamageStatistic : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, string>[] m_Name;

	public override int Id => m_Id;

	public string Name1 { get; private set; }

	public string Color { get; private set; }

	public string Name2 { get; private set; }

	public List<string> ColumnName { get; private set; }

	public int NameCount => m_Name.Length;

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
		Name1 = array[num++];
		Color = array[num++];
		Name2 = array[num++];
		ColumnName = DataTableExtension.ParseListString(array[num++]);
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
			Name1 = binaryReader.ReadString();
			Color = binaryReader.ReadString();
			Name2 = binaryReader.ReadString();
			ColumnName = binaryReader.ReadListString();
		}
		GeneratePropertyArray();
		return true;
	}

	public string GetName(int id)
	{
		KeyValuePair<int, string>[] name = m_Name;
		for (int i = 0; i < name.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = name[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetName with invalid id '{0}'.", id));
	}

	public string GetNameAt(int index)
	{
		if (index < 0 || index >= m_Name.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetNameAt with invalid index '{0}'.", index));
		}
		return m_Name[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_Name = new KeyValuePair<int, string>[2]
		{
			new KeyValuePair<int, string>(1, Name1),
			new KeyValuePair<int, string>(2, Name2)
		};
	}
}
