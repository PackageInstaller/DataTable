using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSystemOpen : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int OpenLevel { get; private set; }

	public int OpenTask { get; private set; }

	public int OpenList { get; private set; }

	public int Guidance { get; private set; }

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
		OpenLevel = int.Parse(array[num++]);
		OpenTask = int.Parse(array[num++]);
		OpenList = int.Parse(array[num++]);
		Guidance = int.Parse(array[num++]);
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
			OpenLevel = binaryReader.Read7BitEncodedInt32();
			OpenTask = binaryReader.Read7BitEncodedInt32();
			OpenList = binaryReader.Read7BitEncodedInt32();
			Guidance = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
