using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRProp : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, int>[] m_EX;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int Quality { get; private set; }

	public string Desc { get; private set; }

	public int Type { get; private set; }

	public string Icon { get; private set; }

	public int Sort { get; private set; }

	public int MaxCount { get; private set; }

	public int DropId { get; private set; }

	public List<int> UseType { get; private set; }

	public int EX1 { get; private set; }

	public string Function { get; private set; }

	public List<string> SourceName { get; private set; }

	public List<string> SourceWindow { get; private set; }

	public List<List<int>> SourceParams { get; private set; }

	public string Title { get; private set; }

	public string Content { get; private set; }

	public string Illustration { get; private set; }

	public int ItemType { get; private set; }

	public int TimeLimited { get; private set; }

	public string Time { get; private set; }

	public int EXCount => m_EX.Length;

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
		Quality = int.Parse(array[num++]);
		Desc = array[num++];
		Type = int.Parse(array[num++]);
		Icon = array[num++];
		Sort = int.Parse(array[num++]);
		MaxCount = int.Parse(array[num++]);
		DropId = int.Parse(array[num++]);
		UseType = DataTableExtension.ParseListInt(array[num++]);
		EX1 = int.Parse(array[num++]);
		Function = array[num++];
		SourceName = DataTableExtension.ParseListString(array[num++]);
		SourceWindow = DataTableExtension.ParseListString(array[num++]);
		SourceParams = DataTableExtension.ParseListIntList(array[num++]);
		Title = array[num++];
		Content = array[num++];
		Illustration = array[num++];
		ItemType = int.Parse(array[num++]);
		TimeLimited = int.Parse(array[num++]);
		Time = array[num++];
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
			Quality = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
			Type = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			Sort = binaryReader.Read7BitEncodedInt32();
			MaxCount = binaryReader.Read7BitEncodedInt32();
			DropId = binaryReader.Read7BitEncodedInt32();
			UseType = binaryReader.ReadListInt();
			EX1 = binaryReader.Read7BitEncodedInt32();
			Function = binaryReader.ReadString();
			SourceName = binaryReader.ReadListString();
			SourceWindow = binaryReader.ReadListString();
			SourceParams = binaryReader.ReadListIntList();
			Title = binaryReader.ReadString();
			Content = binaryReader.ReadString();
			Illustration = binaryReader.ReadString();
			ItemType = binaryReader.Read7BitEncodedInt32();
			TimeLimited = binaryReader.Read7BitEncodedInt32();
			Time = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	public int GetEX(int id)
	{
		KeyValuePair<int, int>[] eX = m_EX;
		for (int i = 0; i < eX.Length; i++)
		{
			KeyValuePair<int, int> keyValuePair = eX[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetEX with invalid id '{0}'.", id));
	}

	public int GetEXAt(int index)
	{
		if (index < 0 || index >= m_EX.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetEXAt with invalid index '{0}'.", index));
		}
		return m_EX[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_EX = new KeyValuePair<int, int>[1]
		{
			new KeyValuePair<int, int>(1, EX1)
		};
	}
}
