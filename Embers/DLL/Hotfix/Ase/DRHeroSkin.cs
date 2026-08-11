using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroSkin : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int HeroConfigId { get; private set; }

	public string AssetPath { get; private set; }

	public string SkinName { get; private set; }

	public int SkinLevel { get; private set; }

	public List<int> SummonedConfigID { get; private set; }

	public List<int> SummonedSkinID { get; private set; }

	public List<string> SummonedSkinPath { get; private set; }

	public List<int> BankGroups { get; private set; }

	public bool ChangeSkillIcon { get; private set; }

	public bool SkinBattleFrame { get; private set; }

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
		HeroConfigId = int.Parse(array[num++]);
		AssetPath = array[num++];
		SkinName = array[num++];
		SkinLevel = int.Parse(array[num++]);
		SummonedConfigID = DataTableExtension.ParseListInt(array[num++]);
		SummonedSkinID = DataTableExtension.ParseListInt(array[num++]);
		SummonedSkinPath = DataTableExtension.ParseListString(array[num++]);
		BankGroups = DataTableExtension.ParseListInt(array[num++]);
		ChangeSkillIcon = bool.Parse(array[num++]);
		SkinBattleFrame = bool.Parse(array[num++]);
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
			HeroConfigId = binaryReader.Read7BitEncodedInt32();
			AssetPath = binaryReader.ReadString();
			SkinName = binaryReader.ReadString();
			SkinLevel = binaryReader.Read7BitEncodedInt32();
			SummonedConfigID = binaryReader.ReadListInt();
			SummonedSkinID = binaryReader.ReadListInt();
			SummonedSkinPath = binaryReader.ReadListString();
			BankGroups = binaryReader.ReadListInt();
			ChangeSkillIcon = binaryReader.ReadBoolean();
			SkinBattleFrame = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
