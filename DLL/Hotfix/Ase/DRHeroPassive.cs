using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroPassive : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string SkillPassiveName { get; private set; }

	public string SkillPassive { get; private set; }

	public string TeamPassiveName { get; private set; }

	public string TeamPassive { get; private set; }

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
		SkillPassiveName = array[num++];
		SkillPassive = array[num++];
		TeamPassiveName = array[num++];
		TeamPassive = array[num++];
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
			SkillPassiveName = binaryReader.ReadString();
			SkillPassive = binaryReader.ReadString();
			TeamPassiveName = binaryReader.ReadString();
			TeamPassive = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
