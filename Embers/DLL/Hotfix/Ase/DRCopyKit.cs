using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCopyKit : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TaskId { get; private set; }

	public int TimeLimit { get; private set; }

	public int LvSort { get; private set; }

	public bool IsCharLvBal { get; private set; }

	public bool IsWeapLvBal { get; private set; }

	public bool IsTalentBal { get; private set; }

	public bool IsKitBal { get; private set; }

	public List<int> DropUp { get; private set; }

	public List<int> LvBuff { get; private set; }

	public List<int> LvEFF { get; private set; }

	public List<int> BuffType { get; private set; }

	public List<int> AdvCharID { get; private set; }

	public List<int> DropUpCond { get; private set; }

	public List<int> DropUpAtt { get; private set; }

	public List<float> DropUpRate { get; private set; }

	public List<int> TeamUp { get; private set; }

	public int ActTypeId { get; private set; }

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
		TaskId = int.Parse(array[num++]);
		TimeLimit = int.Parse(array[num++]);
		LvSort = int.Parse(array[num++]);
		IsCharLvBal = bool.Parse(array[num++]);
		IsWeapLvBal = bool.Parse(array[num++]);
		IsTalentBal = bool.Parse(array[num++]);
		IsKitBal = bool.Parse(array[num++]);
		DropUp = DataTableExtension.ParseListInt(array[num++]);
		LvBuff = DataTableExtension.ParseListInt(array[num++]);
		LvEFF = DataTableExtension.ParseListInt(array[num++]);
		BuffType = DataTableExtension.ParseListInt(array[num++]);
		AdvCharID = DataTableExtension.ParseListInt(array[num++]);
		DropUpCond = DataTableExtension.ParseListInt(array[num++]);
		DropUpAtt = DataTableExtension.ParseListInt(array[num++]);
		DropUpRate = DataTableExtension.ParseListFloat(array[num++]);
		TeamUp = DataTableExtension.ParseListInt(array[num++]);
		ActTypeId = int.Parse(array[num++]);
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
			TaskId = binaryReader.Read7BitEncodedInt32();
			TimeLimit = binaryReader.Read7BitEncodedInt32();
			LvSort = binaryReader.Read7BitEncodedInt32();
			IsCharLvBal = binaryReader.ReadBoolean();
			IsWeapLvBal = binaryReader.ReadBoolean();
			IsTalentBal = binaryReader.ReadBoolean();
			IsKitBal = binaryReader.ReadBoolean();
			DropUp = binaryReader.ReadListInt();
			LvBuff = binaryReader.ReadListInt();
			LvEFF = binaryReader.ReadListInt();
			BuffType = binaryReader.ReadListInt();
			AdvCharID = binaryReader.ReadListInt();
			DropUpCond = binaryReader.ReadListInt();
			DropUpAtt = binaryReader.ReadListInt();
			DropUpRate = binaryReader.ReadListFloat();
			TeamUp = binaryReader.ReadListInt();
			ActTypeId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
