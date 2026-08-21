using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRAbnormalState : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Desc { get; private set; }

	public int Priority { get; private set; }

	public int AbnormalStateType { get; private set; }

	public int Progress { get; private set; }

	public float Duration { get; private set; }

	public float RecessionSpeed { get; private set; }

	public float DelayRecessionTime { get; private set; }

	public List<int> NotCoexistStateId { get; private set; }

	public bool CanMove { get; private set; }

	public bool CanRotate { get; private set; }

	public List<int> AbnormalStateBuff { get; private set; }

	public List<int> AbnormalStateBullet { get; private set; }

	public bool IsCanFrozenFrame { get; private set; }

	public string AbnormalIcon { get; private set; }

	public string IconOutColor { get; private set; }

	public string IconInnerColor { get; private set; }

	public bool CanIsImmunization { get; private set; }

	public float ImmunizationTime { get; private set; }

	public float CoolDownTime { get; private set; }

	public string SfxPoint { get; private set; }

	public int EffectId { get; private set; }

	public List<string> NotReleaseDesignateSkill { get; private set; }

	public bool HideIndicatorRing { get; private set; }

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
		Priority = int.Parse(array[num++]);
		AbnormalStateType = int.Parse(array[num++]);
		Progress = int.Parse(array[num++]);
		Duration = float.Parse(array[num++]);
		RecessionSpeed = float.Parse(array[num++]);
		DelayRecessionTime = float.Parse(array[num++]);
		NotCoexistStateId = DataTableExtension.ParseListInt(array[num++]);
		CanMove = bool.Parse(array[num++]);
		CanRotate = bool.Parse(array[num++]);
		AbnormalStateBuff = DataTableExtension.ParseListInt(array[num++]);
		AbnormalStateBullet = DataTableExtension.ParseListInt(array[num++]);
		IsCanFrozenFrame = bool.Parse(array[num++]);
		AbnormalIcon = array[num++];
		IconOutColor = array[num++];
		IconInnerColor = array[num++];
		CanIsImmunization = bool.Parse(array[num++]);
		ImmunizationTime = float.Parse(array[num++]);
		CoolDownTime = float.Parse(array[num++]);
		SfxPoint = array[num++];
		EffectId = int.Parse(array[num++]);
		NotReleaseDesignateSkill = DataTableExtension.ParseListString(array[num++]);
		HideIndicatorRing = bool.Parse(array[num++]);
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
			Priority = binaryReader.Read7BitEncodedInt32();
			AbnormalStateType = binaryReader.Read7BitEncodedInt32();
			Progress = binaryReader.Read7BitEncodedInt32();
			Duration = binaryReader.ReadSingle();
			RecessionSpeed = binaryReader.ReadSingle();
			DelayRecessionTime = binaryReader.ReadSingle();
			NotCoexistStateId = binaryReader.ReadListInt();
			CanMove = binaryReader.ReadBoolean();
			CanRotate = binaryReader.ReadBoolean();
			AbnormalStateBuff = binaryReader.ReadListInt();
			AbnormalStateBullet = binaryReader.ReadListInt();
			IsCanFrozenFrame = binaryReader.ReadBoolean();
			AbnormalIcon = binaryReader.ReadString();
			IconOutColor = binaryReader.ReadString();
			IconInnerColor = binaryReader.ReadString();
			CanIsImmunization = binaryReader.ReadBoolean();
			ImmunizationTime = binaryReader.ReadSingle();
			CoolDownTime = binaryReader.ReadSingle();
			SfxPoint = binaryReader.ReadString();
			EffectId = binaryReader.Read7BitEncodedInt32();
			NotReleaseDesignateSkill = binaryReader.ReadListString();
			HideIndicatorRing = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
