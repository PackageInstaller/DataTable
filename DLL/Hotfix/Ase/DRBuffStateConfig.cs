using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBuffStateConfig : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Desc { get; private set; }

	public int ImmuneState { get; private set; }

	public bool ImmuneAbnormalState { get; private set; }

	public bool ImmuneAbnormalStateIncrease { get; private set; }

	public bool ImmuneDamage { get; private set; }

	public bool ImmuneCollider { get; private set; }

	public List<int> ImmuneRelationCollider { get; private set; }

	public List<int> ImmuneHit { get; private set; }

	public bool ImmuneLock { get; private set; }

	public bool LockHp { get; private set; }

	public bool ImmuneHitSfx { get; private set; }

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
		ImmuneState = int.Parse(array[num++]);
		ImmuneAbnormalState = bool.Parse(array[num++]);
		ImmuneAbnormalStateIncrease = bool.Parse(array[num++]);
		ImmuneDamage = bool.Parse(array[num++]);
		ImmuneCollider = bool.Parse(array[num++]);
		ImmuneRelationCollider = DataTableExtension.ParseListInt(array[num++]);
		ImmuneHit = DataTableExtension.ParseListInt(array[num++]);
		ImmuneLock = bool.Parse(array[num++]);
		LockHp = bool.Parse(array[num++]);
		ImmuneHitSfx = bool.Parse(array[num++]);
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
			ImmuneState = binaryReader.Read7BitEncodedInt32();
			ImmuneAbnormalState = binaryReader.ReadBoolean();
			ImmuneAbnormalStateIncrease = binaryReader.ReadBoolean();
			ImmuneDamage = binaryReader.ReadBoolean();
			ImmuneCollider = binaryReader.ReadBoolean();
			ImmuneRelationCollider = binaryReader.ReadListInt();
			ImmuneHit = binaryReader.ReadListInt();
			ImmuneLock = binaryReader.ReadBoolean();
			LockHp = binaryReader.ReadBoolean();
			ImmuneHitSfx = binaryReader.ReadBoolean();
			HideIndicatorRing = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
