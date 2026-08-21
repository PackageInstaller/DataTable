using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGameScore : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public bool IsShare { get; private set; }

	public int Type { get; private set; }

	public int Day { get; private set; }

	public List<int> EventId { get; private set; }

	public string Title { get; private set; }

	public string Content { get; private set; }

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
		IsShare = bool.Parse(array[num++]);
		Type = int.Parse(array[num++]);
		Day = int.Parse(array[num++]);
		EventId = DataTableExtension.ParseListInt(array[num++]);
		Title = array[num++];
		Content = array[num++];
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
			IsShare = binaryReader.ReadBoolean();
			Type = binaryReader.Read7BitEncodedInt32();
			Day = binaryReader.Read7BitEncodedInt32();
			EventId = binaryReader.ReadListInt();
			Title = binaryReader.ReadString();
			Content = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
