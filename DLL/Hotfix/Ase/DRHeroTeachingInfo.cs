using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroTeachingInfo : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string TeachingGroupName { get; private set; }

	public List<int> TeachingGroupConfig { get; private set; }

	public List<float> NextTeachDelayTime { get; private set; }

	public List<int> NextTeachBanInputSkill { get; private set; }

	public int TeachingGroupType { get; private set; }

	public List<float> BornPoint { get; private set; }

	public string FrameName { get; private set; }

	public string FrameText { get; private set; }

	public int Timing { get; private set; }

	public int NextTeachingGroup { get; private set; }

	public List<int> FinishAddBuff { get; private set; }

	public List<int> CreateAddBuff { get; private set; }

	public List<int> FinishClearBuff { get; private set; }

	public float DelayTime { get; private set; }

	public bool FinishLevel { get; private set; }

	public List<string> SetPropertyName { get; private set; }

	public List<float> SetPropertyValue { get; private set; }

	public bool SetState { get; private set; }

	public int MonsterState { get; private set; }

	public bool SetPhaseEnum { get; private set; }

	public MonsterPhaseEnum MonsterPhaseEnum { get; private set; }

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
		TeachingGroupName = array[num++];
		TeachingGroupConfig = DataTableExtension.ParseListInt(array[num++]);
		NextTeachDelayTime = DataTableExtension.ParseListFloat(array[num++]);
		NextTeachBanInputSkill = DataTableExtension.ParseListInt(array[num++]);
		TeachingGroupType = int.Parse(array[num++]);
		BornPoint = DataTableExtension.ParseListFloat(array[num++]);
		FrameName = array[num++];
		FrameText = array[num++];
		Timing = int.Parse(array[num++]);
		NextTeachingGroup = int.Parse(array[num++]);
		FinishAddBuff = DataTableExtension.ParseListInt(array[num++]);
		CreateAddBuff = DataTableExtension.ParseListInt(array[num++]);
		FinishClearBuff = DataTableExtension.ParseListInt(array[num++]);
		DelayTime = float.Parse(array[num++]);
		FinishLevel = bool.Parse(array[num++]);
		SetPropertyName = DataTableExtension.ParseListString(array[num++]);
		SetPropertyValue = DataTableExtension.ParseListFloat(array[num++]);
		SetState = bool.Parse(array[num++]);
		MonsterState = int.Parse(array[num++]);
		SetPhaseEnum = bool.Parse(array[num++]);
		MonsterPhaseEnum = DataTableExtension.ParseEnum<MonsterPhaseEnum>(array[num++]);
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
			TeachingGroupName = binaryReader.ReadString();
			TeachingGroupConfig = binaryReader.ReadListInt();
			NextTeachDelayTime = binaryReader.ReadListFloat();
			NextTeachBanInputSkill = binaryReader.ReadListInt();
			TeachingGroupType = binaryReader.Read7BitEncodedInt32();
			BornPoint = binaryReader.ReadListFloat();
			FrameName = binaryReader.ReadString();
			FrameText = binaryReader.ReadString();
			Timing = binaryReader.Read7BitEncodedInt32();
			NextTeachingGroup = binaryReader.Read7BitEncodedInt32();
			FinishAddBuff = binaryReader.ReadListInt();
			CreateAddBuff = binaryReader.ReadListInt();
			FinishClearBuff = binaryReader.ReadListInt();
			DelayTime = binaryReader.ReadSingle();
			FinishLevel = binaryReader.ReadBoolean();
			SetPropertyName = binaryReader.ReadListString();
			SetPropertyValue = binaryReader.ReadListFloat();
			SetState = binaryReader.ReadBoolean();
			MonsterState = binaryReader.Read7BitEncodedInt32();
			SetPhaseEnum = binaryReader.ReadBoolean();
			MonsterPhaseEnum = binaryReader.ReadEnum<MonsterPhaseEnum>();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
