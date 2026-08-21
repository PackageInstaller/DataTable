using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMonsterTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string TaskName { get; private set; }

	public int TaskType { get; private set; }

	public int TaskTargetType { get; private set; }

	public List<int> TargetIdList { get; private set; }

	public int TargetValue { get; private set; }

	public int TargetLevelId { get; private set; }

	public string MapDataAssetPath { get; private set; }

	public List<int> MapDataUsedAreaIds { get; private set; }

	public int MapDataLevel { get; private set; }

	public int MonsterID { get; private set; }

	public List<List<float>> MonsterPosition { get; private set; }

	public int Priority { get; private set; }

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
		TaskName = array[num++];
		TaskType = int.Parse(array[num++]);
		TaskTargetType = int.Parse(array[num++]);
		TargetIdList = DataTableExtension.ParseListInt(array[num++]);
		TargetValue = int.Parse(array[num++]);
		TargetLevelId = int.Parse(array[num++]);
		MapDataAssetPath = array[num++];
		MapDataUsedAreaIds = DataTableExtension.ParseListInt(array[num++]);
		MapDataLevel = int.Parse(array[num++]);
		MonsterID = int.Parse(array[num++]);
		MonsterPosition = DataTableExtension.ParseListFloatList(array[num++]);
		Priority = int.Parse(array[num++]);
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
			TaskName = binaryReader.ReadString();
			TaskType = binaryReader.Read7BitEncodedInt32();
			TaskTargetType = binaryReader.Read7BitEncodedInt32();
			TargetIdList = binaryReader.ReadListInt();
			TargetValue = binaryReader.Read7BitEncodedInt32();
			TargetLevelId = binaryReader.Read7BitEncodedInt32();
			MapDataAssetPath = binaryReader.ReadString();
			MapDataUsedAreaIds = binaryReader.ReadListInt();
			MapDataLevel = binaryReader.Read7BitEncodedInt32();
			MonsterID = binaryReader.Read7BitEncodedInt32();
			MonsterPosition = binaryReader.ReadListFloatList();
			Priority = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
