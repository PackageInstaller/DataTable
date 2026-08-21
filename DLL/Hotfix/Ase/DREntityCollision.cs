using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREntityCollision : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<float> BobyCenter { get; private set; }

	public float BobyRadius { get; private set; }

	public float BobyHeight { get; private set; }

	public List<List<float>> OtherCapsuleCenter { get; private set; }

	public List<float> OtherCapsuleRadius { get; private set; }

	public List<float> OtherCapsuleHeight { get; private set; }

	public List<float> OtherSphereRadius { get; private set; }

	public List<List<float>> OtherSphereHeight { get; private set; }

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
		BobyCenter = DataTableExtension.ParseListFloat(array[num++]);
		BobyRadius = float.Parse(array[num++]);
		BobyHeight = float.Parse(array[num++]);
		OtherCapsuleCenter = DataTableExtension.ParseListFloatList(array[num++]);
		OtherCapsuleRadius = DataTableExtension.ParseListFloat(array[num++]);
		OtherCapsuleHeight = DataTableExtension.ParseListFloat(array[num++]);
		OtherSphereRadius = DataTableExtension.ParseListFloat(array[num++]);
		OtherSphereHeight = DataTableExtension.ParseListFloatList(array[num++]);
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
			BobyCenter = binaryReader.ReadListFloat();
			BobyRadius = binaryReader.ReadSingle();
			BobyHeight = binaryReader.ReadSingle();
			OtherCapsuleCenter = binaryReader.ReadListFloatList();
			OtherCapsuleRadius = binaryReader.ReadListFloat();
			OtherCapsuleHeight = binaryReader.ReadListFloat();
			OtherSphereRadius = binaryReader.ReadListFloat();
			OtherSphereHeight = binaryReader.ReadListFloatList();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
