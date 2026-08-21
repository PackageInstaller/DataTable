using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroSeat : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, List<int>>[] m_Prop;

	private KeyValuePair<int, List<float>>[] m_PropValue;

	private KeyValuePair<int, string>[] m_PropIcon;

	public override int Id => m_Id;

	public int TargetSeat { get; private set; }

	public int HeroId { get; private set; }

	public string SeatName { get; private set; }

	public string LayerName { get; private set; }

	public int NeedItem { get; private set; }

	public List<int> ItemNum { get; private set; }

	public int UpItemNum { get; private set; }

	public List<int> UpProp { get; private set; }

	public List<float> UpPropValue { get; private set; }

	public List<int> Prop1 { get; private set; }

	public List<float> PropValue1 { get; private set; }

	public List<int> Prop2 { get; private set; }

	public List<float> PropValue2 { get; private set; }

	public List<int> Prop3 { get; private set; }

	public List<float> PropValue3 { get; private set; }

	public List<int> Prop4 { get; private set; }

	public List<float> PropValue4 { get; private set; }

	public string EffectsDesc { get; private set; }

	public string Desc { get; private set; }

	public string PropIcon1 { get; private set; }

	public string PropIcon2 { get; private set; }

	public string PropIcon3 { get; private set; }

	public string PropIcon4 { get; private set; }

	public List<int> UpBattleValue { get; private set; }

	public int PropCount => m_Prop.Length;

	public int PropValueCount => m_PropValue.Length;

	public int PropIconCount => m_PropIcon.Length;

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
		TargetSeat = int.Parse(array[num++]);
		HeroId = int.Parse(array[num++]);
		SeatName = array[num++];
		LayerName = array[num++];
		NeedItem = int.Parse(array[num++]);
		ItemNum = DataTableExtension.ParseListInt(array[num++]);
		UpItemNum = int.Parse(array[num++]);
		UpProp = DataTableExtension.ParseListInt(array[num++]);
		UpPropValue = DataTableExtension.ParseListFloat(array[num++]);
		Prop1 = DataTableExtension.ParseListInt(array[num++]);
		PropValue1 = DataTableExtension.ParseListFloat(array[num++]);
		Prop2 = DataTableExtension.ParseListInt(array[num++]);
		PropValue2 = DataTableExtension.ParseListFloat(array[num++]);
		Prop3 = DataTableExtension.ParseListInt(array[num++]);
		PropValue3 = DataTableExtension.ParseListFloat(array[num++]);
		Prop4 = DataTableExtension.ParseListInt(array[num++]);
		PropValue4 = DataTableExtension.ParseListFloat(array[num++]);
		EffectsDesc = array[num++];
		Desc = array[num++];
		PropIcon1 = array[num++];
		PropIcon2 = array[num++];
		PropIcon3 = array[num++];
		PropIcon4 = array[num++];
		UpBattleValue = DataTableExtension.ParseListInt(array[num++]);
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
			TargetSeat = binaryReader.Read7BitEncodedInt32();
			HeroId = binaryReader.Read7BitEncodedInt32();
			SeatName = binaryReader.ReadString();
			LayerName = binaryReader.ReadString();
			NeedItem = binaryReader.Read7BitEncodedInt32();
			ItemNum = binaryReader.ReadListInt();
			UpItemNum = binaryReader.Read7BitEncodedInt32();
			UpProp = binaryReader.ReadListInt();
			UpPropValue = binaryReader.ReadListFloat();
			Prop1 = binaryReader.ReadListInt();
			PropValue1 = binaryReader.ReadListFloat();
			Prop2 = binaryReader.ReadListInt();
			PropValue2 = binaryReader.ReadListFloat();
			Prop3 = binaryReader.ReadListInt();
			PropValue3 = binaryReader.ReadListFloat();
			Prop4 = binaryReader.ReadListInt();
			PropValue4 = binaryReader.ReadListFloat();
			EffectsDesc = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
			PropIcon1 = binaryReader.ReadString();
			PropIcon2 = binaryReader.ReadString();
			PropIcon3 = binaryReader.ReadString();
			PropIcon4 = binaryReader.ReadString();
			UpBattleValue = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	public List<int> GetProp(int id)
	{
		KeyValuePair<int, List<int>>[] prop = m_Prop;
		for (int i = 0; i < prop.Length; i++)
		{
			KeyValuePair<int, List<int>> keyValuePair = prop[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetProp with invalid id '{0}'.", id));
	}

	public List<int> GetPropAt(int index)
	{
		if (index < 0 || index >= m_Prop.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetPropAt with invalid index '{0}'.", index));
		}
		return m_Prop[index].Value;
	}

	public List<float> GetPropValue(int id)
	{
		KeyValuePair<int, List<float>>[] propValue = m_PropValue;
		for (int i = 0; i < propValue.Length; i++)
		{
			KeyValuePair<int, List<float>> keyValuePair = propValue[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetPropValue with invalid id '{0}'.", id));
	}

	public List<float> GetPropValueAt(int index)
	{
		if (index < 0 || index >= m_PropValue.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetPropValueAt with invalid index '{0}'.", index));
		}
		return m_PropValue[index].Value;
	}

	public string GetPropIcon(int id)
	{
		KeyValuePair<int, string>[] propIcon = m_PropIcon;
		for (int i = 0; i < propIcon.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = propIcon[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetPropIcon with invalid id '{0}'.", id));
	}

	public string GetPropIconAt(int index)
	{
		if (index < 0 || index >= m_PropIcon.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetPropIconAt with invalid index '{0}'.", index));
		}
		return m_PropIcon[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_Prop = new KeyValuePair<int, List<int>>[4]
		{
			new KeyValuePair<int, List<int>>(1, Prop1),
			new KeyValuePair<int, List<int>>(2, Prop2),
			new KeyValuePair<int, List<int>>(3, Prop3),
			new KeyValuePair<int, List<int>>(4, Prop4)
		};
		m_PropValue = new KeyValuePair<int, List<float>>[4]
		{
			new KeyValuePair<int, List<float>>(1, PropValue1),
			new KeyValuePair<int, List<float>>(2, PropValue2),
			new KeyValuePair<int, List<float>>(3, PropValue3),
			new KeyValuePair<int, List<float>>(4, PropValue4)
		};
		m_PropIcon = new KeyValuePair<int, string>[4]
		{
			new KeyValuePair<int, string>(1, PropIcon1),
			new KeyValuePair<int, string>(2, PropIcon2),
			new KeyValuePair<int, string>(3, PropIcon3),
			new KeyValuePair<int, string>(4, PropIcon4)
		};
	}
}
