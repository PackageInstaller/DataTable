using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DREntityHitConfig : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, List<int>>[] m_TreeId;

	public override int Id => m_Id;

	public int MonsterId { get; private set; }

	public int AttackPower { get; private set; }

	public List<int> TreeId1 { get; private set; }

	public int TreeIdCount => m_TreeId.Length;

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
		MonsterId = int.Parse(array[num++]);
		AttackPower = int.Parse(array[num++]);
		TreeId1 = DataTableExtension.ParseListInt(array[num++]);
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
			MonsterId = binaryReader.Read7BitEncodedInt32();
			AttackPower = binaryReader.Read7BitEncodedInt32();
			TreeId1 = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	public List<int> GetTreeId(int id)
	{
		KeyValuePair<int, List<int>>[] treeId = m_TreeId;
		for (int i = 0; i < treeId.Length; i++)
		{
			KeyValuePair<int, List<int>> keyValuePair = treeId[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetTreeId with invalid id '{0}'.", id));
	}

	public List<int> GetTreeIdAt(int index)
	{
		if (index < 0 || index >= m_TreeId.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetTreeIdAt with invalid index '{0}'.", index));
		}
		return m_TreeId[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_TreeId = new KeyValuePair<int, List<int>>[1]
		{
			new KeyValuePair<int, List<int>>(1, TreeId1)
		};
	}
}
