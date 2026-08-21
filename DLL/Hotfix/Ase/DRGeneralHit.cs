using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRGeneralHit : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, List<List<int>>>[] m_HitEffect;

	private KeyValuePair<int, List<List<int>>>[] m_HitEffectAfter;

	public override int Id => m_Id;

	public float EffectScale { get; private set; }

	public List<float> PositionOffset { get; private set; }

	public List<List<int>> HitEffect0 { get; private set; }

	public List<List<int>> HitEffect1111 { get; private set; }

	public List<List<int>> HitEffectAfter1111 { get; private set; }

	public List<List<int>> HitEffect1112 { get; private set; }

	public List<List<int>> HitEffectAfter1112 { get; private set; }

	public List<List<int>> HitEffect1118 { get; private set; }

	public List<List<int>> HitEffectAfter1118 { get; private set; }

	public List<List<int>> HitEffect2001 { get; private set; }

	public List<List<int>> HitEffectAfter2001 { get; private set; }

	public List<List<int>> HitEffect2000 { get; private set; }

	public List<List<int>> HitEffectAfter2000 { get; private set; }

	public List<List<int>> HitEffect3001 { get; private set; }

	public List<List<int>> HitEffectAfter3001 { get; private set; }

	public int HitEffectCount => m_HitEffect.Length;

	public int HitEffectAfterCount => m_HitEffectAfter.Length;

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
		EffectScale = float.Parse(array[num++]);
		PositionOffset = DataTableExtension.ParseListFloat(array[num++]);
		HitEffect0 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffect1111 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffectAfter1111 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffect1112 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffectAfter1112 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffect1118 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffectAfter1118 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffect2001 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffectAfter2001 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffect2000 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffectAfter2000 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffect3001 = DataTableExtension.ParseListIntList(array[num++]);
		HitEffectAfter3001 = DataTableExtension.ParseListIntList(array[num++]);
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
			EffectScale = binaryReader.ReadSingle();
			PositionOffset = binaryReader.ReadListFloat();
			HitEffect0 = binaryReader.ReadListIntList();
			HitEffect1111 = binaryReader.ReadListIntList();
			HitEffectAfter1111 = binaryReader.ReadListIntList();
			HitEffect1112 = binaryReader.ReadListIntList();
			HitEffectAfter1112 = binaryReader.ReadListIntList();
			HitEffect1118 = binaryReader.ReadListIntList();
			HitEffectAfter1118 = binaryReader.ReadListIntList();
			HitEffect2001 = binaryReader.ReadListIntList();
			HitEffectAfter2001 = binaryReader.ReadListIntList();
			HitEffect2000 = binaryReader.ReadListIntList();
			HitEffectAfter2000 = binaryReader.ReadListIntList();
			HitEffect3001 = binaryReader.ReadListIntList();
			HitEffectAfter3001 = binaryReader.ReadListIntList();
		}
		GeneratePropertyArray();
		return true;
	}

	public List<List<int>> GetHitEffect(int id)
	{
		KeyValuePair<int, List<List<int>>>[] hitEffect = m_HitEffect;
		for (int i = 0; i < hitEffect.Length; i++)
		{
			KeyValuePair<int, List<List<int>>> keyValuePair = hitEffect[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetHitEffect with invalid id '{0}'.", id));
	}

	public List<List<int>> GetHitEffectAt(int index)
	{
		if (index < 0 || index >= m_HitEffect.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetHitEffectAt with invalid index '{0}'.", index));
		}
		return m_HitEffect[index].Value;
	}

	public List<List<int>> GetHitEffectAfter(int id)
	{
		KeyValuePair<int, List<List<int>>>[] hitEffectAfter = m_HitEffectAfter;
		for (int i = 0; i < hitEffectAfter.Length; i++)
		{
			KeyValuePair<int, List<List<int>>> keyValuePair = hitEffectAfter[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetHitEffectAfter with invalid id '{0}'.", id));
	}

	public List<List<int>> GetHitEffectAfterAt(int index)
	{
		if (index < 0 || index >= m_HitEffectAfter.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetHitEffectAfterAt with invalid index '{0}'.", index));
		}
		return m_HitEffectAfter[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_HitEffect = new KeyValuePair<int, List<List<int>>>[7]
		{
			new KeyValuePair<int, List<List<int>>>(0, HitEffect0),
			new KeyValuePair<int, List<List<int>>>(1111, HitEffect1111),
			new KeyValuePair<int, List<List<int>>>(1112, HitEffect1112),
			new KeyValuePair<int, List<List<int>>>(1118, HitEffect1118),
			new KeyValuePair<int, List<List<int>>>(2001, HitEffect2001),
			new KeyValuePair<int, List<List<int>>>(2000, HitEffect2000),
			new KeyValuePair<int, List<List<int>>>(3001, HitEffect3001)
		};
		m_HitEffectAfter = new KeyValuePair<int, List<List<int>>>[6]
		{
			new KeyValuePair<int, List<List<int>>>(1111, HitEffectAfter1111),
			new KeyValuePair<int, List<List<int>>>(1112, HitEffectAfter1112),
			new KeyValuePair<int, List<List<int>>>(1118, HitEffectAfter1118),
			new KeyValuePair<int, List<List<int>>>(2001, HitEffectAfter2001),
			new KeyValuePair<int, List<List<int>>>(2000, HitEffectAfter2000),
			new KeyValuePair<int, List<List<int>>>(3001, HitEffectAfter3001)
		};
	}
}
