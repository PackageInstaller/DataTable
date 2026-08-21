using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRAttributeMatching : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public HeroAttributeEnum HeroAttributeEnum { get; private set; }

	public string ConditionBuffs { get; private set; }

	public List<string> Targets { get; private set; }

	public string Params { get; private set; }

	public string AttributeEffectDesc { get; private set; }

	public List<List<float>> EffectValue { get; private set; }

	public List<int> EffectType { get; private set; }

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
		HeroAttributeEnum = DataTableExtension.ParseEnum<HeroAttributeEnum>(array[num++]);
		ConditionBuffs = array[num++];
		Targets = DataTableExtension.ParseListString(array[num++]);
		Params = array[num++];
		AttributeEffectDesc = array[num++];
		EffectValue = DataTableExtension.ParseListFloatList(array[num++]);
		EffectType = DataTableExtension.ParseListInt(array[num++]);
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
			HeroAttributeEnum = binaryReader.ReadEnum<HeroAttributeEnum>();
			ConditionBuffs = binaryReader.ReadString();
			Targets = binaryReader.ReadListString();
			Params = binaryReader.ReadString();
			AttributeEffectDesc = binaryReader.ReadString();
			EffectValue = binaryReader.ReadListFloatList();
			EffectType = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
