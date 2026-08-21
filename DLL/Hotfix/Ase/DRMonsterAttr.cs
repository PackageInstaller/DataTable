using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMonsterAttr : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int MonsterType { get; private set; }

	public int MonsterLevel { get; private set; }

	public string Name { get; private set; }

	public bool HideMonsterLevel { get; private set; }

	public int Hp { get; private set; }

	public int Attack { get; private set; }

	public int Defence { get; private set; }

	public int MaxTenacity { get; private set; }

	public float BaseTough { get; private set; }

	public float TenacityBreakTime { get; private set; }

	public int AngerMax { get; private set; }

	public List<string> BonusType { get; private set; }

	public List<float> DoubleBonusNum { get; private set; }

	public List<float> TriBonusNum { get; private set; }

	public List<int> BornBuff { get; private set; }

	public List<string> ElementsWeakness { get; private set; }

	public List<float> WeaknessValue { get; private set; }

	public List<int> SummonMonster { get; private set; }

	public int AtkLightLevel { get; private set; }

	public int HpLightLevel { get; private set; }

	public int BattleDuration { get; private set; }

	public int MonsterDifficulty { get; private set; }

	public List<int> RewardId { get; private set; }

	public List<int> RewardType { get; private set; }

	public List<int> RewardQuantity { get; private set; }

	public List<int> SummonedMaxNumber { get; private set; }

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
		MonsterType = int.Parse(array[num++]);
		MonsterLevel = int.Parse(array[num++]);
		Name = array[num++];
		HideMonsterLevel = bool.Parse(array[num++]);
		Hp = int.Parse(array[num++]);
		Attack = int.Parse(array[num++]);
		Defence = int.Parse(array[num++]);
		MaxTenacity = int.Parse(array[num++]);
		BaseTough = float.Parse(array[num++]);
		TenacityBreakTime = float.Parse(array[num++]);
		AngerMax = int.Parse(array[num++]);
		BonusType = DataTableExtension.ParseListString(array[num++]);
		DoubleBonusNum = DataTableExtension.ParseListFloat(array[num++]);
		TriBonusNum = DataTableExtension.ParseListFloat(array[num++]);
		BornBuff = DataTableExtension.ParseListInt(array[num++]);
		ElementsWeakness = DataTableExtension.ParseListString(array[num++]);
		WeaknessValue = DataTableExtension.ParseListFloat(array[num++]);
		SummonMonster = DataTableExtension.ParseListInt(array[num++]);
		AtkLightLevel = int.Parse(array[num++]);
		HpLightLevel = int.Parse(array[num++]);
		BattleDuration = int.Parse(array[num++]);
		MonsterDifficulty = int.Parse(array[num++]);
		RewardId = DataTableExtension.ParseListInt(array[num++]);
		RewardType = DataTableExtension.ParseListInt(array[num++]);
		RewardQuantity = DataTableExtension.ParseListInt(array[num++]);
		SummonedMaxNumber = DataTableExtension.ParseListInt(array[num++]);
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
			MonsterType = binaryReader.Read7BitEncodedInt32();
			MonsterLevel = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			HideMonsterLevel = binaryReader.ReadBoolean();
			Hp = binaryReader.Read7BitEncodedInt32();
			Attack = binaryReader.Read7BitEncodedInt32();
			Defence = binaryReader.Read7BitEncodedInt32();
			MaxTenacity = binaryReader.Read7BitEncodedInt32();
			BaseTough = binaryReader.ReadSingle();
			TenacityBreakTime = binaryReader.ReadSingle();
			AngerMax = binaryReader.Read7BitEncodedInt32();
			BonusType = binaryReader.ReadListString();
			DoubleBonusNum = binaryReader.ReadListFloat();
			TriBonusNum = binaryReader.ReadListFloat();
			BornBuff = binaryReader.ReadListInt();
			ElementsWeakness = binaryReader.ReadListString();
			WeaknessValue = binaryReader.ReadListFloat();
			SummonMonster = binaryReader.ReadListInt();
			AtkLightLevel = binaryReader.Read7BitEncodedInt32();
			HpLightLevel = binaryReader.Read7BitEncodedInt32();
			BattleDuration = binaryReader.Read7BitEncodedInt32();
			MonsterDifficulty = binaryReader.Read7BitEncodedInt32();
			RewardId = binaryReader.ReadListInt();
			RewardType = binaryReader.ReadListInt();
			RewardQuantity = binaryReader.ReadListInt();
			SummonedMaxNumber = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
