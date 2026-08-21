using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCultivateSkillLevel : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Level { get; private set; }

	public float TalentDamageRatio { get; private set; }

	public float TalentFixDamageRatio { get; private set; }

	public float TalentTenacityRatio { get; private set; }

	public float TalentFixTenacityRatio { get; private set; }

	public float TalentCooling { get; private set; }

	public string TalentConsume { get; private set; }

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
		TalentDamageRatio = float.Parse(array[num++]);
		TalentFixDamageRatio = float.Parse(array[num++]);
		TalentTenacityRatio = float.Parse(array[num++]);
		TalentFixTenacityRatio = float.Parse(array[num++]);
		TalentCooling = float.Parse(array[num++]);
		TalentConsume = array[num++];
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
			TalentDamageRatio = binaryReader.ReadSingle();
			TalentFixDamageRatio = binaryReader.ReadSingle();
			TalentTenacityRatio = binaryReader.ReadSingle();
			TalentFixTenacityRatio = binaryReader.ReadSingle();
			TalentCooling = binaryReader.ReadSingle();
			TalentConsume = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
