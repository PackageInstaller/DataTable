using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBoneDamageCalcData : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Desc { get; private set; }

	public int MinValue { get; private set; }

	public int MaxValue { get; private set; }

	public float AttackFactor { get; private set; }

	public int AreaLevelBattle { get; private set; }

	public int AreaLevelUI { get; private set; }

	public List<string> AngleUI { get; private set; }

	public float TenacityFactor { get; private set; }

	public float DamageTextScale { get; private set; }

	public string DamageFormat { get; private set; }

	public List<WeaponEnum> WeaponEnum { get; private set; }

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
		MinValue = int.Parse(array[num++]);
		MaxValue = int.Parse(array[num++]);
		AttackFactor = float.Parse(array[num++]);
		AreaLevelBattle = int.Parse(array[num++]);
		AreaLevelUI = int.Parse(array[num++]);
		AngleUI = DataTableExtension.ParseListString(array[num++]);
		TenacityFactor = float.Parse(array[num++]);
		DamageTextScale = float.Parse(array[num++]);
		DamageFormat = array[num++];
		WeaponEnum = DataTableExtension.ParseListEnum<WeaponEnum>(array[num++]);
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
			MinValue = binaryReader.Read7BitEncodedInt32();
			MaxValue = binaryReader.Read7BitEncodedInt32();
			AttackFactor = binaryReader.ReadSingle();
			AreaLevelBattle = binaryReader.Read7BitEncodedInt32();
			AreaLevelUI = binaryReader.Read7BitEncodedInt32();
			AngleUI = binaryReader.ReadListString();
			TenacityFactor = binaryReader.ReadSingle();
			DamageTextScale = binaryReader.ReadSingle();
			DamageFormat = binaryReader.ReadString();
			WeaponEnum = binaryReader.ReadListEnum<WeaponEnum>();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
