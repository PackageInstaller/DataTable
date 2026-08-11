using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMedal : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Desc { get; private set; }

	public List<int> Condition { get; private set; }

	public List<int> Target { get; private set; }

	public int Value { get; private set; }

	public int Rewards { get; private set; }

	public int MedalId { get; private set; }

	public int Rank { get; private set; }

	public int Rarity { get; private set; }

	public int AchievementType { get; private set; }

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
		Desc = array[num++];
		Condition = DataTableExtension.ParseListInt(array[num++]);
		Target = DataTableExtension.ParseListInt(array[num++]);
		Value = int.Parse(array[num++]);
		Rewards = int.Parse(array[num++]);
		MedalId = int.Parse(array[num++]);
		Rank = int.Parse(array[num++]);
		Rarity = int.Parse(array[num++]);
		AchievementType = int.Parse(array[num++]);
		num++;
		GeneratePropertyArray();
		return true;
	}

	public override bool ParseDataRow(byte[] dataRowBytes, int startIndex, int length, object userData)
	{
		using (MemoryStream input = new MemoryStream(dataRowBytes, startIndex, length, writable: false))
		{
			using BinaryReader binaryReader = new BinaryReader(input, Encoding.UTF8);
			m_Id = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
			Condition = binaryReader.ReadListInt();
			Target = binaryReader.ReadListInt();
			Value = binaryReader.Read7BitEncodedInt32();
			Rewards = binaryReader.Read7BitEncodedInt32();
			MedalId = binaryReader.Read7BitEncodedInt32();
			Rank = binaryReader.Read7BitEncodedInt32();
			Rarity = binaryReader.Read7BitEncodedInt32();
			AchievementType = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
