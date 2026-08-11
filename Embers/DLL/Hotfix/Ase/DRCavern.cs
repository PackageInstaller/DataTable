using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCavern : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int LevelId { get; private set; }

	public string CavernName { get; private set; }

	public List<float> MapSize { get; private set; }

	public List<float> MapGridSize { get; private set; }

	public float MapSenceScale { get; private set; }

	public string MapPrefabPath { get; private set; }

	public string MiniMapPath { get; private set; }

	public int DefaultActiveMapMaskId { get; private set; }

	public List<int> TexelSize { get; private set; }

	public string MapMaskPath { get; private set; }

	public string MaskAlphaPath { get; private set; }

	public List<int> CavernPoint { get; private set; }

	public List<float> InitPos { get; private set; }

	public List<float> Scale { get; private set; }

	public List<float> Cavernpoint { get; private set; }

	public float ContentScale { get; private set; }

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
		LevelId = int.Parse(array[num++]);
		CavernName = array[num++];
		MapSize = DataTableExtension.ParseListFloat(array[num++]);
		MapGridSize = DataTableExtension.ParseListFloat(array[num++]);
		MapSenceScale = float.Parse(array[num++]);
		MapPrefabPath = array[num++];
		MiniMapPath = array[num++];
		DefaultActiveMapMaskId = int.Parse(array[num++]);
		TexelSize = DataTableExtension.ParseListInt(array[num++]);
		MapMaskPath = array[num++];
		MaskAlphaPath = array[num++];
		CavernPoint = DataTableExtension.ParseListInt(array[num++]);
		InitPos = DataTableExtension.ParseListFloat(array[num++]);
		Scale = DataTableExtension.ParseListFloat(array[num++]);
		Cavernpoint = DataTableExtension.ParseListFloat(array[num++]);
		ContentScale = float.Parse(array[num++]);
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
			LevelId = binaryReader.Read7BitEncodedInt32();
			CavernName = binaryReader.ReadString();
			MapSize = binaryReader.ReadListFloat();
			MapGridSize = binaryReader.ReadListFloat();
			MapSenceScale = binaryReader.ReadSingle();
			MapPrefabPath = binaryReader.ReadString();
			MiniMapPath = binaryReader.ReadString();
			DefaultActiveMapMaskId = binaryReader.Read7BitEncodedInt32();
			TexelSize = binaryReader.ReadListInt();
			MapMaskPath = binaryReader.ReadString();
			MaskAlphaPath = binaryReader.ReadString();
			CavernPoint = binaryReader.ReadListInt();
			InitPos = binaryReader.ReadListFloat();
			Scale = binaryReader.ReadListFloat();
			Cavernpoint = binaryReader.ReadListFloat();
			ContentScale = binaryReader.ReadSingle();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
