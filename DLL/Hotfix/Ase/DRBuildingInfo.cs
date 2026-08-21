using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBuildingInfo : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Icon { get; private set; }

	public string IconText { get; private set; }

	public int NeedHomelandLevel { get; private set; }

	public int MaxLevel { get; private set; }

	public string Desc { get; private set; }

	public string PlayDesc { get; private set; }

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
		Icon = array[num++];
		IconText = array[num++];
		NeedHomelandLevel = int.Parse(array[num++]);
		MaxLevel = int.Parse(array[num++]);
		Desc = array[num++];
		PlayDesc = array[num++];
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
			Icon = binaryReader.ReadString();
			IconText = binaryReader.ReadString();
			NeedHomelandLevel = binaryReader.Read7BitEncodedInt32();
			MaxLevel = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
			PlayDesc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
