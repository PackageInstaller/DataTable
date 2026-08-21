using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRActivityRankProgress : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActivityTypeId { get; private set; }

	public int ShowType { get; private set; }

	public int Progress { get; private set; }

	public int UnLockType { get; private set; }

	public List<int> UnlockRange { get; private set; }

	public int UnlockPropId { get; private set; }

	public int UnlockNum { get; private set; }

	public int RewardId { get; private set; }

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
		ActivityTypeId = int.Parse(array[num++]);
		ShowType = int.Parse(array[num++]);
		Progress = int.Parse(array[num++]);
		UnLockType = int.Parse(array[num++]);
		UnlockRange = DataTableExtension.ParseListInt(array[num++]);
		UnlockPropId = int.Parse(array[num++]);
		UnlockNum = int.Parse(array[num++]);
		RewardId = int.Parse(array[num++]);
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
			ActivityTypeId = binaryReader.Read7BitEncodedInt32();
			ShowType = binaryReader.Read7BitEncodedInt32();
			Progress = binaryReader.Read7BitEncodedInt32();
			UnLockType = binaryReader.Read7BitEncodedInt32();
			UnlockRange = binaryReader.ReadListInt();
			UnlockPropId = binaryReader.Read7BitEncodedInt32();
			UnlockNum = binaryReader.Read7BitEncodedInt32();
			RewardId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
