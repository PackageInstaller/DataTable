using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRActivitySkinGet : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActivityId { get; private set; }

	public new int GetType { get; private set; }

	public string Desc { get; private set; }

	public int UsePropType { get; private set; }

	public int UsePropID { get; private set; }

	public List<int> UseCountGroup { get; private set; }

	public List<int> RewardIdGroup { get; private set; }

	public int PerfactRewardIndex { get; private set; }

	public List<int> ShowType { get; private set; }

	public List<int> ShowID { get; private set; }

	public int ExplainId { get; private set; }

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
		ActivityId = int.Parse(array[num++]);
		GetType = int.Parse(array[num++]);
		Desc = array[num++];
		UsePropType = int.Parse(array[num++]);
		UsePropID = int.Parse(array[num++]);
		UseCountGroup = DataTableExtension.ParseListInt(array[num++]);
		RewardIdGroup = DataTableExtension.ParseListInt(array[num++]);
		PerfactRewardIndex = int.Parse(array[num++]);
		ShowType = DataTableExtension.ParseListInt(array[num++]);
		ShowID = DataTableExtension.ParseListInt(array[num++]);
		ExplainId = int.Parse(array[num++]);
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
			ActivityId = binaryReader.Read7BitEncodedInt32();
			GetType = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
			UsePropType = binaryReader.Read7BitEncodedInt32();
			UsePropID = binaryReader.Read7BitEncodedInt32();
			UseCountGroup = binaryReader.ReadListInt();
			RewardIdGroup = binaryReader.ReadListInt();
			PerfactRewardIndex = binaryReader.Read7BitEncodedInt32();
			ShowType = binaryReader.ReadListInt();
			ShowID = binaryReader.ReadListInt();
			ExplainId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
