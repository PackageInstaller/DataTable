using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREquipmentFilter : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TypeId { get; private set; }

	public string Choice { get; private set; }

	public int MatchId { get; private set; }

	public bool IsAcquiesce { get; private set; }

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
		TypeId = int.Parse(array[num++]);
		Choice = array[num++];
		MatchId = int.Parse(array[num++]);
		IsAcquiesce = bool.Parse(array[num++]);
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
			TypeId = binaryReader.Read7BitEncodedInt32();
			Choice = binaryReader.ReadString();
			MatchId = binaryReader.Read7BitEncodedInt32();
			IsAcquiesce = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
