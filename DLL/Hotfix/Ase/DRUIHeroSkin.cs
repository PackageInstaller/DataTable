using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRUIHeroSkin : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int HeroID { get; private set; }

	public int SkinRarity { get; private set; }

	public int Sort { get; private set; }

	public string SkinName { get; private set; }

	public string SkinDesc { get; private set; }

	public string SkinIcon { get; private set; }

	public string PropIcon { get; private set; }

	public string TagShow { get; private set; }

	public string Achieve { get; private set; }

	public string TargetWindow { get; private set; }

	public List<int> WindowParams { get; private set; }

	public string Suffix { get; private set; }

	public int SkinHead { get; private set; }

	public int GetVoice { get; private set; }

	public string SkinSexIcon { get; private set; }

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
		HeroID = int.Parse(array[num++]);
		SkinRarity = int.Parse(array[num++]);
		Sort = int.Parse(array[num++]);
		SkinName = array[num++];
		SkinDesc = array[num++];
		SkinIcon = array[num++];
		PropIcon = array[num++];
		TagShow = array[num++];
		Achieve = array[num++];
		TargetWindow = array[num++];
		WindowParams = DataTableExtension.ParseListInt(array[num++]);
		Suffix = array[num++];
		SkinHead = int.Parse(array[num++]);
		GetVoice = int.Parse(array[num++]);
		SkinSexIcon = array[num++];
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
			HeroID = binaryReader.Read7BitEncodedInt32();
			SkinRarity = binaryReader.Read7BitEncodedInt32();
			Sort = binaryReader.Read7BitEncodedInt32();
			SkinName = binaryReader.ReadString();
			SkinDesc = binaryReader.ReadString();
			SkinIcon = binaryReader.ReadString();
			PropIcon = binaryReader.ReadString();
			TagShow = binaryReader.ReadString();
			Achieve = binaryReader.ReadString();
			TargetWindow = binaryReader.ReadString();
			WindowParams = binaryReader.ReadListInt();
			Suffix = binaryReader.ReadString();
			SkinHead = binaryReader.Read7BitEncodedInt32();
			GetVoice = binaryReader.Read7BitEncodedInt32();
			SkinSexIcon = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
