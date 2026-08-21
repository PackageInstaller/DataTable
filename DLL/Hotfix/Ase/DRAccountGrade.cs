using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRAccountGrade : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int NeedExp { get; private set; }

	public List<int> Reward { get; private set; }

	public List<int> RewardNum { get; private set; }

	public int EnergyMax { get; private set; }

	public int EnergyLimit { get; private set; }

	public int EnergyRecovery { get; private set; }

	public string RankDesc { get; private set; }

	public int Rank { get; private set; }

	public List<string> FunctionOpen { get; private set; }

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
		NeedExp = int.Parse(array[num++]);
		Reward = DataTableExtension.ParseListInt(array[num++]);
		RewardNum = DataTableExtension.ParseListInt(array[num++]);
		EnergyMax = int.Parse(array[num++]);
		EnergyLimit = int.Parse(array[num++]);
		EnergyRecovery = int.Parse(array[num++]);
		RankDesc = array[num++];
		Rank = int.Parse(array[num++]);
		FunctionOpen = DataTableExtension.ParseListString(array[num++]);
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
			NeedExp = binaryReader.Read7BitEncodedInt32();
			Reward = binaryReader.ReadListInt();
			RewardNum = binaryReader.ReadListInt();
			EnergyMax = binaryReader.Read7BitEncodedInt32();
			EnergyLimit = binaryReader.Read7BitEncodedInt32();
			EnergyRecovery = binaryReader.Read7BitEncodedInt32();
			RankDesc = binaryReader.ReadString();
			Rank = binaryReader.Read7BitEncodedInt32();
			FunctionOpen = binaryReader.ReadListString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
