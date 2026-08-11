using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBoardHeroList : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int HeroId { get; private set; }

	public int HeroSkinId { get; private set; }

	public int StateType { get; private set; }

	public string IconPath { get; private set; }

	public string AssetPath { get; private set; }

	public List<float> Scale { get; private set; }

	public List<float> Position { get; private set; }

	public bool MultiClass { get; private set; }

	public string SexIconPath { get; private set; }

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
		HeroId = int.Parse(array[num++]);
		HeroSkinId = int.Parse(array[num++]);
		StateType = int.Parse(array[num++]);
		IconPath = array[num++];
		AssetPath = array[num++];
		Scale = DataTableExtension.ParseListFloat(array[num++]);
		Position = DataTableExtension.ParseListFloat(array[num++]);
		MultiClass = bool.Parse(array[num++]);
		SexIconPath = array[num++];
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
			HeroId = binaryReader.Read7BitEncodedInt32();
			HeroSkinId = binaryReader.Read7BitEncodedInt32();
			StateType = binaryReader.Read7BitEncodedInt32();
			IconPath = binaryReader.ReadString();
			AssetPath = binaryReader.ReadString();
			Scale = binaryReader.ReadListFloat();
			Position = binaryReader.ReadListFloat();
			MultiClass = binaryReader.ReadBoolean();
			SexIconPath = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
