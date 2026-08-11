using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGuidance : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Index { get; private set; }

	public List<int> GuidanceSteps { get; private set; }

	public bool IsSave { get; private set; }

	public List<int> NextGuidance { get; private set; }

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
		Index = int.Parse(array[num++]);
		GuidanceSteps = DataTableExtension.ParseListInt(array[num++]);
		IsSave = bool.Parse(array[num++]);
		NextGuidance = DataTableExtension.ParseListInt(array[num++]);
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
			Index = binaryReader.Read7BitEncodedInt32();
			GuidanceSteps = binaryReader.ReadListInt();
			IsSave = binaryReader.ReadBoolean();
			NextGuidance = binaryReader.ReadListInt();
			Priority = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
