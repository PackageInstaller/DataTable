using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroTalentSmall : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int HeroId { get; private set; }

	public int SkillId { get; private set; }

	public int Order { get; private set; }

	public List<int> NeedId { get; private set; }

	public List<int> NeedNum { get; private set; }

	public int NeedGold { get; private set; }

	public List<int> Condition { get; private set; }

	public List<int> ConditionNum { get; private set; }

	public int TinderType { get; private set; }

	public string SkillDesc { get; private set; }

	public List<int> BattleValue { get; private set; }

	public int BattleBuffId { get; private set; }

	public List<int> AttributeId { get; private set; }

	public List<float> AttributeNum { get; private set; }

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
		HeroId = int.Parse(array[num++]);
		SkillId = int.Parse(array[num++]);
		Order = int.Parse(array[num++]);
		NeedId = DataTableExtension.ParseListInt(array[num++]);
		NeedNum = DataTableExtension.ParseListInt(array[num++]);
		NeedGold = int.Parse(array[num++]);
		Condition = DataTableExtension.ParseListInt(array[num++]);
		ConditionNum = DataTableExtension.ParseListInt(array[num++]);
		TinderType = int.Parse(array[num++]);
		SkillDesc = array[num++];
		BattleValue = DataTableExtension.ParseListInt(array[num++]);
		BattleBuffId = int.Parse(array[num++]);
		AttributeId = DataTableExtension.ParseListInt(array[num++]);
		AttributeNum = DataTableExtension.ParseListFloat(array[num++]);
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
			HeroId = binaryReader.Read7BitEncodedInt32();
			SkillId = binaryReader.Read7BitEncodedInt32();
			Order = binaryReader.Read7BitEncodedInt32();
			NeedId = binaryReader.ReadListInt();
			NeedNum = binaryReader.ReadListInt();
			NeedGold = binaryReader.Read7BitEncodedInt32();
			Condition = binaryReader.ReadListInt();
			ConditionNum = binaryReader.ReadListInt();
			TinderType = binaryReader.Read7BitEncodedInt32();
			SkillDesc = binaryReader.ReadString();
			BattleValue = binaryReader.ReadListInt();
			BattleBuffId = binaryReader.Read7BitEncodedInt32();
			AttributeId = binaryReader.ReadListInt();
			AttributeNum = binaryReader.ReadListFloat();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
