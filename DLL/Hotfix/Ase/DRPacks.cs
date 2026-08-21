using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRPacks : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Quality { get; private set; }

	public string Name { get; private set; }

	public string Icon { get; private set; }

	public int ChooseType { get; private set; }

	public int ChooseNUM { get; private set; }

	public bool Auto_Open { get; private set; }

	public bool RandomRepeat { get; private set; }

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
		Quality = array[num++];
		Name = array[num++];
		Icon = array[num++];
		ChooseType = int.Parse(array[num++]);
		ChooseNUM = int.Parse(array[num++]);
		Auto_Open = bool.Parse(array[num++]);
		RandomRepeat = bool.Parse(array[num++]);
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
			Quality = binaryReader.ReadString();
			Name = binaryReader.ReadString();
			Icon = binaryReader.ReadString();
			ChooseType = binaryReader.Read7BitEncodedInt32();
			ChooseNUM = binaryReader.Read7BitEncodedInt32();
			Auto_Open = binaryReader.ReadBoolean();
			RandomRepeat = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
