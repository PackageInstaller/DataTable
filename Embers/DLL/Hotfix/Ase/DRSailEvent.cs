using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSailEvent : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int Area { get; private set; }

	public int Rarity { get; private set; }

	public string Desc { get; private set; }

	public int Time { get; private set; }

	public int TaskId { get; private set; }

	public int SailLightLevelNeed { get; private set; }

	public List<int> Hero { get; private set; }

	public int Odds { get; private set; }

	public List<int> RewardUI { get; private set; }

	public List<int> RewardNumUI { get; private set; }

	public List<int> GreatRewardUI { get; private set; }

	public List<int> GreatRewardNumUI { get; private set; }

	public int Reward { get; private set; }

	public int GreatReward { get; private set; }

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
		Area = int.Parse(array[num++]);
		Rarity = int.Parse(array[num++]);
		Desc = array[num++];
		Time = int.Parse(array[num++]);
		TaskId = int.Parse(array[num++]);
		SailLightLevelNeed = int.Parse(array[num++]);
		Hero = DataTableExtension.ParseListInt(array[num++]);
		Odds = int.Parse(array[num++]);
		RewardUI = DataTableExtension.ParseListInt(array[num++]);
		RewardNumUI = DataTableExtension.ParseListInt(array[num++]);
		GreatRewardUI = DataTableExtension.ParseListInt(array[num++]);
		GreatRewardNumUI = DataTableExtension.ParseListInt(array[num++]);
		Reward = int.Parse(array[num++]);
		GreatReward = int.Parse(array[num++]);
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
			Area = binaryReader.Read7BitEncodedInt32();
			Rarity = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
			Time = binaryReader.Read7BitEncodedInt32();
			TaskId = binaryReader.Read7BitEncodedInt32();
			SailLightLevelNeed = binaryReader.Read7BitEncodedInt32();
			Hero = binaryReader.ReadListInt();
			Odds = binaryReader.Read7BitEncodedInt32();
			RewardUI = binaryReader.ReadListInt();
			RewardNumUI = binaryReader.ReadListInt();
			GreatRewardUI = binaryReader.ReadListInt();
			GreatRewardNumUI = binaryReader.ReadListInt();
			Reward = binaryReader.Read7BitEncodedInt32();
			GreatReward = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
