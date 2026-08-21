using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRParadoxTimeline : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ShowForms { get; private set; }

	public string Path { get; private set; }

	public float Duration { get; private set; }

	public int Group { get; private set; }

	public int Priority { get; private set; }

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
		ShowForms = int.Parse(array[num++]);
		Path = array[num++];
		Duration = float.Parse(array[num++]);
		Group = int.Parse(array[num++]);
		Priority = int.Parse(array[num++]);
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
			ShowForms = binaryReader.Read7BitEncodedInt32();
			Path = binaryReader.ReadString();
			Duration = binaryReader.ReadSingle();
			Group = binaryReader.Read7BitEncodedInt32();
			Priority = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
