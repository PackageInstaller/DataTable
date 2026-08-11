using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRFarmSeed : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int OpenIndex { get; private set; }

	public string Name { get; private set; }

	public int Rarity { get; private set; }

	public string Icon { get; private set; }

	public int Product { get; private set; }

	public List<int> ProductCount { get; private set; }

	public int HarvestTime { get; private set; }

	public int UnlockType { get; private set; }

	public int UnlockTypeEx { get; private set; }

	public int FriendReward { get; private set; }

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
		OpenIndex = int.Parse(array[num++]);
		Name = array[num++];
		Rarity = int.Parse(array[num++]);
		Icon = array[num++];
		Product = int.Parse(array[num++]);
		ProductCount = DataTableExtension.ParseListInt(array[num++]);
		HarvestTime = int.Parse(array[num++]);
		UnlockType = int.Parse(array[num++]);
		UnlockTypeEx = int.Parse(array[num++]);
		FriendReward = int.Parse(array[num++]);
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
			OpenIndex = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Rarity = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			Product = binaryReader.Read7BitEncodedInt32();
			ProductCount = binaryReader.ReadListInt();
			HarvestTime = binaryReader.Read7BitEncodedInt32();
			UnlockType = binaryReader.Read7BitEncodedInt32();
			UnlockTypeEx = binaryReader.Read7BitEncodedInt32();
			FriendReward = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
