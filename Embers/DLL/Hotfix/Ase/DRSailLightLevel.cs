using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSailLightLevel : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public float Odd { get; private set; }

	public int EventCount { get; private set; }

	public int MaxSailCount { get; private set; }

	public float RewardMultiplier { get; private set; }

	public int Guaranteed { get; private set; }

	public int PurpleOdd { get; private set; }

	public int GoldenOdd { get; private set; }

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
		Odd = float.Parse(array[num++]);
		EventCount = int.Parse(array[num++]);
		MaxSailCount = int.Parse(array[num++]);
		RewardMultiplier = float.Parse(array[num++]);
		Guaranteed = int.Parse(array[num++]);
		PurpleOdd = int.Parse(array[num++]);
		GoldenOdd = int.Parse(array[num++]);
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
			Odd = binaryReader.ReadSingle();
			EventCount = binaryReader.Read7BitEncodedInt32();
			MaxSailCount = binaryReader.Read7BitEncodedInt32();
			RewardMultiplier = binaryReader.ReadSingle();
			Guaranteed = binaryReader.Read7BitEncodedInt32();
			PurpleOdd = binaryReader.Read7BitEncodedInt32();
			GoldenOdd = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
