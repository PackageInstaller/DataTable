using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSuitbox : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Icon { get; private set; }

	public string PreIcon { get; private set; }

	public int Rarity { get; private set; }

	public int Rank { get; private set; }

	public int BuffPool { get; private set; }

	public int EntryPool { get; private set; }

	public int InitialNum { get; private set; }

	public int MaxLevel { get; private set; }

	public int MaxType { get; private set; }

	public string Desc { get; private set; }

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
		Name = array[num++];
		Icon = array[num++];
		PreIcon = array[num++];
		Rarity = int.Parse(array[num++]);
		Rank = int.Parse(array[num++]);
		BuffPool = int.Parse(array[num++]);
		EntryPool = int.Parse(array[num++]);
		InitialNum = int.Parse(array[num++]);
		MaxLevel = int.Parse(array[num++]);
		MaxType = int.Parse(array[num++]);
		Desc = array[num++];
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
			Name = binaryReader.ReadString();
			Icon = binaryReader.ReadString();
			PreIcon = binaryReader.ReadString();
			Rarity = binaryReader.Read7BitEncodedInt32();
			Rank = binaryReader.Read7BitEncodedInt32();
			BuffPool = binaryReader.Read7BitEncodedInt32();
			EntryPool = binaryReader.Read7BitEncodedInt32();
			InitialNum = binaryReader.Read7BitEncodedInt32();
			MaxLevel = binaryReader.Read7BitEncodedInt32();
			MaxType = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
