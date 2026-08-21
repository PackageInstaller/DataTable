using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREquipmentPacks : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int Position { get; private set; }

	public int EquipmentsType { get; private set; }

	public List<int> Equipments { get; private set; }

	public int MainAttributeType { get; private set; }

	public List<int> DefenseAttribute { get; private set; }

	public int SecondaryAttributeType { get; private set; }

	public int AttributeStore { get; private set; }

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
		Position = int.Parse(array[num++]);
		EquipmentsType = int.Parse(array[num++]);
		Equipments = DataTableExtension.ParseListInt(array[num++]);
		MainAttributeType = int.Parse(array[num++]);
		DefenseAttribute = DataTableExtension.ParseListInt(array[num++]);
		SecondaryAttributeType = int.Parse(array[num++]);
		AttributeStore = int.Parse(array[num++]);
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
			Position = binaryReader.Read7BitEncodedInt32();
			EquipmentsType = binaryReader.Read7BitEncodedInt32();
			Equipments = binaryReader.ReadListInt();
			MainAttributeType = binaryReader.Read7BitEncodedInt32();
			DefenseAttribute = binaryReader.ReadListInt();
			SecondaryAttributeType = binaryReader.Read7BitEncodedInt32();
			AttributeStore = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
