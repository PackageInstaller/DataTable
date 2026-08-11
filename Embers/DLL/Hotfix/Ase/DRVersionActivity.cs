using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRVersionActivity : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActivityId { get; private set; }

	public List<int> UnlockType { get; private set; }

	public List<int> UnlockTarget { get; private set; }

	public List<int> UnlockNum { get; private set; }

	public int ConsumeType { get; private set; }

	public int ConsumeId { get; private set; }

	public int ConsumeNum { get; private set; }

	public int Type { get; private set; }

	public int Content { get; private set; }

	public int Drops { get; private set; }

	public string Name { get; private set; }

	public string Icon { get; private set; }

	public int RankFirst { get; private set; }

	public int RankSecond { get; private set; }

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
		ConsumeType = int.Parse(array[num++]);
		ConsumeId = int.Parse(array[num++]);
		ConsumeNum = int.Parse(array[num++]);
		Type = int.Parse(array[num++]);
		Content = int.Parse(array[num++]);
		Drops = int.Parse(array[num++]);
		Name = array[num++];
		Icon = array[num++];
		RankFirst = int.Parse(array[num++]);
		RankSecond = int.Parse(array[num++]);
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
			ConsumeType = binaryReader.Read7BitEncodedInt32();
			ConsumeId = binaryReader.Read7BitEncodedInt32();
			ConsumeNum = binaryReader.Read7BitEncodedInt32();
			Type = binaryReader.Read7BitEncodedInt32();
			Content = binaryReader.Read7BitEncodedInt32();
			Drops = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Icon = binaryReader.ReadString();
			RankFirst = binaryReader.Read7BitEncodedInt32();
			RankSecond = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
