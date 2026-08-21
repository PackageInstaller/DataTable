using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRRareUp : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string ModelName { get; private set; }

	public int Quality { get; private set; }

	public int Type { get; private set; }

	public List<int> EffectsType { get; private set; }

	public List<string> EffectsName { get; private set; }

	public List<string> PreModel { get; private set; }

	public string Trailing { get; private set; }

	public string Lighting { get; private set; }

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
		ModelName = array[num++];
		Quality = int.Parse(array[num++]);
		Type = int.Parse(array[num++]);
		EffectsType = DataTableExtension.ParseListInt(array[num++]);
		EffectsName = DataTableExtension.ParseListString(array[num++]);
		PreModel = DataTableExtension.ParseListString(array[num++]);
		Trailing = array[num++];
		Lighting = array[num++];
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
			ModelName = binaryReader.ReadString();
			Quality = binaryReader.Read7BitEncodedInt32();
			Type = binaryReader.Read7BitEncodedInt32();
			EffectsType = binaryReader.ReadListInt();
			EffectsName = binaryReader.ReadListString();
			PreModel = binaryReader.ReadListString();
			Trailing = binaryReader.ReadString();
			Lighting = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
