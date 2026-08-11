using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRTransferPoint : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string TransferPointName { get; private set; }

	public int LevelId { get; private set; }

	public List<float> TransferPointPos { get; private set; }

	public string Icon { get; private set; }

	public int PointType { get; private set; }

	public string Desc { get; private set; }

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
		TransferPointName = array[num++];
		LevelId = int.Parse(array[num++]);
		TransferPointPos = DataTableExtension.ParseListFloat(array[num++]);
		Icon = array[num++];
		PointType = int.Parse(array[num++]);
		Desc = array[num++];
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
			TransferPointName = binaryReader.ReadString();
			LevelId = binaryReader.Read7BitEncodedInt32();
			TransferPointPos = binaryReader.ReadListFloat();
			Icon = binaryReader.ReadString();
			PointType = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
