using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCopyDrop : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int RewardGroupId { get; private set; }

	public int DropeType { get; private set; }

	public List<string> DropDesc { get; private set; }

	public List<int> DropGroupId { get; private set; }

	public List<int> CopyPropTypeShow { get; private set; }

	public List<int> CopyPropIDShow { get; private set; }

	public List<int> PropTypeShow { get; private set; }

	public List<int> IsShowNum { get; private set; }

	public List<string> PropNumShow { get; private set; }

	public List<int> PropIDShow { get; private set; }

	public List<int> FirstDropShow { get; private set; }

	public List<int> FirstDropNum { get; private set; }

	public List<int> FirstDropType { get; private set; }

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
		RewardGroupId = int.Parse(array[num++]);
		DropeType = int.Parse(array[num++]);
		DropDesc = DataTableExtension.ParseListString(array[num++]);
		DropGroupId = DataTableExtension.ParseListInt(array[num++]);
		CopyPropTypeShow = DataTableExtension.ParseListInt(array[num++]);
		CopyPropIDShow = DataTableExtension.ParseListInt(array[num++]);
		PropTypeShow = DataTableExtension.ParseListInt(array[num++]);
		IsShowNum = DataTableExtension.ParseListInt(array[num++]);
		PropNumShow = DataTableExtension.ParseListString(array[num++]);
		PropIDShow = DataTableExtension.ParseListInt(array[num++]);
		FirstDropShow = DataTableExtension.ParseListInt(array[num++]);
		FirstDropNum = DataTableExtension.ParseListInt(array[num++]);
		FirstDropType = DataTableExtension.ParseListInt(array[num++]);
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
			RewardGroupId = binaryReader.Read7BitEncodedInt32();
			DropeType = binaryReader.Read7BitEncodedInt32();
			DropDesc = binaryReader.ReadListString();
			DropGroupId = binaryReader.ReadListInt();
			CopyPropTypeShow = binaryReader.ReadListInt();
			CopyPropIDShow = binaryReader.ReadListInt();
			PropTypeShow = binaryReader.ReadListInt();
			IsShowNum = binaryReader.ReadListInt();
			PropNumShow = binaryReader.ReadListString();
			PropIDShow = binaryReader.ReadListInt();
			FirstDropShow = binaryReader.ReadListInt();
			FirstDropNum = binaryReader.ReadListInt();
			FirstDropType = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
