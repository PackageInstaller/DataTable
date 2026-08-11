using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCostomCultivate : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int HeroLv { get; private set; }

	public int HerosoulLv { get; private set; }

	public int HeroskillLv { get; private set; }

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
		HeroLv = int.Parse(array[num++]);
		HerosoulLv = int.Parse(array[num++]);
		HeroskillLv = int.Parse(array[num++]);
		num++;
		GeneratePropertyArray();
		return true;
	}

	public override bool ParseDataRow(byte[] dataRowBytes, int startIndex, int length, object userData)
	{
		using (MemoryStream input = new MemoryStream(dataRowBytes, startIndex, length, writable: false))
		{
			using BinaryReader binaryReader = new BinaryReader(input, Encoding.UTF8);
			m_Id = binaryReader.Read7BitEncodedInt32();
			HeroLv = binaryReader.Read7BitEncodedInt32();
			HerosoulLv = binaryReader.Read7BitEncodedInt32();
			HeroskillLv = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
