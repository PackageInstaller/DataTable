using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHomeComeTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TaskType { get; private set; }

	public int Sort { get; private set; }

	public int UnlockType { get; private set; }

	public string UnlockEx { get; private set; }

	public int FinishType { get; private set; }

	public List<int> FinishEx { get; private set; }

	public int Reward { get; private set; }

	public string TaskDesc { get; private set; }

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
		Sort = int.Parse(array[num++]);
		UnlockType = int.Parse(array[num++]);
		UnlockEx = array[num++];
		FinishType = int.Parse(array[num++]);
		FinishEx = DataTableExtension.ParseListInt(array[num++]);
		Reward = int.Parse(array[num++]);
		TaskDesc = array[num++];
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
			Sort = binaryReader.Read7BitEncodedInt32();
			UnlockType = binaryReader.Read7BitEncodedInt32();
			UnlockEx = binaryReader.ReadString();
			FinishType = binaryReader.Read7BitEncodedInt32();
			FinishEx = binaryReader.ReadListInt();
			Reward = binaryReader.Read7BitEncodedInt32();
			TaskDesc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
