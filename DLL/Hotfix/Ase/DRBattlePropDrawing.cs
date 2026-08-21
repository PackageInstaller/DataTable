using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBattlePropDrawing : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int Quality { get; private set; }

	public string Icon { get; private set; }

	public string Function { get; private set; }

	public int TeamId { get; private set; }

	public int SendNum { get; private set; }

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
		Quality = int.Parse(array[num++]);
		Icon = array[num++];
		Function = array[num++];
		TeamId = int.Parse(array[num++]);
		SendNum = int.Parse(array[num++]);
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
			Quality = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			Function = binaryReader.ReadString();
			TeamId = binaryReader.Read7BitEncodedInt32();
			SendNum = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
