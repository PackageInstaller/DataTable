using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMonster : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int CollisionId { get; private set; }

	public int HitBoxId { get; private set; }

	public int AIParadoxId { get; private set; }

	public int MaterialType { get; private set; }

	public string AssetPath { get; private set; }

	public string Head { get; private set; }

	public bool IsBoss { get; private set; }

	public int AppearLevel { get; private set; }

	public string ActionHeadIcon { get; private set; }

	public float Speed { get; private set; }

	public float TurnAroundSpeed { get; private set; }

	public float MeatQuality { get; private set; }

	public int BallisticsCategory { get; private set; }

	public bool IsEffectRadius { get; private set; }

	public float NearPlayEffectRadius { get; private set; }

	public float FarPlayEffectRadius { get; private set; }

	public float NomalAttackFactor { get; private set; }

	public float NormalStateAttackToAngerScale { get; private set; }

	public float NormalStateRecoverAngerScale { get; private set; }

	public float OverDriverAttackFactor { get; private set; }

	public float ODStateAttackToAngerScale { get; private set; }

	public float ODStateRecoverAngerScale { get; private set; }

	public int BreakTime { get; private set; }

	public float BreakAttackFactor { get; private set; }

	public bool IsChangeState { get; private set; }

	public List<int> BoundID { get; private set; }

	public int DeadStateId { get; private set; }

	public int RebornStateId { get; private set; }

	public int HpBarType { get; private set; }

	public int MobPower { get; private set; }

	public float ShakeMultiple { get; private set; }

	public float CamDistanceBaseline { get; private set; }

	public float AutoDistanceMin { get; private set; }

	public float AutoDistanceMax { get; private set; }

	public float CamRadius { get; private set; }

	public List<float> CamRelativeOffset { get; private set; }

	public List<float> CamAbsoluteOffset { get; private set; }

	public float AutoDistTrigger { get; private set; }

	public float AutoDistSpeed { get; private set; }

	public List<int> BankGroups { get; private set; }

	public int StateType { get; private set; }

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
		CollisionId = int.Parse(array[num++]);
		HitBoxId = int.Parse(array[num++]);
		AIParadoxId = int.Parse(array[num++]);
		MaterialType = int.Parse(array[num++]);
		AssetPath = array[num++];
		Head = array[num++];
		IsBoss = bool.Parse(array[num++]);
		AppearLevel = int.Parse(array[num++]);
		ActionHeadIcon = array[num++];
		Speed = float.Parse(array[num++]);
		TurnAroundSpeed = float.Parse(array[num++]);
		MeatQuality = float.Parse(array[num++]);
		BallisticsCategory = int.Parse(array[num++]);
		IsEffectRadius = bool.Parse(array[num++]);
		NearPlayEffectRadius = float.Parse(array[num++]);
		FarPlayEffectRadius = float.Parse(array[num++]);
		NomalAttackFactor = float.Parse(array[num++]);
		NormalStateAttackToAngerScale = float.Parse(array[num++]);
		NormalStateRecoverAngerScale = float.Parse(array[num++]);
		OverDriverAttackFactor = float.Parse(array[num++]);
		ODStateAttackToAngerScale = float.Parse(array[num++]);
		ODStateRecoverAngerScale = float.Parse(array[num++]);
		BreakTime = int.Parse(array[num++]);
		BreakAttackFactor = float.Parse(array[num++]);
		IsChangeState = bool.Parse(array[num++]);
		BoundID = DataTableExtension.ParseListInt(array[num++]);
		DeadStateId = int.Parse(array[num++]);
		RebornStateId = int.Parse(array[num++]);
		HpBarType = int.Parse(array[num++]);
		MobPower = int.Parse(array[num++]);
		ShakeMultiple = float.Parse(array[num++]);
		CamDistanceBaseline = float.Parse(array[num++]);
		AutoDistanceMin = float.Parse(array[num++]);
		AutoDistanceMax = float.Parse(array[num++]);
		CamRadius = float.Parse(array[num++]);
		CamRelativeOffset = DataTableExtension.ParseListFloat(array[num++]);
		CamAbsoluteOffset = DataTableExtension.ParseListFloat(array[num++]);
		AutoDistTrigger = float.Parse(array[num++]);
		AutoDistSpeed = float.Parse(array[num++]);
		BankGroups = DataTableExtension.ParseListInt(array[num++]);
		StateType = int.Parse(array[num++]);
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
			CollisionId = binaryReader.Read7BitEncodedInt32();
			HitBoxId = binaryReader.Read7BitEncodedInt32();
			AIParadoxId = binaryReader.Read7BitEncodedInt32();
			MaterialType = binaryReader.Read7BitEncodedInt32();
			AssetPath = binaryReader.ReadString();
			Head = binaryReader.ReadString();
			IsBoss = binaryReader.ReadBoolean();
			AppearLevel = binaryReader.Read7BitEncodedInt32();
			ActionHeadIcon = binaryReader.ReadString();
			Speed = binaryReader.ReadSingle();
			TurnAroundSpeed = binaryReader.ReadSingle();
			MeatQuality = binaryReader.ReadSingle();
			BallisticsCategory = binaryReader.Read7BitEncodedInt32();
			IsEffectRadius = binaryReader.ReadBoolean();
			NearPlayEffectRadius = binaryReader.ReadSingle();
			FarPlayEffectRadius = binaryReader.ReadSingle();
			NomalAttackFactor = binaryReader.ReadSingle();
			NormalStateAttackToAngerScale = binaryReader.ReadSingle();
			NormalStateRecoverAngerScale = binaryReader.ReadSingle();
			OverDriverAttackFactor = binaryReader.ReadSingle();
			ODStateAttackToAngerScale = binaryReader.ReadSingle();
			ODStateRecoverAngerScale = binaryReader.ReadSingle();
			BreakTime = binaryReader.Read7BitEncodedInt32();
			BreakAttackFactor = binaryReader.ReadSingle();
			IsChangeState = binaryReader.ReadBoolean();
			BoundID = binaryReader.ReadListInt();
			DeadStateId = binaryReader.Read7BitEncodedInt32();
			RebornStateId = binaryReader.Read7BitEncodedInt32();
			HpBarType = binaryReader.Read7BitEncodedInt32();
			MobPower = binaryReader.Read7BitEncodedInt32();
			ShakeMultiple = binaryReader.ReadSingle();
			CamDistanceBaseline = binaryReader.ReadSingle();
			AutoDistanceMin = binaryReader.ReadSingle();
			AutoDistanceMax = binaryReader.ReadSingle();
			CamRadius = binaryReader.ReadSingle();
			CamRelativeOffset = binaryReader.ReadListFloat();
			CamAbsoluteOffset = binaryReader.ReadListFloat();
			AutoDistTrigger = binaryReader.ReadSingle();
			AutoDistSpeed = binaryReader.ReadSingle();
			BankGroups = binaryReader.ReadListInt();
			StateType = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
