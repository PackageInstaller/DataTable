using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRLevel : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int DefaultActiveBonfire { get; private set; }

	public string SceneName { get; private set; }

	public string MapData { get; private set; }

	public List<int> LevelNpcIDs { get; private set; }

	public int BGM { get; private set; }

	public List<int> BankGroups { get; private set; }

	public int NavMeshId { get; private set; }

	public List<int> TaskList { get; private set; }

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
		DefaultActiveBonfire = int.Parse(array[num++]);
		SceneName = array[num++];
		MapData = array[num++];
		LevelNpcIDs = DataTableExtension.ParseListInt(array[num++]);
		BGM = int.Parse(array[num++]);
		BankGroups = DataTableExtension.ParseListInt(array[num++]);
		NavMeshId = int.Parse(array[num++]);
		TaskList = DataTableExtension.ParseListInt(array[num++]);
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
			DefaultActiveBonfire = binaryReader.Read7BitEncodedInt32();
			SceneName = binaryReader.ReadString();
			MapData = binaryReader.ReadString();
			LevelNpcIDs = binaryReader.ReadListInt();
			BGM = binaryReader.Read7BitEncodedInt32();
			BankGroups = binaryReader.ReadListInt();
			NavMeshId = binaryReader.Read7BitEncodedInt32();
			TaskList = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
