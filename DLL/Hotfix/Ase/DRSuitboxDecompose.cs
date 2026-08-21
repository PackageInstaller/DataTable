using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSuitboxDecompose : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Rarity { get; private set; }

	public int Rank { get; private set; }

	public List<int> Item { get; private set; }

	public List<int> Num { get; private set; }

	public float Recovery { get; private set; }

	public int RecoveryItem { get; private set; }

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
		Rarity = int.Parse(array[num++]);
		Rank = int.Parse(array[num++]);
		Item = DataTableExtension.ParseListInt(array[num++]);
		Num = DataTableExtension.ParseListInt(array[num++]);
		Recovery = float.Parse(array[num++]);
		RecoveryItem = int.Parse(array[num++]);
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
			Rarity = binaryReader.Read7BitEncodedInt32();
			Rank = binaryReader.Read7BitEncodedInt32();
			Item = binaryReader.ReadListInt();
			Num = binaryReader.ReadListInt();
			Recovery = binaryReader.ReadSingle();
			RecoveryItem = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
