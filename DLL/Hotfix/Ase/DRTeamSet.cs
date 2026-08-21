using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRTeamSet : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<int> Lock { get; private set; }

	public List<int> TryHero { get; private set; }

	public List<int> Pos { get; private set; }

	public List<int> AvailableHero { get; private set; }

	public bool IsBattleProp { get; private set; }

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
		Lock = DataTableExtension.ParseListInt(array[num++]);
		TryHero = DataTableExtension.ParseListInt(array[num++]);
		Pos = DataTableExtension.ParseListInt(array[num++]);
		AvailableHero = DataTableExtension.ParseListInt(array[num++]);
		IsBattleProp = bool.Parse(array[num++]);
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
			Lock = binaryReader.ReadListInt();
			TryHero = binaryReader.ReadListInt();
			Pos = binaryReader.ReadListInt();
			AvailableHero = binaryReader.ReadListInt();
			IsBattleProp = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
