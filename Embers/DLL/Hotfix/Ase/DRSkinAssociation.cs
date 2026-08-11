using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSkinAssociation : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<int> EffectConfigId { get; private set; }

	public List<int> SkinAssociationEffectConfigId { get; private set; }

	public List<int> SoundConfigId { get; private set; }

	public List<int> SkinAssociationSoundConfigId { get; private set; }

	public List<int> MaterialPath { get; private set; }

	public List<int> SkinAssociationMaterialPath { get; private set; }

	public List<string> CastingPath { get; private set; }

	public List<string> SkinAssociationCastingPath { get; private set; }

	public List<string> SkinStreamerCastingPath { get; private set; }

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
		EffectConfigId = DataTableExtension.ParseListInt(array[num++]);
		SkinAssociationEffectConfigId = DataTableExtension.ParseListInt(array[num++]);
		SoundConfigId = DataTableExtension.ParseListInt(array[num++]);
		SkinAssociationSoundConfigId = DataTableExtension.ParseListInt(array[num++]);
		MaterialPath = DataTableExtension.ParseListInt(array[num++]);
		SkinAssociationMaterialPath = DataTableExtension.ParseListInt(array[num++]);
		CastingPath = DataTableExtension.ParseListString(array[num++]);
		SkinAssociationCastingPath = DataTableExtension.ParseListString(array[num++]);
		SkinStreamerCastingPath = DataTableExtension.ParseListString(array[num++]);
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
			EffectConfigId = binaryReader.ReadListInt();
			SkinAssociationEffectConfigId = binaryReader.ReadListInt();
			SoundConfigId = binaryReader.ReadListInt();
			SkinAssociationSoundConfigId = binaryReader.ReadListInt();
			MaterialPath = binaryReader.ReadListInt();
			SkinAssociationMaterialPath = binaryReader.ReadListInt();
			CastingPath = binaryReader.ReadListString();
			SkinAssociationCastingPath = binaryReader.ReadListString();
			SkinStreamerCastingPath = binaryReader.ReadListString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
