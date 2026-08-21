using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBranchTimeLineNote : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TimeLineId { get; private set; }

	public string PrePath { get; private set; }

	public string TimeIconForMale { get; private set; }

	public string TimeIconForFemale { get; private set; }

	public int Type { get; private set; }

	public int Chapter { get; private set; }

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
		TimeLineId = int.Parse(array[num++]);
		PrePath = array[num++];
		TimeIconForMale = array[num++];
		TimeIconForFemale = array[num++];
		Type = int.Parse(array[num++]);
		Chapter = int.Parse(array[num++]);
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
			TimeLineId = binaryReader.Read7BitEncodedInt32();
			PrePath = binaryReader.ReadString();
			TimeIconForMale = binaryReader.ReadString();
			TimeIconForFemale = binaryReader.ReadString();
			Type = binaryReader.Read7BitEncodedInt32();
			Chapter = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
