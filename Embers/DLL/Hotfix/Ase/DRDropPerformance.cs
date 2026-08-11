using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRDropPerformance : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Desc { get; private set; }

	public string ResourcePath { get; private set; }

	public List<float> DropScope { get; private set; }

	public float StayTime { get; private set; }

	public float FlightSpeed { get; private set; }

	public float DropHeight { get; private set; }

	public float DropSpeed { get; private set; }

	public float PickScope { get; private set; }

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
		Desc = array[num++];
		ResourcePath = array[num++];
		DropScope = DataTableExtension.ParseListFloat(array[num++]);
		StayTime = float.Parse(array[num++]);
		FlightSpeed = float.Parse(array[num++]);
		DropHeight = float.Parse(array[num++]);
		DropSpeed = float.Parse(array[num++]);
		PickScope = float.Parse(array[num++]);
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
			Desc = binaryReader.ReadString();
			ResourcePath = binaryReader.ReadString();
			DropScope = binaryReader.ReadListFloat();
			StayTime = binaryReader.ReadSingle();
			FlightSpeed = binaryReader.ReadSingle();
			DropHeight = binaryReader.ReadSingle();
			DropSpeed = binaryReader.ReadSingle();
			PickScope = binaryReader.ReadSingle();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
