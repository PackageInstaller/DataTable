using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREnvironmentModifier : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int EnvironmentType { get; private set; }

	public int TargetType { get; private set; }

	public int BuffId { get; private set; }

	public int ParadoxId { get; private set; }

	public string ParadoxName { get; private set; }

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
		EnvironmentType = int.Parse(array[num++]);
		TargetType = int.Parse(array[num++]);
		BuffId = int.Parse(array[num++]);
		ParadoxId = int.Parse(array[num++]);
		ParadoxName = array[num++];
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
			EnvironmentType = binaryReader.Read7BitEncodedInt32();
			TargetType = binaryReader.Read7BitEncodedInt32();
			BuffId = binaryReader.Read7BitEncodedInt32();
			ParadoxId = binaryReader.Read7BitEncodedInt32();
			ParadoxName = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
