using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRHomeComeReward : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, int>[] m_Item;

	private KeyValuePair<int, int>[] m_ItemRate;

	private KeyValuePair<int, int>[] m_ItemSup;

	public override int Id => m_Id;

	public int CurType { get; private set; }

	public int ItemType { get; private set; }

	public int Item1 { get; private set; }

	public int ItemRate1 { get; private set; }

	public int ItemSup1 { get; private set; }

	public int Item2 { get; private set; }

	public int ItemRate2 { get; private set; }

	public int ItemSup2 { get; private set; }

	public int ItemCount => m_Item.Length;

	public int ItemRateCount => m_ItemRate.Length;

	public int ItemSupCount => m_ItemSup.Length;

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
		CurType = int.Parse(array[num++]);
		ItemType = int.Parse(array[num++]);
		Item1 = int.Parse(array[num++]);
		ItemRate1 = int.Parse(array[num++]);
		ItemSup1 = int.Parse(array[num++]);
		Item2 = int.Parse(array[num++]);
		ItemRate2 = int.Parse(array[num++]);
		ItemSup2 = int.Parse(array[num++]);
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
			CurType = binaryReader.Read7BitEncodedInt32();
			ItemType = binaryReader.Read7BitEncodedInt32();
			Item1 = binaryReader.Read7BitEncodedInt32();
			ItemRate1 = binaryReader.Read7BitEncodedInt32();
			ItemSup1 = binaryReader.Read7BitEncodedInt32();
			Item2 = binaryReader.Read7BitEncodedInt32();
			ItemRate2 = binaryReader.Read7BitEncodedInt32();
			ItemSup2 = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	public int GetItem(int id)
	{
		KeyValuePair<int, int>[] item = m_Item;
		for (int i = 0; i < item.Length; i++)
		{
			KeyValuePair<int, int> keyValuePair = item[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetItem with invalid id '{0}'.", id));
	}

	public int GetItemAt(int index)
	{
		if (index < 0 || index >= m_Item.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetItemAt with invalid index '{0}'.", index));
		}
		return m_Item[index].Value;
	}

	public int GetItemRate(int id)
	{
		KeyValuePair<int, int>[] itemRate = m_ItemRate;
		for (int i = 0; i < itemRate.Length; i++)
		{
			KeyValuePair<int, int> keyValuePair = itemRate[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetItemRate with invalid id '{0}'.", id));
	}

	public int GetItemRateAt(int index)
	{
		if (index < 0 || index >= m_ItemRate.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetItemRateAt with invalid index '{0}'.", index));
		}
		return m_ItemRate[index].Value;
	}

	public int GetItemSup(int id)
	{
		KeyValuePair<int, int>[] itemSup = m_ItemSup;
		for (int i = 0; i < itemSup.Length; i++)
		{
			KeyValuePair<int, int> keyValuePair = itemSup[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetItemSup with invalid id '{0}'.", id));
	}

	public int GetItemSupAt(int index)
	{
		if (index < 0 || index >= m_ItemSup.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetItemSupAt with invalid index '{0}'.", index));
		}
		return m_ItemSup[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_Item = new KeyValuePair<int, int>[2]
		{
			new KeyValuePair<int, int>(1, Item1),
			new KeyValuePair<int, int>(2, Item2)
		};
		m_ItemRate = new KeyValuePair<int, int>[2]
		{
			new KeyValuePair<int, int>(1, ItemRate1),
			new KeyValuePair<int, int>(2, ItemRate2)
		};
		m_ItemSup = new KeyValuePair<int, int>[2]
		{
			new KeyValuePair<int, int>(1, ItemSup1),
			new KeyValuePair<int, int>(2, ItemSup2)
		};
	}
}
