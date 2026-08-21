using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRPassportTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TaskType { get; private set; }

	public int TargetType { get; private set; }

	public List<int> Condition { get; private set; }

	public List<List<int>> Target { get; private set; }

	public int TargetValue { get; private set; }

	public int EXP { get; private set; }

	public string TargetDesc { get; private set; }

	public string TargetWindow { get; private set; }

	public int WindowParams { get; private set; }

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
		TaskType = int.Parse(array[num++]);
		TargetType = int.Parse(array[num++]);
		Condition = DataTableExtension.ParseListInt(array[num++]);
		Target = DataTableExtension.ParseListIntList(array[num++]);
		TargetValue = int.Parse(array[num++]);
		EXP = int.Parse(array[num++]);
		TargetDesc = array[num++];
		TargetWindow = array[num++];
		WindowParams = int.Parse(array[num++]);
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
			TaskType = binaryReader.Read7BitEncodedInt32();
			TargetType = binaryReader.Read7BitEncodedInt32();
			Condition = binaryReader.ReadListInt();
			Target = binaryReader.ReadListIntList();
			TargetValue = binaryReader.Read7BitEncodedInt32();
			EXP = binaryReader.Read7BitEncodedInt32();
			TargetDesc = binaryReader.ReadString();
			TargetWindow = binaryReader.ReadString();
			WindowParams = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
