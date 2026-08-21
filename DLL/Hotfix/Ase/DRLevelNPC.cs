using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRLevelNPC : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int LevelId { get; private set; }

	public int AreaId { get; private set; }

	public int NodeId { get; private set; }

	public bool DefaultActive { get; private set; }

	public bool DefaultVisible { get; private set; }

	public int Args { get; private set; }

	public List<int> DialogButtons { get; private set; }

	public List<int> Prologue { get; private set; }

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
		LevelId = int.Parse(array[num++]);
		AreaId = int.Parse(array[num++]);
		NodeId = int.Parse(array[num++]);
		DefaultActive = bool.Parse(array[num++]);
		DefaultVisible = bool.Parse(array[num++]);
		Args = int.Parse(array[num++]);
		DialogButtons = DataTableExtension.ParseListInt(array[num++]);
		Prologue = DataTableExtension.ParseListInt(array[num++]);
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
			LevelId = binaryReader.Read7BitEncodedInt32();
			AreaId = binaryReader.Read7BitEncodedInt32();
			NodeId = binaryReader.Read7BitEncodedInt32();
			DefaultActive = binaryReader.ReadBoolean();
			DefaultVisible = binaryReader.ReadBoolean();
			Args = binaryReader.Read7BitEncodedInt32();
			DialogButtons = binaryReader.ReadListInt();
			Prologue = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
