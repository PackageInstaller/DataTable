using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRState : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Desc { get; private set; }

	public int Priority { get; private set; }

	public float DamageRatio { get; private set; }

	public float TenacityRatio { get; private set; }

	public bool CanMove { get; private set; }

	public bool CanRotate { get; private set; }

	public bool CanIsReleaseSkill { get; private set; }

	public bool ImmuneBuff { get; private set; }

	public int StateType { get; private set; }

	public float StateTime { get; private set; }

	public MonsterKnockDownLevelEnum MonsterKnockDownLevelEnum { get; private set; }

	public bool IsMinionknockdownState { get; private set; }

	public int SubjoinBuffState { get; private set; }

	public bool IsCanFrozenFrame { get; private set; }

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
		DamageRatio = float.Parse(array[num++]);
		TenacityRatio = float.Parse(array[num++]);
		CanMove = bool.Parse(array[num++]);
		CanRotate = bool.Parse(array[num++]);
		CanIsReleaseSkill = bool.Parse(array[num++]);
		ImmuneBuff = bool.Parse(array[num++]);
		StateType = int.Parse(array[num++]);
		StateTime = float.Parse(array[num++]);
		MonsterKnockDownLevelEnum = DataTableExtension.ParseEnum<MonsterKnockDownLevelEnum>(array[num++]);
		IsMinionknockdownState = bool.Parse(array[num++]);
		SubjoinBuffState = int.Parse(array[num++]);
		IsCanFrozenFrame = bool.Parse(array[num++]);
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
			DamageRatio = binaryReader.ReadSingle();
			TenacityRatio = binaryReader.ReadSingle();
			CanMove = binaryReader.ReadBoolean();
			CanRotate = binaryReader.ReadBoolean();
			CanIsReleaseSkill = binaryReader.ReadBoolean();
			ImmuneBuff = binaryReader.ReadBoolean();
			StateType = binaryReader.Read7BitEncodedInt32();
			StateTime = binaryReader.ReadSingle();
			MonsterKnockDownLevelEnum = binaryReader.ReadEnum<MonsterKnockDownLevelEnum>();
			IsMinionknockdownState = binaryReader.ReadBoolean();
			SubjoinBuffState = binaryReader.Read7BitEncodedInt32();
			IsCanFrozenFrame = binaryReader.ReadBoolean();
			HideIndicatorRing = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
