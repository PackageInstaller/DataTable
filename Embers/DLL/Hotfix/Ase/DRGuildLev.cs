using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGuildLev : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int GuildLv { get; private set; }

	public int GuildFund { get; private set; }

	public int FundLimit { get; private set; }

	public int MemberLimit { get; private set; }

	public int ViceLimit { get; private set; }

	public int ExcellentMemberLimit { get; private set; }

	public int ActiveCost { get; private set; }

	public int BuffId { get; private set; }

	public List<string> ExtraEffect { get; private set; }

	public List<int> TaskQuality { get; private set; }

	public List<int> TaskNum { get; private set; }

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
		GuildLv = int.Parse(array[num++]);
		GuildFund = int.Parse(array[num++]);
		FundLimit = int.Parse(array[num++]);
		MemberLimit = int.Parse(array[num++]);
		ViceLimit = int.Parse(array[num++]);
		ExcellentMemberLimit = int.Parse(array[num++]);
		ActiveCost = int.Parse(array[num++]);
		BuffId = int.Parse(array[num++]);
		ExtraEffect = DataTableExtension.ParseListString(array[num++]);
		TaskQuality = DataTableExtension.ParseListInt(array[num++]);
		TaskNum = DataTableExtension.ParseListInt(array[num++]);
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
			GuildLv = binaryReader.Read7BitEncodedInt32();
			GuildFund = binaryReader.Read7BitEncodedInt32();
			FundLimit = binaryReader.Read7BitEncodedInt32();
			MemberLimit = binaryReader.Read7BitEncodedInt32();
			ViceLimit = binaryReader.Read7BitEncodedInt32();
			ExcellentMemberLimit = binaryReader.Read7BitEncodedInt32();
			ActiveCost = binaryReader.Read7BitEncodedInt32();
			BuffId = binaryReader.Read7BitEncodedInt32();
			ExtraEffect = binaryReader.ReadListString();
			TaskQuality = binaryReader.ReadListInt();
			TaskNum = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
