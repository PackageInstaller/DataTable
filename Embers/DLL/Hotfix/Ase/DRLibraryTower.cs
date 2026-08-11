using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRLibraryTower : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int LibType { get; private set; }

	public int Type { get; private set; }

	public string TypeName { get; private set; }

	public List<int> BuffId { get; private set; }

	public string Icon { get; private set; }

	public int Quality { get; private set; }

	public int Sort { get; private set; }

	public string EffectDesc { get; private set; }

	public List<string> LevelDesc { get; private set; }

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
		LibType = int.Parse(array[num++]);
		Type = int.Parse(array[num++]);
		TypeName = array[num++];
		BuffId = DataTableExtension.ParseListInt(array[num++]);
		Icon = array[num++];
		Quality = int.Parse(array[num++]);
		Sort = int.Parse(array[num++]);
		EffectDesc = array[num++];
		LevelDesc = DataTableExtension.ParseListString(array[num++]);
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
			LibType = binaryReader.Read7BitEncodedInt32();
			Type = binaryReader.Read7BitEncodedInt32();
			TypeName = binaryReader.ReadString();
			BuffId = binaryReader.ReadListInt();
			Icon = binaryReader.ReadString();
			Quality = binaryReader.Read7BitEncodedInt32();
			Sort = binaryReader.Read7BitEncodedInt32();
			EffectDesc = binaryReader.ReadString();
			LevelDesc = binaryReader.ReadListString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
