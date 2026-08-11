using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRAccountInitial : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<int> Hero { get; private set; }

	public List<int> HeroLv { get; private set; }

	public List<int> HerosoulLv { get; private set; }

	public List<int> HeroskillLv { get; private set; }

	public List<int> Team { get; private set; }

	public int Energy { get; private set; }

	public int Golds { get; private set; }

	public int Diamonds { get; private set; }

	public List<int> Prop { get; private set; }

	public List<int> PropNum { get; private set; }

	public List<int> Weapon { get; private set; }

	public List<int> WeaponNum { get; private set; }

	public List<int> WeaponLv { get; private set; }

	public List<int> Equipment { get; private set; }

	public List<int> EquipmentNum { get; private set; }

	public List<int> Suitbox { get; private set; }

	public List<int> SuitboxNum { get; private set; }

	public List<int> Drawing { get; private set; }

	public List<int> Task { get; private set; }

	public int Level { get; private set; }

	public int HeadDecorate { get; private set; }

	public List<int> MainBg { get; private set; }

	public int BoardHero { get; private set; }

	public List<int> Guidance { get; private set; }

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
		Hero = DataTableExtension.ParseListInt(array[num++]);
		HeroLv = DataTableExtension.ParseListInt(array[num++]);
		HerosoulLv = DataTableExtension.ParseListInt(array[num++]);
		HeroskillLv = DataTableExtension.ParseListInt(array[num++]);
		Team = DataTableExtension.ParseListInt(array[num++]);
		Energy = int.Parse(array[num++]);
		Golds = int.Parse(array[num++]);
		Diamonds = int.Parse(array[num++]);
		Prop = DataTableExtension.ParseListInt(array[num++]);
		PropNum = DataTableExtension.ParseListInt(array[num++]);
		Weapon = DataTableExtension.ParseListInt(array[num++]);
		WeaponNum = DataTableExtension.ParseListInt(array[num++]);
		WeaponLv = DataTableExtension.ParseListInt(array[num++]);
		Equipment = DataTableExtension.ParseListInt(array[num++]);
		EquipmentNum = DataTableExtension.ParseListInt(array[num++]);
		Suitbox = DataTableExtension.ParseListInt(array[num++]);
		SuitboxNum = DataTableExtension.ParseListInt(array[num++]);
		Drawing = DataTableExtension.ParseListInt(array[num++]);
		Task = DataTableExtension.ParseListInt(array[num++]);
		Level = int.Parse(array[num++]);
		HeadDecorate = int.Parse(array[num++]);
		MainBg = DataTableExtension.ParseListInt(array[num++]);
		BoardHero = int.Parse(array[num++]);
		Guidance = DataTableExtension.ParseListInt(array[num++]);
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
			Hero = binaryReader.ReadListInt();
			HeroLv = binaryReader.ReadListInt();
			HerosoulLv = binaryReader.ReadListInt();
			HeroskillLv = binaryReader.ReadListInt();
			Team = binaryReader.ReadListInt();
			Energy = binaryReader.Read7BitEncodedInt32();
			Golds = binaryReader.Read7BitEncodedInt32();
			Diamonds = binaryReader.Read7BitEncodedInt32();
			Prop = binaryReader.ReadListInt();
			PropNum = binaryReader.ReadListInt();
			Weapon = binaryReader.ReadListInt();
			WeaponNum = binaryReader.ReadListInt();
			WeaponLv = binaryReader.ReadListInt();
			Equipment = binaryReader.ReadListInt();
			EquipmentNum = binaryReader.ReadListInt();
			Suitbox = binaryReader.ReadListInt();
			SuitboxNum = binaryReader.ReadListInt();
			Drawing = binaryReader.ReadListInt();
			Task = binaryReader.ReadListInt();
			Level = binaryReader.Read7BitEncodedInt32();
			HeadDecorate = binaryReader.Read7BitEncodedInt32();
			MainBg = binaryReader.ReadListInt();
			BoardHero = binaryReader.Read7BitEncodedInt32();
			Guidance = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
