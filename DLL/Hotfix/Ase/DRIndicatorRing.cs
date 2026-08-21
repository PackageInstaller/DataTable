using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRIndicatorRing : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Type { get; private set; }

	public string Name { get; private set; }

	public int Sort { get; private set; }

	public int GroupId { get; private set; }

	public string Icon { get; private set; }

	public int ResPath { get; private set; }

	public int Quality { get; private set; }

	public List<int> UnlockType { get; private set; }

	public List<int> UnlockPara { get; private set; }

	public List<string> UnlockTime { get; private set; }

	public string AppTxt { get; private set; }

	public string BgsTxt { get; private set; }

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
		Type = int.Parse(array[num++]);
		Name = array[num++];
		Sort = int.Parse(array[num++]);
		GroupId = int.Parse(array[num++]);
		Icon = array[num++];
		ResPath = int.Parse(array[num++]);
		Quality = int.Parse(array[num++]);
		UnlockType = DataTableExtension.ParseListInt(array[num++]);
		UnlockPara = DataTableExtension.ParseListInt(array[num++]);
		UnlockTime = DataTableExtension.ParseListString(array[num++]);
		AppTxt = array[num++];
		BgsTxt = array[num++];
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
			Type = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Sort = binaryReader.Read7BitEncodedInt32();
			GroupId = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			ResPath = binaryReader.Read7BitEncodedInt32();
			Quality = binaryReader.Read7BitEncodedInt32();
			UnlockType = binaryReader.ReadListInt();
			UnlockPara = binaryReader.ReadListInt();
			UnlockTime = binaryReader.ReadListString();
			AppTxt = binaryReader.ReadString();
			BgsTxt = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
