using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRTitle : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Source { get; private set; }

	public string Icon { get; private set; }

	public string TitleIcon { get; private set; }

	public int Quality { get; private set; }

	public int TimeLimited { get; private set; }

	public string Time { get; private set; }

	public int Type { get; private set; }

	public int EX { get; private set; }

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
		Source = array[num++];
		Icon = array[num++];
		TitleIcon = array[num++];
		Quality = int.Parse(array[num++]);
		TimeLimited = int.Parse(array[num++]);
		Time = array[num++];
		Type = int.Parse(array[num++]);
		EX = int.Parse(array[num++]);
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
			Source = binaryReader.ReadString();
			Icon = binaryReader.ReadString();
			TitleIcon = binaryReader.ReadString();
			Quality = binaryReader.Read7BitEncodedInt32();
			TimeLimited = binaryReader.Read7BitEncodedInt32();
			Time = binaryReader.ReadString();
			Type = binaryReader.Read7BitEncodedInt32();
			EX = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
