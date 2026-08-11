using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBuildingLevelInfo : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int BuildingId { get; private set; }

	public int Level { get; private set; }

	public int HomelandLevelNeed { get; private set; }

	public List<int> NeedItem { get; private set; }

	public List<int> NeedItemCount { get; private set; }

	public int MoneyNeed { get; private set; }

	public List<int> UpgradeEffectId { get; private set; }

	public List<float> UpgradeEffectVal { get; private set; }

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
		BuildingId = int.Parse(array[num++]);
		Level = int.Parse(array[num++]);
		HomelandLevelNeed = int.Parse(array[num++]);
		NeedItem = DataTableExtension.ParseListInt(array[num++]);
		NeedItemCount = DataTableExtension.ParseListInt(array[num++]);
		MoneyNeed = int.Parse(array[num++]);
		UpgradeEffectId = DataTableExtension.ParseListInt(array[num++]);
		UpgradeEffectVal = DataTableExtension.ParseListFloat(array[num++]);
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
			BuildingId = binaryReader.Read7BitEncodedInt32();
			Level = binaryReader.Read7BitEncodedInt32();
			HomelandLevelNeed = binaryReader.Read7BitEncodedInt32();
			NeedItem = binaryReader.ReadListInt();
			NeedItemCount = binaryReader.ReadListInt();
			MoneyNeed = binaryReader.Read7BitEncodedInt32();
			UpgradeEffectId = binaryReader.ReadListInt();
			UpgradeEffectVal = binaryReader.ReadListFloat();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
