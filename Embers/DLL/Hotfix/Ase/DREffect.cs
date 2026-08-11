using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREffect : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Desc { get; private set; }

	public string MidLevelAssetPath { get; private set; }

	public string LowLevelAssetPath { get; private set; }

	public string HighLevelAssetPath { get; private set; }

	public float Duration { get; private set; }

	public bool FollowParentDispose { get; private set; }

	public int AudioID { get; private set; }

	public List<string> ParamNameList { get; private set; }

	public List<float> ParamValueList { get; private set; }

	public float DelayStart { get; private set; }

	public float StartToPerformTime { get; private set; }

	public bool AudioFollowParentType { get; private set; }

	public bool IsFrozenEffect { get; private set; }

	public bool PauseDestroy { get; private set; }

	public bool IsPlayOnReConnect { get; private set; }

	public bool IgnoreSettings { get; private set; }

	public string DefaultAnimation { get; private set; }

	public float DelayTime { get; private set; }

	public VFXVisibilityEnum VFXVisibilityEnum { get; private set; }

	public bool IgnoreGlobalTimeScale { get; private set; }

	public string ActionBonePath { get; private set; }

	public string DefaultFollowType { get; private set; }

	public bool ChangeScale { get; private set; }

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
		Desc = array[num++];
		MidLevelAssetPath = array[num++];
		LowLevelAssetPath = array[num++];
		HighLevelAssetPath = array[num++];
		Duration = float.Parse(array[num++]);
		FollowParentDispose = bool.Parse(array[num++]);
		AudioID = int.Parse(array[num++]);
		ParamNameList = DataTableExtension.ParseListString(array[num++]);
		ParamValueList = DataTableExtension.ParseListFloat(array[num++]);
		DelayStart = float.Parse(array[num++]);
		StartToPerformTime = float.Parse(array[num++]);
		AudioFollowParentType = bool.Parse(array[num++]);
		IsFrozenEffect = bool.Parse(array[num++]);
		PauseDestroy = bool.Parse(array[num++]);
		IsPlayOnReConnect = bool.Parse(array[num++]);
		IgnoreSettings = bool.Parse(array[num++]);
		DefaultAnimation = array[num++];
		DelayTime = float.Parse(array[num++]);
		VFXVisibilityEnum = DataTableExtension.ParseEnum<VFXVisibilityEnum>(array[num++]);
		IgnoreGlobalTimeScale = bool.Parse(array[num++]);
		ActionBonePath = array[num++];
		DefaultFollowType = array[num++];
		ChangeScale = bool.Parse(array[num++]);
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
			Desc = binaryReader.ReadString();
			MidLevelAssetPath = binaryReader.ReadString();
			LowLevelAssetPath = binaryReader.ReadString();
			HighLevelAssetPath = binaryReader.ReadString();
			Duration = binaryReader.ReadSingle();
			FollowParentDispose = binaryReader.ReadBoolean();
			AudioID = binaryReader.Read7BitEncodedInt32();
			ParamNameList = binaryReader.ReadListString();
			ParamValueList = binaryReader.ReadListFloat();
			DelayStart = binaryReader.ReadSingle();
			StartToPerformTime = binaryReader.ReadSingle();
			AudioFollowParentType = binaryReader.ReadBoolean();
			IsFrozenEffect = binaryReader.ReadBoolean();
			PauseDestroy = binaryReader.ReadBoolean();
			IsPlayOnReConnect = binaryReader.ReadBoolean();
			IgnoreSettings = binaryReader.ReadBoolean();
			DefaultAnimation = binaryReader.ReadString();
			DelayTime = binaryReader.ReadSingle();
			VFXVisibilityEnum = binaryReader.ReadEnum<VFXVisibilityEnum>();
			IgnoreGlobalTimeScale = binaryReader.ReadBoolean();
			ActionBonePath = binaryReader.ReadString();
			DefaultFollowType = binaryReader.ReadString();
			ChangeScale = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
