using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRVoice : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ObjectId { get; private set; }

	public int HeroSkinId { get; private set; }

	public int VoiceEnum { get; private set; }

	public int Type { get; private set; }

	public string VoiceTitle { get; private set; }

	public int LockType { get; private set; }

	public int LockNum { get; private set; }

	public int VoiceId { get; private set; }

	public List<string> Config { get; private set; }

	public List<int> ConfigNum { get; private set; }

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
		ObjectId = int.Parse(array[num++]);
		HeroSkinId = int.Parse(array[num++]);
		VoiceEnum = int.Parse(array[num++]);
		Type = int.Parse(array[num++]);
		VoiceTitle = array[num++];
		LockType = int.Parse(array[num++]);
		LockNum = int.Parse(array[num++]);
		VoiceId = int.Parse(array[num++]);
		Config = DataTableExtension.ParseListString(array[num++]);
		ConfigNum = DataTableExtension.ParseListInt(array[num++]);
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
			ObjectId = binaryReader.Read7BitEncodedInt32();
			HeroSkinId = binaryReader.Read7BitEncodedInt32();
			VoiceEnum = binaryReader.Read7BitEncodedInt32();
			Type = binaryReader.Read7BitEncodedInt32();
			VoiceTitle = binaryReader.ReadString();
			LockType = binaryReader.Read7BitEncodedInt32();
			LockNum = binaryReader.Read7BitEncodedInt32();
			VoiceId = binaryReader.Read7BitEncodedInt32();
			Config = binaryReader.ReadListString();
			ConfigNum = binaryReader.ReadListInt();
			Desc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
