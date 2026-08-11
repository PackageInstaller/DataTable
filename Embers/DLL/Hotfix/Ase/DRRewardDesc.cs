using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRRewardDesc : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, int>[] m_Cur;

	private KeyValuePair<int, int>[] m_CurSup;

	private KeyValuePair<int, int>[] m_Item;

	private KeyValuePair<int, int>[] m_ItemSup;

	public override int Id => m_Id;

	public int Cur1 { get; private set; }

	public int CurSup1 { get; private set; }

	public int Cur2 { get; private set; }

	public int CurSup2 { get; private set; }

	public int Cur3 { get; private set; }

	public int CurSup3 { get; private set; }

	public int Item1 { get; private set; }

	public int ItemSup1 { get; private set; }

	public int Item2 { get; private set; }

	public int ItemSup2 { get; private set; }

	public int Item3 { get; private set; }

	public int ItemSup3 { get; private set; }

	public int Item4 { get; private set; }

	public int ItemSup4 { get; private set; }

	public int Item5 { get; private set; }

	public int ItemSup5 { get; private set; }

	public int Item6 { get; private set; }

	public int ItemSup6 { get; private set; }

	public int Item7 { get; private set; }

	public int ItemSup7 { get; private set; }

	public int Item8 { get; private set; }

	public int ItemSup8 { get; private set; }

	public int Item9 { get; private set; }

	public int ItemSup9 { get; private set; }

	public int Item10 { get; private set; }

	public int ItemSup10 { get; private set; }

	public int CurCount => m_Cur.Length;

	public int CurSupCount => m_CurSup.Length;

	public int ItemCount => m_Item.Length;

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
		Cur1 = int.Parse(array[num++]);
		CurSup1 = int.Parse(array[num++]);
		Cur2 = int.Parse(array[num++]);
		CurSup2 = int.Parse(array[num++]);
		Cur3 = int.Parse(array[num++]);
		CurSup3 = int.Parse(array[num++]);
		Item1 = int.Parse(array[num++]);
		ItemSup1 = int.Parse(array[num++]);
		Item2 = int.Parse(array[num++]);
		ItemSup2 = int.Parse(array[num++]);
		Item3 = int.Parse(array[num++]);
		ItemSup3 = int.Parse(array[num++]);
		Item4 = int.Parse(array[num++]);
		ItemSup4 = int.Parse(array[num++]);
		Item5 = int.Parse(array[num++]);
		ItemSup5 = int.Parse(array[num++]);
		Item6 = int.Parse(array[num++]);
		ItemSup6 = int.Parse(array[num++]);
		Item7 = int.Parse(array[num++]);
		ItemSup7 = int.Parse(array[num++]);
		Item8 = int.Parse(array[num++]);
		ItemSup8 = int.Parse(array[num++]);
		Item9 = int.Parse(array[num++]);
		ItemSup9 = int.Parse(array[num++]);
		Item10 = int.Parse(array[num++]);
		ItemSup10 = int.Parse(array[num++]);
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
			Cur1 = binaryReader.Read7BitEncodedInt32();
			CurSup1 = binaryReader.Read7BitEncodedInt32();
			Cur2 = binaryReader.Read7BitEncodedInt32();
			CurSup2 = binaryReader.Read7BitEncodedInt32();
			Cur3 = binaryReader.Read7BitEncodedInt32();
			CurSup3 = binaryReader.Read7BitEncodedInt32();
			Item1 = binaryReader.Read7BitEncodedInt32();
			ItemSup1 = binaryReader.Read7BitEncodedInt32();
			Item2 = binaryReader.Read7BitEncodedInt32();
			ItemSup2 = binaryReader.Read7BitEncodedInt32();
			Item3 = binaryReader.Read7BitEncodedInt32();
			ItemSup3 = binaryReader.Read7BitEncodedInt32();
			Item4 = binaryReader.Read7BitEncodedInt32();
			ItemSup4 = binaryReader.Read7BitEncodedInt32();
			Item5 = binaryReader.Read7BitEncodedInt32();
			ItemSup5 = binaryReader.Read7BitEncodedInt32();
			Item6 = binaryReader.Read7BitEncodedInt32();
			ItemSup6 = binaryReader.Read7BitEncodedInt32();
			Item7 = binaryReader.Read7BitEncodedInt32();
			ItemSup7 = binaryReader.Read7BitEncodedInt32();
			Item8 = binaryReader.Read7BitEncodedInt32();
			ItemSup8 = binaryReader.Read7BitEncodedInt32();
			Item9 = binaryReader.Read7BitEncodedInt32();
			ItemSup9 = binaryReader.Read7BitEncodedInt32();
			Item10 = binaryReader.Read7BitEncodedInt32();
			ItemSup10 = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	public int GetCur(int id)
	{
		KeyValuePair<int, int>[] cur = m_Cur;
		for (int i = 0; i < cur.Length; i++)
		{
			KeyValuePair<int, int> keyValuePair = cur[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetCur with invalid id '{0}'.", id));
	}

	public int GetCurAt(int index)
	{
		if (index < 0 || index >= m_Cur.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetCurAt with invalid index '{0}'.", index));
		}
		return m_Cur[index].Value;
	}

	public int GetCurSup(int id)
	{
		KeyValuePair<int, int>[] curSup = m_CurSup;
		for (int i = 0; i < curSup.Length; i++)
		{
			KeyValuePair<int, int> keyValuePair = curSup[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetCurSup with invalid id '{0}'.", id));
	}

	public int GetCurSupAt(int index)
	{
		if (index < 0 || index >= m_CurSup.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetCurSupAt with invalid index '{0}'.", index));
		}
		return m_CurSup[index].Value;
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
		m_Cur = new KeyValuePair<int, int>[3]
		{
			new KeyValuePair<int, int>(1, Cur1),
			new KeyValuePair<int, int>(2, Cur2),
			new KeyValuePair<int, int>(3, Cur3)
		};
		m_CurSup = new KeyValuePair<int, int>[3]
		{
			new KeyValuePair<int, int>(1, CurSup1),
			new KeyValuePair<int, int>(2, CurSup2),
			new KeyValuePair<int, int>(3, CurSup3)
		};
		m_Item = new KeyValuePair<int, int>[10]
		{
			new KeyValuePair<int, int>(1, Item1),
			new KeyValuePair<int, int>(2, Item2),
			new KeyValuePair<int, int>(3, Item3),
			new KeyValuePair<int, int>(4, Item4),
			new KeyValuePair<int, int>(5, Item5),
			new KeyValuePair<int, int>(6, Item6),
			new KeyValuePair<int, int>(7, Item7),
			new KeyValuePair<int, int>(8, Item8),
			new KeyValuePair<int, int>(9, Item9),
			new KeyValuePair<int, int>(10, Item10)
		};
		m_ItemSup = new KeyValuePair<int, int>[10]
		{
			new KeyValuePair<int, int>(1, ItemSup1),
			new KeyValuePair<int, int>(2, ItemSup2),
			new KeyValuePair<int, int>(3, ItemSup3),
			new KeyValuePair<int, int>(4, ItemSup4),
			new KeyValuePair<int, int>(5, ItemSup5),
			new KeyValuePair<int, int>(6, ItemSup6),
			new KeyValuePair<int, int>(7, ItemSup7),
			new KeyValuePair<int, int>(8, ItemSup8),
			new KeyValuePair<int, int>(9, ItemSup9),
			new KeyValuePair<int, int>(10, ItemSup10)
		};
	}
}
