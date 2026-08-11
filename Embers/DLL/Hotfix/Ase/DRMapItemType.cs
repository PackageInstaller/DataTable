using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRMapItemType : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, string>[] m_IconType;

	public override int Id => m_Id;

	public string IconType1 { get; private set; }

	public string IconType2 { get; private set; }

	public int IconTypeCount => m_IconType.Length;

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
		IconType1 = array[num++];
		IconType2 = array[num++];
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
			IconType1 = binaryReader.ReadString();
			IconType2 = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	public string GetIconType(int id)
	{
		KeyValuePair<int, string>[] iconType = m_IconType;
		for (int i = 0; i < iconType.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = iconType[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetIconType with invalid id '{0}'.", id));
	}

	public string GetIconTypeAt(int index)
	{
		if (index < 0 || index >= m_IconType.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetIconTypeAt with invalid index '{0}'.", index));
		}
		return m_IconType[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_IconType = new KeyValuePair<int, string>[2]
		{
			new KeyValuePair<int, string>(1, IconType1),
			new KeyValuePair<int, string>(2, IconType2)
		};
	}
}
