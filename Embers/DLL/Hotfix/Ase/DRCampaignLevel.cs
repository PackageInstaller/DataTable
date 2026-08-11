using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCampaignLevel : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Type { get; private set; }

	public string Name { get; private set; }

	public List<string> Label { get; private set; }

	public string Icon { get; private set; }

	public int IconSize { get; private set; }

	public string BossIcon { get; private set; }

	public string InfoText { get; private set; }

	public int CopyId { get; private set; }

	public List<int> EnviBuff { get; private set; }

	public List<int> DropDescType { get; private set; }

	public List<int> DropDescId { get; private set; }

	public List<int> DropDescNum { get; private set; }

	public List<int> TicketId { get; private set; }

	public List<int> TicketNum { get; private set; }

	public int GeneTimelimit { get; private set; }

	public string ClearTips { get; private set; }

	public int ShareType { get; private set; }

	public int CopyCount { get; private set; }

	public int HpCount { get; private set; }

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
		Type = int.Parse(array[num++]);
		Name = array[num++];
		Label = DataTableExtension.ParseListString(array[num++]);
		Icon = array[num++];
		IconSize = int.Parse(array[num++]);
		BossIcon = array[num++];
		InfoText = array[num++];
		CopyId = int.Parse(array[num++]);
		EnviBuff = DataTableExtension.ParseListInt(array[num++]);
		DropDescType = DataTableExtension.ParseListInt(array[num++]);
		DropDescId = DataTableExtension.ParseListInt(array[num++]);
		DropDescNum = DataTableExtension.ParseListInt(array[num++]);
		TicketId = DataTableExtension.ParseListInt(array[num++]);
		TicketNum = DataTableExtension.ParseListInt(array[num++]);
		GeneTimelimit = int.Parse(array[num++]);
		ClearTips = array[num++];
		ShareType = int.Parse(array[num++]);
		CopyCount = int.Parse(array[num++]);
		HpCount = int.Parse(array[num++]);
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
			Type = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Label = binaryReader.ReadListString();
			Icon = binaryReader.ReadString();
			IconSize = binaryReader.Read7BitEncodedInt32();
			BossIcon = binaryReader.ReadString();
			InfoText = binaryReader.ReadString();
			CopyId = binaryReader.Read7BitEncodedInt32();
			EnviBuff = binaryReader.ReadListInt();
			DropDescType = binaryReader.ReadListInt();
			DropDescId = binaryReader.ReadListInt();
			DropDescNum = binaryReader.ReadListInt();
			TicketId = binaryReader.ReadListInt();
			TicketNum = binaryReader.ReadListInt();
			GeneTimelimit = binaryReader.Read7BitEncodedInt32();
			ClearTips = binaryReader.ReadString();
			ShareType = binaryReader.Read7BitEncodedInt32();
			CopyCount = binaryReader.Read7BitEncodedInt32();
			HpCount = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
