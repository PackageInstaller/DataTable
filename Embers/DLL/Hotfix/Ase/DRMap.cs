using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMap : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int MapId { get; private set; }

	public int DisplayPriority { get; private set; }

	public string Name { get; private set; }

	public string SceneName { get; private set; }

	public List<float> MapSize { get; private set; }

	public List<float> MapGridSize { get; private set; }

	public string MapPrefabPath { get; private set; }

	public string MapLoadAssetPath { get; private set; }

	public string AssetPathPrefix { get; private set; }

	public string MiniMapPath { get; private set; }

	public int DefaultActiveMapMaskId { get; private set; }

	public List<int> TexelSize { get; private set; }

	public string MapMaskPath { get; private set; }

	public string MaskAlphaPath { get; private set; }

	public List<int> TransferPoint { get; private set; }

	public List<int> IncludeCopies { get; private set; }

	public List<int> CavernId { get; private set; }

	public List<int> MonsterType { get; private set; }

	public List<int> ResourceType { get; private set; }

	public List<List<float>> ResourcePosition { get; private set; }

	public List<float> InitPos { get; private set; }

	public List<float> WorldPosOffset { get; private set; }

	public List<float> Scale { get; private set; }

	public float ContentScale { get; private set; }

	public int MatchTeamLevel { get; private set; }

	public int Open { get; private set; }

	public int OpenType { get; private set; }

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
		MapId = int.Parse(array[num++]);
		DisplayPriority = int.Parse(array[num++]);
		Name = array[num++];
		SceneName = array[num++];
		MapSize = DataTableExtension.ParseListFloat(array[num++]);
		MapGridSize = DataTableExtension.ParseListFloat(array[num++]);
		MapPrefabPath = array[num++];
		MapLoadAssetPath = array[num++];
		AssetPathPrefix = array[num++];
		MiniMapPath = array[num++];
		DefaultActiveMapMaskId = int.Parse(array[num++]);
		TexelSize = DataTableExtension.ParseListInt(array[num++]);
		MapMaskPath = array[num++];
		MaskAlphaPath = array[num++];
		TransferPoint = DataTableExtension.ParseListInt(array[num++]);
		IncludeCopies = DataTableExtension.ParseListInt(array[num++]);
		CavernId = DataTableExtension.ParseListInt(array[num++]);
		MonsterType = DataTableExtension.ParseListInt(array[num++]);
		ResourceType = DataTableExtension.ParseListInt(array[num++]);
		ResourcePosition = DataTableExtension.ParseListFloatList(array[num++]);
		InitPos = DataTableExtension.ParseListFloat(array[num++]);
		WorldPosOffset = DataTableExtension.ParseListFloat(array[num++]);
		Scale = DataTableExtension.ParseListFloat(array[num++]);
		ContentScale = float.Parse(array[num++]);
		MatchTeamLevel = int.Parse(array[num++]);
		Open = int.Parse(array[num++]);
		OpenType = int.Parse(array[num++]);
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
			MapId = binaryReader.Read7BitEncodedInt32();
			DisplayPriority = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			SceneName = binaryReader.ReadString();
			MapSize = binaryReader.ReadListFloat();
			MapGridSize = binaryReader.ReadListFloat();
			MapPrefabPath = binaryReader.ReadString();
			MapLoadAssetPath = binaryReader.ReadString();
			AssetPathPrefix = binaryReader.ReadString();
			MiniMapPath = binaryReader.ReadString();
			DefaultActiveMapMaskId = binaryReader.Read7BitEncodedInt32();
			TexelSize = binaryReader.ReadListInt();
			MapMaskPath = binaryReader.ReadString();
			MaskAlphaPath = binaryReader.ReadString();
			TransferPoint = binaryReader.ReadListInt();
			IncludeCopies = binaryReader.ReadListInt();
			CavernId = binaryReader.ReadListInt();
			MonsterType = binaryReader.ReadListInt();
			ResourceType = binaryReader.ReadListInt();
			ResourcePosition = binaryReader.ReadListFloatList();
			InitPos = binaryReader.ReadListFloat();
			WorldPosOffset = binaryReader.ReadListFloat();
			Scale = binaryReader.ReadListFloat();
			ContentScale = binaryReader.ReadSingle();
			MatchTeamLevel = binaryReader.Read7BitEncodedInt32();
			Open = binaryReader.Read7BitEncodedInt32();
			OpenType = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
