using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMoney : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int PropId { get; private set; }

	public int DisplayOrder { get; private set; }

	public long MaxCount { get; private set; }

	public bool DisplayMaxCount { get; private set; }

	public long CountLimitation { get; private set; }

	public bool IconBtnEnable { get; private set; }

	public bool GetBtnEnable { get; private set; }

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
		PropId = int.Parse(array[num++]);
		DisplayOrder = int.Parse(array[num++]);
		MaxCount = long.Parse(array[num++]);
		DisplayMaxCount = bool.Parse(array[num++]);
		CountLimitation = long.Parse(array[num++]);
		IconBtnEnable = bool.Parse(array[num++]);
		GetBtnEnable = bool.Parse(array[num++]);
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
			PropId = binaryReader.Read7BitEncodedInt32();
			DisplayOrder = binaryReader.Read7BitEncodedInt32();
			MaxCount = binaryReader.Read7BitEncodedInt64();
			DisplayMaxCount = binaryReader.ReadBoolean();
			CountLimitation = binaryReader.Read7BitEncodedInt64();
			IconBtnEnable = binaryReader.ReadBoolean();
			GetBtnEnable = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
