using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRPopupTip : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string IconUrl { get; private set; }

	public string Text { get; private set; }

	public int Type { get; private set; }

	public float WaitTime { get; private set; }

	public float Frames { get; private set; }

	public float Fadeout { get; private set; }

	public int VoiceId { get; private set; }

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
		Name = array[num++];
		IconUrl = array[num++];
		Text = array[num++];
		Type = int.Parse(array[num++]);
		WaitTime = float.Parse(array[num++]);
		Frames = float.Parse(array[num++]);
		Fadeout = float.Parse(array[num++]);
		VoiceId = int.Parse(array[num++]);
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
			Name = binaryReader.ReadString();
			IconUrl = binaryReader.ReadString();
			Text = binaryReader.ReadString();
			Type = binaryReader.Read7BitEncodedInt32();
			WaitTime = binaryReader.ReadSingle();
			Frames = binaryReader.ReadSingle();
			Fadeout = binaryReader.ReadSingle();
			VoiceId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
