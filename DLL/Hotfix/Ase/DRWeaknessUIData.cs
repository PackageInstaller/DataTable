using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRWeaknessUIData : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<int> Datas { get; private set; }

	public float WeaknessDelayTime { get; private set; }

	public float WeaknessKeepTime { get; private set; }

	public float WeaknessViewLength { get; private set; }

	public float WeaknessViewHeight { get; private set; }

	public float WeaknessFade { get; private set; }

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
		Datas = DataTableExtension.ParseListInt(array[num++]);
		WeaknessDelayTime = float.Parse(array[num++]);
		WeaknessKeepTime = float.Parse(array[num++]);
		WeaknessViewLength = float.Parse(array[num++]);
		WeaknessViewHeight = float.Parse(array[num++]);
		WeaknessFade = float.Parse(array[num++]);
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
			Datas = binaryReader.ReadListInt();
			WeaknessDelayTime = binaryReader.ReadSingle();
			WeaknessKeepTime = binaryReader.ReadSingle();
			WeaknessViewLength = binaryReader.ReadSingle();
			WeaknessViewHeight = binaryReader.ReadSingle();
			WeaknessFade = binaryReader.ReadSingle();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
