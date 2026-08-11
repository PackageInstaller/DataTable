using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGuildFunction : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string OpenTime { get; private set; }

	public int RefreshType { get; private set; }

	public int RefreshConfig { get; private set; }

	public int TryType { get; private set; }

	public int TryNum { get; private set; }

	public int TryNumLimit { get; private set; }

	public string StartTime { get; private set; }

	public string EndTime { get; private set; }

	public int RefreshTime { get; private set; }

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
		OpenTime = array[num++];
		RefreshType = int.Parse(array[num++]);
		RefreshConfig = int.Parse(array[num++]);
		TryType = int.Parse(array[num++]);
		TryNum = int.Parse(array[num++]);
		TryNumLimit = int.Parse(array[num++]);
		StartTime = array[num++];
		EndTime = array[num++];
		RefreshTime = int.Parse(array[num++]);
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
			OpenTime = binaryReader.ReadString();
			RefreshType = binaryReader.Read7BitEncodedInt32();
			RefreshConfig = binaryReader.Read7BitEncodedInt32();
			TryType = binaryReader.Read7BitEncodedInt32();
			TryNum = binaryReader.Read7BitEncodedInt32();
			TryNumLimit = binaryReader.Read7BitEncodedInt32();
			StartTime = binaryReader.ReadString();
			EndTime = binaryReader.ReadString();
			RefreshTime = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
