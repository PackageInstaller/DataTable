using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCampaignBuilding : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int Group { get; private set; }

	public string Icon { get; private set; }

	public int Level { get; private set; }

	public string Builddesc { get; private set; }

	public List<int> UpgradeMatType { get; private set; }

	public List<int> UpgradeMatId { get; private set; }

	public List<int> UpgradeMatNum { get; private set; }

	public List<int> UpgradRewardDescType { get; private set; }

	public List<int> UpgradRewardDescId { get; private set; }

	public List<int> UpgradRewardDescNum { get; private set; }

	public List<int> ActNode { get; private set; }

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
		Group = int.Parse(array[num++]);
		Icon = array[num++];
		Level = int.Parse(array[num++]);
		Builddesc = array[num++];
		UpgradeMatType = DataTableExtension.ParseListInt(array[num++]);
		UpgradeMatId = DataTableExtension.ParseListInt(array[num++]);
		UpgradeMatNum = DataTableExtension.ParseListInt(array[num++]);
		UpgradRewardDescType = DataTableExtension.ParseListInt(array[num++]);
		UpgradRewardDescId = DataTableExtension.ParseListInt(array[num++]);
		UpgradRewardDescNum = DataTableExtension.ParseListInt(array[num++]);
		ActNode = DataTableExtension.ParseListInt(array[num++]);
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
			Group = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			Level = binaryReader.Read7BitEncodedInt32();
			Builddesc = binaryReader.ReadString();
			UpgradeMatType = binaryReader.ReadListInt();
			UpgradeMatId = binaryReader.ReadListInt();
			UpgradeMatNum = binaryReader.ReadListInt();
			UpgradRewardDescType = binaryReader.ReadListInt();
			UpgradRewardDescId = binaryReader.ReadListInt();
			UpgradRewardDescNum = binaryReader.ReadListInt();
			ActNode = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
