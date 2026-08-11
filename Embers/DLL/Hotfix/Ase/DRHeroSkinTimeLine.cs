using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroSkinTimeLine : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int HeroSkin { get; private set; }

	public int ListID { get; private set; }

	public string Title { get; private set; }

	public string TLPaint { get; private set; }

	public int TLID { get; private set; }

	public int TLLock { get; private set; }

	public int LockParams { get; private set; }

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
		HeroSkin = int.Parse(array[num++]);
		ListID = int.Parse(array[num++]);
		Title = array[num++];
		TLPaint = array[num++];
		TLID = int.Parse(array[num++]);
		TLLock = int.Parse(array[num++]);
		LockParams = int.Parse(array[num++]);
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
			HeroSkin = binaryReader.Read7BitEncodedInt32();
			ListID = binaryReader.Read7BitEncodedInt32();
			Title = binaryReader.ReadString();
			TLPaint = binaryReader.ReadString();
			TLID = binaryReader.Read7BitEncodedInt32();
			TLLock = binaryReader.Read7BitEncodedInt32();
			LockParams = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
