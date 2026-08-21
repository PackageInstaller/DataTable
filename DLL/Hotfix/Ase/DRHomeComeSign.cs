using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHomeComeSign : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int SignDate { get; private set; }

	public int SignType { get; private set; }

	public int SignReq { get; private set; }

	public string ReqEx { get; private set; }

	public int UnlockReq { get; private set; }

	public string UnlockEx { get; private set; }

	public int Reward { get; private set; }

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
		SignDate = int.Parse(array[num++]);
		SignType = int.Parse(array[num++]);
		SignReq = int.Parse(array[num++]);
		ReqEx = array[num++];
		UnlockReq = int.Parse(array[num++]);
		UnlockEx = array[num++];
		Reward = int.Parse(array[num++]);
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
			SignDate = binaryReader.Read7BitEncodedInt32();
			SignType = binaryReader.Read7BitEncodedInt32();
			SignReq = binaryReader.Read7BitEncodedInt32();
			ReqEx = binaryReader.ReadString();
			UnlockReq = binaryReader.Read7BitEncodedInt32();
			UnlockEx = binaryReader.ReadString();
			Reward = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
