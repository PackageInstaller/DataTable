using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREquipGrade : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TargetLevel { get; private set; }

	public int Rank { get; private set; }

	public int Quality { get; private set; }

	public int NeedGold { get; private set; }

	public int DevourGold { get; private set; }

	public int NeedExp { get; private set; }

	public int DevourExp { get; private set; }

	public int RerollCost { get; private set; }

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
		TargetLevel = int.Parse(array[num++]);
		Rank = int.Parse(array[num++]);
		Quality = int.Parse(array[num++]);
		NeedGold = int.Parse(array[num++]);
		DevourGold = int.Parse(array[num++]);
		NeedExp = int.Parse(array[num++]);
		DevourExp = int.Parse(array[num++]);
		RerollCost = int.Parse(array[num++]);
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
			TargetLevel = binaryReader.Read7BitEncodedInt32();
			Rank = binaryReader.Read7BitEncodedInt32();
			Quality = binaryReader.Read7BitEncodedInt32();
			NeedGold = binaryReader.Read7BitEncodedInt32();
			DevourGold = binaryReader.Read7BitEncodedInt32();
			NeedExp = binaryReader.Read7BitEncodedInt32();
			DevourExp = binaryReader.Read7BitEncodedInt32();
			RerollCost = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
