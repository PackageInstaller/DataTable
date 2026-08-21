using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHomeLandLevelEffect : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Unit { get; private set; }

	public bool IsPrefix { get; private set; }

	public bool ShowValue { get; private set; }

	public float InitValue { get; private set; }

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
		Unit = array[num++];
		IsPrefix = bool.Parse(array[num++]);
		ShowValue = bool.Parse(array[num++]);
		InitValue = float.Parse(array[num++]);
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
			Unit = binaryReader.ReadString();
			IsPrefix = binaryReader.ReadBoolean();
			ShowValue = binaryReader.ReadBoolean();
			InitValue = binaryReader.ReadSingle();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
