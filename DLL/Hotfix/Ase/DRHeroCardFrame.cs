using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroCardFrame : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int PropId { get; private set; }

	public int PropType { get; private set; }

	public string Name { get; private set; }

	public int IdGroup { get; private set; }

	public string Icon { get; private set; }

	public string TipsIcon { get; private set; }

	public string EdgePath { get; private set; }

	public string ItemPath { get; private set; }

	public int Quality { get; private set; }

	public int TimeLimited { get; private set; }

	public string Time { get; private set; }

	public int Sort { get; private set; }

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
		PropId = int.Parse(array[num++]);
		PropType = int.Parse(array[num++]);
		Name = array[num++];
		IdGroup = int.Parse(array[num++]);
		Icon = array[num++];
		TipsIcon = array[num++];
		EdgePath = array[num++];
		ItemPath = array[num++];
		Quality = int.Parse(array[num++]);
		TimeLimited = int.Parse(array[num++]);
		Time = array[num++];
		Sort = int.Parse(array[num++]);
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
			PropId = binaryReader.Read7BitEncodedInt32();
			PropType = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			IdGroup = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			TipsIcon = binaryReader.ReadString();
			EdgePath = binaryReader.ReadString();
			ItemPath = binaryReader.ReadString();
			Quality = binaryReader.Read7BitEncodedInt32();
			TimeLimited = binaryReader.Read7BitEncodedInt32();
			Time = binaryReader.ReadString();
			Sort = binaryReader.Read7BitEncodedInt32();
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
