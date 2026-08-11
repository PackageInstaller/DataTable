using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRPassportShow : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string PassportName { get; private set; }

	public List<int> BuyRewardType { get; private set; }

	public List<int> BuyRewardID { get; private set; }

	public List<int> BuyRewardNum { get; private set; }

	public List<int> UpgradeBuyRewardType { get; private set; }

	public List<int> UpgradeBuyRewardID { get; private set; }

	public List<int> UpgradeBuyRewardNum { get; private set; }

	public List<int> UpgradeRewardType { get; private set; }

	public List<int> UpgradeRewardID { get; private set; }

	public List<int> UpgradeRewardNum { get; private set; }

	public int Price { get; private set; }

	public string PriceUI { get; private set; }

	public int UpgradePrice { get; private set; }

	public string UpgradePriceUI { get; private set; }

	public int ExpLimit { get; private set; }

	public string Icon { get; private set; }

	public string Bg { get; private set; }

	public string Tip { get; private set; }

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
		PassportName = array[num++];
		BuyRewardType = DataTableExtension.ParseListInt(array[num++]);
		BuyRewardID = DataTableExtension.ParseListInt(array[num++]);
		BuyRewardNum = DataTableExtension.ParseListInt(array[num++]);
		UpgradeBuyRewardType = DataTableExtension.ParseListInt(array[num++]);
		UpgradeBuyRewardID = DataTableExtension.ParseListInt(array[num++]);
		UpgradeBuyRewardNum = DataTableExtension.ParseListInt(array[num++]);
		UpgradeRewardType = DataTableExtension.ParseListInt(array[num++]);
		UpgradeRewardID = DataTableExtension.ParseListInt(array[num++]);
		UpgradeRewardNum = DataTableExtension.ParseListInt(array[num++]);
		Price = int.Parse(array[num++]);
		PriceUI = array[num++];
		UpgradePrice = int.Parse(array[num++]);
		UpgradePriceUI = array[num++];
		ExpLimit = int.Parse(array[num++]);
		Icon = array[num++];
		Bg = array[num++];
		Tip = array[num++];
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
			PassportName = binaryReader.ReadString();
			BuyRewardType = binaryReader.ReadListInt();
			BuyRewardID = binaryReader.ReadListInt();
			BuyRewardNum = binaryReader.ReadListInt();
			UpgradeBuyRewardType = binaryReader.ReadListInt();
			UpgradeBuyRewardID = binaryReader.ReadListInt();
			UpgradeBuyRewardNum = binaryReader.ReadListInt();
			UpgradeRewardType = binaryReader.ReadListInt();
			UpgradeRewardID = binaryReader.ReadListInt();
			UpgradeRewardNum = binaryReader.ReadListInt();
			Price = binaryReader.Read7BitEncodedInt32();
			PriceUI = binaryReader.ReadString();
			UpgradePrice = binaryReader.Read7BitEncodedInt32();
			UpgradePriceUI = binaryReader.ReadString();
			ExpLimit = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			Bg = binaryReader.ReadString();
			Tip = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}
