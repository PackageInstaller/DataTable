using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroSkillSkin : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string SkillSkinName { get; private set; }

	public int SkillId { get; private set; }

	public string SkillSkinIcon { get; private set; }

	public string SkillSkinVideo { get; private set; }

	public string SkillSkinDesc { get; private set; }

	public int PropId { get; private set; }

	public int PropNum { get; private set; }

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
		SkillSkinName = array[num++];
		SkillId = int.Parse(array[num++]);
		SkillSkinIcon = array[num++];
		SkillSkinVideo = array[num++];
		SkillSkinDesc = array[num++];
		PropId = int.Parse(array[num++]);
		PropNum = int.Parse(array[num++]);
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
			SkillSkinName = binaryReader.ReadString();
			SkillId = binaryReader.Read7BitEncodedInt32();
			SkillSkinIcon = binaryReader.ReadString();
			SkillSkinVideo = binaryReader.ReadString();
			SkillSkinDesc = binaryReader.ReadString();
			PropId = binaryReader.Read7BitEncodedInt32();
			PropNum = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
