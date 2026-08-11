using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBoardBackGround : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string IconPath { get; private set; }

	public string AssetPath { get; private set; }

	public int MapId { get; private set; }

	public List<float> FgimageScale { get; private set; }

	public List<float> FgimagePosition { get; private set; }

	public List<float> OriginalScale { get; private set; }

	public List<float> OriginalPosition { get; private set; }

	public int Quality { get; private set; }

	public string Name { get; private set; }

	public string Icon { get; private set; }

	public string Desc { get; private set; }

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
		IconPath = array[num++];
		AssetPath = array[num++];
		MapId = int.Parse(array[num++]);
		FgimageScale = DataTableExtension.ParseListFloat(array[num++]);
		FgimagePosition = DataTableExtension.ParseListFloat(array[num++]);
		OriginalScale = DataTableExtension.ParseListFloat(array[num++]);
		OriginalPosition = DataTableExtension.ParseListFloat(array[num++]);
		Quality = int.Parse(array[num++]);
		Name = array[num++];
		Icon = array[num++];
		Desc = array[num++];
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
			IconPath = binaryReader.ReadString();
			AssetPath = binaryReader.ReadString();
			MapId = binaryReader.Read7BitEncodedInt32();
			FgimageScale = binaryReader.ReadListFloat();
			FgimagePosition = binaryReader.ReadListFloat();
			OriginalScale = binaryReader.ReadListFloat();
			OriginalPosition = binaryReader.ReadListFloat();
			Quality = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Icon = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
