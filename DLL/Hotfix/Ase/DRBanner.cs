using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBanner : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string LittleImg { get; private set; }

	public int Sort { get; private set; }

	public string Img { get; private set; }

	public int Weight { get; private set; }

	public string StartTime { get; private set; }

	public string EndTime { get; private set; }

	public int OnCondition { get; private set; }

	public int OnConfig { get; private set; }

	public int OffCondition { get; private set; }

	public int OffConfig { get; private set; }

	public List<int> SpCondition { get; private set; }

	public List<int> SpConfig { get; private set; }

	public int SpCd { get; private set; }

	public string JumpWindow { get; private set; }

	public List<int> JumpConfig { get; private set; }

	public string JumpWeb { get; private set; }

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
		LittleImg = array[num++];
		Sort = int.Parse(array[num++]);
		Img = array[num++];
		Weight = int.Parse(array[num++]);
		StartTime = array[num++];
		EndTime = array[num++];
		OnCondition = int.Parse(array[num++]);
		OnConfig = int.Parse(array[num++]);
		OffCondition = int.Parse(array[num++]);
		OffConfig = int.Parse(array[num++]);
		SpCondition = DataTableExtension.ParseListInt(array[num++]);
		SpConfig = DataTableExtension.ParseListInt(array[num++]);
		SpCd = int.Parse(array[num++]);
		JumpWindow = array[num++];
		JumpConfig = DataTableExtension.ParseListInt(array[num++]);
		JumpWeb = array[num++];
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
			LittleImg = binaryReader.ReadString();
			Sort = binaryReader.Read7BitEncodedInt32();
			Img = binaryReader.ReadString();
			Weight = binaryReader.Read7BitEncodedInt32();
			StartTime = binaryReader.ReadString();
			EndTime = binaryReader.ReadString();
			OnCondition = binaryReader.Read7BitEncodedInt32();
			OnConfig = binaryReader.Read7BitEncodedInt32();
			OffCondition = binaryReader.Read7BitEncodedInt32();
			OffConfig = binaryReader.Read7BitEncodedInt32();
			SpCondition = binaryReader.ReadListInt();
			SpConfig = binaryReader.ReadListInt();
			SpCd = binaryReader.Read7BitEncodedInt32();
			JumpWindow = binaryReader.ReadString();
			JumpConfig = binaryReader.ReadListInt();
			JumpWeb = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
