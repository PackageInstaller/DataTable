using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGuildJobInfo : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Buff { get; private set; }

	public int Apply { get; private set; }

	public int Find { get; private set; }

	public int ApplySetting { get; private set; }

	public int AimChange { get; private set; }

	public int Dismis { get; private set; }

	public int JobChange { get; private set; }

	public int InfoChange { get; private set; }

	public int LevUp { get; private set; }

	public int Dissolve { get; private set; }

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
		Buff = int.Parse(array[num++]);
		Apply = int.Parse(array[num++]);
		Find = int.Parse(array[num++]);
		ApplySetting = int.Parse(array[num++]);
		AimChange = int.Parse(array[num++]);
		Dismis = int.Parse(array[num++]);
		JobChange = int.Parse(array[num++]);
		InfoChange = int.Parse(array[num++]);
		LevUp = int.Parse(array[num++]);
		Dissolve = int.Parse(array[num++]);
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
			Buff = binaryReader.Read7BitEncodedInt32();
			Apply = binaryReader.Read7BitEncodedInt32();
			Find = binaryReader.Read7BitEncodedInt32();
			ApplySetting = binaryReader.Read7BitEncodedInt32();
			AimChange = binaryReader.Read7BitEncodedInt32();
			Dismis = binaryReader.Read7BitEncodedInt32();
			JobChange = binaryReader.Read7BitEncodedInt32();
			InfoChange = binaryReader.Read7BitEncodedInt32();
			LevUp = binaryReader.Read7BitEncodedInt32();
			Dissolve = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
