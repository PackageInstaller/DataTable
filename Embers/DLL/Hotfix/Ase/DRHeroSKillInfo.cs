using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroSKillInfo : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string HeroName { get; private set; }

	public int HeroId { get; private set; }

	public HeroSkillTypeEnum HeroSkillTypeEnum { get; private set; }

	public int SkillId { get; private set; }

	public string PcKey { get; private set; }

	public float CommandCacheTime { get; private set; }

	public List<int> CommandBindSkillGroup { get; private set; }

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
		HeroName = array[num++];
		HeroId = int.Parse(array[num++]);
		HeroSkillTypeEnum = DataTableExtension.ParseEnum<HeroSkillTypeEnum>(array[num++]);
		SkillId = int.Parse(array[num++]);
		PcKey = array[num++];
		CommandCacheTime = float.Parse(array[num++]);
		CommandBindSkillGroup = DataTableExtension.ParseListInt(array[num++]);
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
			HeroName = binaryReader.ReadString();
			HeroId = binaryReader.Read7BitEncodedInt32();
			HeroSkillTypeEnum = binaryReader.ReadEnum<HeroSkillTypeEnum>();
			SkillId = binaryReader.Read7BitEncodedInt32();
			PcKey = binaryReader.ReadString();
			CommandCacheTime = binaryReader.ReadSingle();
			CommandBindSkillGroup = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
