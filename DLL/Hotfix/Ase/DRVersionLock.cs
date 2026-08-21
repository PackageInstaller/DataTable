using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRVersionLock : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActivityId { get; private set; }

	public List<int> UnlockType { get; private set; }

	public List<int> UnlockTarget { get; private set; }

	public List<int> UnlockNum { get; private set; }

	public int Rank { get; private set; }

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
		ActivityId = int.Parse(array[num++]);
		UnlockType = DataTableExtension.ParseListInt(array[num++]);
		UnlockTarget = DataTableExtension.ParseListInt(array[num++]);
		UnlockNum = DataTableExtension.ParseListInt(array[num++]);
		Rank = int.Parse(array[num++]);
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
			ActivityId = binaryReader.Read7BitEncodedInt32();
			UnlockType = binaryReader.ReadListInt();
			UnlockTarget = binaryReader.ReadListInt();
			UnlockNum = binaryReader.ReadListInt();
			Rank = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
