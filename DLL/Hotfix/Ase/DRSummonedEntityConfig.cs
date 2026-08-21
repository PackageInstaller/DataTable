using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSummonedEntityConfig : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int HitBoxId { get; private set; }

	public int AIParadoxId { get; private set; }

	public string AssetPath { get; private set; }

	public List<int> BeHitBulletId { get; private set; }

	public int HP { get; private set; }

	public SummonedHitTypeEnum SummonedHitTypeEnum { get; private set; }

	public float Speed { get; private set; }

	public float TurnAroundSpeed { get; private set; }

	public float LifeTime { get; private set; }

	public string BasicAttributeRatio { get; private set; }

	public string RealTimeAttributeRatio { get; private set; }

	public SummonedVisibilityEnum SummonedVisibilityEnum { get; private set; }

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
		HitBoxId = int.Parse(array[num++]);
		AIParadoxId = int.Parse(array[num++]);
		AssetPath = array[num++];
		BeHitBulletId = DataTableExtension.ParseListInt(array[num++]);
		HP = int.Parse(array[num++]);
		SummonedHitTypeEnum = DataTableExtension.ParseEnum<SummonedHitTypeEnum>(array[num++]);
		Speed = float.Parse(array[num++]);
		TurnAroundSpeed = float.Parse(array[num++]);
		LifeTime = float.Parse(array[num++]);
		BasicAttributeRatio = array[num++];
		RealTimeAttributeRatio = array[num++];
		SummonedVisibilityEnum = DataTableExtension.ParseEnum<SummonedVisibilityEnum>(array[num++]);
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
			HitBoxId = binaryReader.Read7BitEncodedInt32();
			AIParadoxId = binaryReader.Read7BitEncodedInt32();
			AssetPath = binaryReader.ReadString();
			BeHitBulletId = binaryReader.ReadListInt();
			HP = binaryReader.Read7BitEncodedInt32();
			SummonedHitTypeEnum = binaryReader.ReadEnum<SummonedHitTypeEnum>();
			Speed = binaryReader.ReadSingle();
			TurnAroundSpeed = binaryReader.ReadSingle();
			LifeTime = binaryReader.ReadSingle();
			BasicAttributeRatio = binaryReader.ReadString();
			RealTimeAttributeRatio = binaryReader.ReadString();
			SummonedVisibilityEnum = binaryReader.ReadEnum<SummonedVisibilityEnum>();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
