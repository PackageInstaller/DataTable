using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRWorldLevel : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Worldlevel { get; private set; }

	public int Monsterlevel { get; private set; }

	public float HpRatio { get; private set; }

	public float AttackRatio { get; private set; }

	public float MaxTenacityRatio { get; private set; }

	public float BaseToughRatio { get; private set; }

	public float AtkLightLevelRatio { get; private set; }

	public float HpLightLevelRatio { get; private set; }

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
		Worldlevel = int.Parse(array[num++]);
		Monsterlevel = int.Parse(array[num++]);
		HpRatio = float.Parse(array[num++]);
		AttackRatio = float.Parse(array[num++]);
		MaxTenacityRatio = float.Parse(array[num++]);
		BaseToughRatio = float.Parse(array[num++]);
		AtkLightLevelRatio = float.Parse(array[num++]);
		HpLightLevelRatio = float.Parse(array[num++]);
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
			Worldlevel = binaryReader.Read7BitEncodedInt32();
			Monsterlevel = binaryReader.Read7BitEncodedInt32();
			HpRatio = binaryReader.ReadSingle();
			AttackRatio = binaryReader.ReadSingle();
			MaxTenacityRatio = binaryReader.ReadSingle();
			BaseToughRatio = binaryReader.ReadSingle();
			AtkLightLevelRatio = binaryReader.ReadSingle();
			HpLightLevelRatio = binaryReader.ReadSingle();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
