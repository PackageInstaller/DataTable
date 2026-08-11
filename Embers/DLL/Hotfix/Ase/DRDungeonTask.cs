using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRDungeonTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TaskData { get; private set; }

	public int TaskType { get; private set; }

	public string TaskDesc { get; private set; }

	public int NextTask { get; private set; }

	public List<int> Monsters { get; private set; }

	public List<int> TargetMonsters { get; private set; }

	public int MessageType { get; private set; }

	public int DelayTime { get; private set; }

	public int LifeTime { get; private set; }

	public string MessageDesc { get; private set; }

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
		TaskData = int.Parse(array[num++]);
		TaskType = int.Parse(array[num++]);
		TaskDesc = array[num++];
		NextTask = int.Parse(array[num++]);
		Monsters = DataTableExtension.ParseListInt(array[num++]);
		TargetMonsters = DataTableExtension.ParseListInt(array[num++]);
		MessageType = int.Parse(array[num++]);
		DelayTime = int.Parse(array[num++]);
		LifeTime = int.Parse(array[num++]);
		MessageDesc = array[num++];
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
			TaskData = binaryReader.Read7BitEncodedInt32();
			TaskType = binaryReader.Read7BitEncodedInt32();
			TaskDesc = binaryReader.ReadString();
			NextTask = binaryReader.Read7BitEncodedInt32();
			Monsters = binaryReader.ReadListInt();
			TargetMonsters = binaryReader.ReadListInt();
			MessageType = binaryReader.Read7BitEncodedInt32();
			DelayTime = binaryReader.Read7BitEncodedInt32();
			LifeTime = binaryReader.Read7BitEncodedInt32();
			MessageDesc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
