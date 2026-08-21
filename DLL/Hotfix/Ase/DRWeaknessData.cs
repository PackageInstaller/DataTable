using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRWeaknessData : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Level { get; private set; }

	public float ToughnessDamage { get; private set; }

	public float Damage { get; private set; }

	public float XPIncrease { get; private set; }

	public List<float> WeaknessViewColor { get; private set; }

	public string WeaknessWorldKey { get; private set; }

	public string WeaknessCriticalWorldKey { get; private set; }

	public List<int> WeaknessHitSfx { get; private set; }

	public List<int> WeaknessHitSfxCooling { get; private set; }

	public bool IsWarnWeakness { get; private set; }

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
		Level = int.Parse(array[num++]);
		ToughnessDamage = float.Parse(array[num++]);
		Damage = float.Parse(array[num++]);
		XPIncrease = float.Parse(array[num++]);
		WeaknessViewColor = DataTableExtension.ParseListFloat(array[num++]);
		WeaknessWorldKey = array[num++];
		WeaknessCriticalWorldKey = array[num++];
		WeaknessHitSfx = DataTableExtension.ParseListInt(array[num++]);
		WeaknessHitSfxCooling = DataTableExtension.ParseListInt(array[num++]);
		IsWarnWeakness = bool.Parse(array[num++]);
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
			Level = binaryReader.Read7BitEncodedInt32();
			ToughnessDamage = binaryReader.ReadSingle();
			Damage = binaryReader.ReadSingle();
			XPIncrease = binaryReader.ReadSingle();
			WeaknessViewColor = binaryReader.ReadListFloat();
			WeaknessWorldKey = binaryReader.ReadString();
			WeaknessCriticalWorldKey = binaryReader.ReadString();
			WeaknessHitSfx = binaryReader.ReadListInt();
			WeaknessHitSfxCooling = binaryReader.ReadListInt();
			IsWarnWeakness = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
