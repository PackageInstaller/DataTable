using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRWholeApart : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ProductID { get; private set; }

	public int MainPropId { get; private set; }

	public int Operate { get; private set; }

	public int Order { get; private set; }

	public int MainPropNum { get; private set; }

	public int MaterialID { get; private set; }

	public int MaterialNum { get; private set; }

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
		ProductID = int.Parse(array[num++]);
		MainPropId = int.Parse(array[num++]);
		Operate = int.Parse(array[num++]);
		Order = int.Parse(array[num++]);
		MainPropNum = int.Parse(array[num++]);
		MaterialID = int.Parse(array[num++]);
		MaterialNum = int.Parse(array[num++]);
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
			ProductID = binaryReader.Read7BitEncodedInt32();
			MainPropId = binaryReader.Read7BitEncodedInt32();
			Operate = binaryReader.Read7BitEncodedInt32();
			Order = binaryReader.Read7BitEncodedInt32();
			MainPropNum = binaryReader.Read7BitEncodedInt32();
			MaterialID = binaryReader.Read7BitEncodedInt32();
			MaterialNum = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
