using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRBuff : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Desc { get; private set; }

	public float WaitTime { get; private set; }

	public float Duration { get; private set; }

	public float RepeatTime { get; private set; }

	public bool Coexist { get; private set; }

	public int StackType { get; private set; }

	public int InitLayer { get; private set; }

	public int MaxLayer { get; private set; }

	public string BuffGroup { get; private set; }

	public int BuffGroupPriority { get; private set; }

	public bool LayerOverlying { get; private set; }

	public float LayerRepeatTime { get; private set; }

	public int LayerRepeatNum { get; private set; }

	public ConditionList<List<string>> AddCondition { get; private set; }

	public ConditionList<List<string>> TriggerCondition { get; private set; }

	public ConditionList<List<string>> FinishCondition { get; private set; }

	public ConditionList<List<string>> ClearOperationsCondition { get; private set; }

	public List<List<string>> Operations { get; private set; }

	public bool FinishClearOperations { get; private set; }

	public string BuffIcon { get; private set; }

	public List<List<string>> SFX { get; private set; }

	public List<string> BuffLabelEnum { get; private set; }

	public BuffActionTypeEnum BuffActionTypeEnum { get; private set; }

	public List<float> BuffActionTypeParams { get; private set; }

	public bool IgnoreGlobalTimeScale { get; private set; }

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
		WaitTime = float.Parse(array[num++]);
		Duration = float.Parse(array[num++]);
		RepeatTime = float.Parse(array[num++]);
		Coexist = bool.Parse(array[num++]);
		StackType = int.Parse(array[num++]);
		InitLayer = int.Parse(array[num++]);
		MaxLayer = int.Parse(array[num++]);
		BuffGroup = array[num++];
		BuffGroupPriority = int.Parse(array[num++]);
		LayerOverlying = bool.Parse(array[num++]);
		LayerRepeatTime = float.Parse(array[num++]);
		LayerRepeatNum = int.Parse(array[num++]);
		AddCondition = DataTableExtension.ParseListsConditionStringList(array[num++]);
		TriggerCondition = DataTableExtension.ParseListsConditionStringList(array[num++]);
		FinishCondition = DataTableExtension.ParseListsConditionStringList(array[num++]);
		ClearOperationsCondition = DataTableExtension.ParseListsConditionStringList(array[num++]);
		Operations = DataTableExtension.ParseListsSemicolonStringList(array[num++]);
		FinishClearOperations = bool.Parse(array[num++]);
		BuffIcon = array[num++];
		SFX = DataTableExtension.ParseListsSemicolonStringList(array[num++]);
		BuffLabelEnum = DataTableExtension.ParseListString(array[num++]);
		BuffActionTypeEnum = DataTableExtension.ParseEnum<BuffActionTypeEnum>(array[num++]);
		BuffActionTypeParams = DataTableExtension.ParseListFloat(array[num++]);
		IgnoreGlobalTimeScale = bool.Parse(array[num++]);
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
			Desc = binaryReader.ReadString();
			WaitTime = binaryReader.ReadSingle();
			Duration = binaryReader.ReadSingle();
			RepeatTime = binaryReader.ReadSingle();
			Coexist = binaryReader.ReadBoolean();
			StackType = binaryReader.Read7BitEncodedInt32();
			InitLayer = binaryReader.Read7BitEncodedInt32();
			MaxLayer = binaryReader.Read7BitEncodedInt32();
			BuffGroup = binaryReader.ReadString();
			BuffGroupPriority = binaryReader.Read7BitEncodedInt32();
			LayerOverlying = binaryReader.ReadBoolean();
			LayerRepeatTime = binaryReader.ReadSingle();
			LayerRepeatNum = binaryReader.Read7BitEncodedInt32();
			AddCondition = binaryReader.ReadListsConditionStringList();
			TriggerCondition = binaryReader.ReadListsConditionStringList();
			FinishCondition = binaryReader.ReadListsConditionStringList();
			ClearOperationsCondition = binaryReader.ReadListsConditionStringList();
			Operations = binaryReader.ReadListsSemicolonStringList();
			FinishClearOperations = binaryReader.ReadBoolean();
			BuffIcon = binaryReader.ReadString();
			SFX = binaryReader.ReadListsSemicolonStringList();
			BuffLabelEnum = binaryReader.ReadListString();
			BuffActionTypeEnum = binaryReader.ReadEnum<BuffActionTypeEnum>();
			BuffActionTypeParams = binaryReader.ReadListFloat();
			IgnoreGlobalTimeScale = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
