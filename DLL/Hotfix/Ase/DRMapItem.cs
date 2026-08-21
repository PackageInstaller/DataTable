using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRMapItem : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, float>[] m_Parameter;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int AIParadoxId { get; private set; }

	public string AssetPath { get; private set; }

	public int DropId { get; private set; }

	public int CampType { get; private set; }

	public int HP { get; private set; }

	public int Attack { get; private set; }

	public int HitBoxId { get; private set; }

	public string Shape { get; private set; }

	public float Parameter1 { get; private set; }

	public float Parameter2 { get; private set; }

	public float Parameter3 { get; private set; }

	public List<float> CenterOffset { get; private set; }

	public float Time { get; private set; }

	public string InteractiveBtnAssetPath { get; private set; }

	public bool DailyRefresh { get; private set; }

	public int MapItemType { get; private set; }

	public int MarkType { get; private set; }

	public bool CanMove { get; private set; }

	public int BreakType { get; private set; }

	public int ParameterCount => m_Parameter.Length;

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
		AIParadoxId = int.Parse(array[num++]);
		AssetPath = array[num++];
		DropId = int.Parse(array[num++]);
		CampType = int.Parse(array[num++]);
		HP = int.Parse(array[num++]);
		Attack = int.Parse(array[num++]);
		HitBoxId = int.Parse(array[num++]);
		Shape = array[num++];
		Parameter1 = float.Parse(array[num++]);
		Parameter2 = float.Parse(array[num++]);
		Parameter3 = float.Parse(array[num++]);
		CenterOffset = DataTableExtension.ParseListFloat(array[num++]);
		Time = float.Parse(array[num++]);
		InteractiveBtnAssetPath = array[num++];
		DailyRefresh = bool.Parse(array[num++]);
		MapItemType = int.Parse(array[num++]);
		MarkType = int.Parse(array[num++]);
		CanMove = bool.Parse(array[num++]);
		BreakType = int.Parse(array[num++]);
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
			AIParadoxId = binaryReader.Read7BitEncodedInt32();
			AssetPath = binaryReader.ReadString();
			DropId = binaryReader.Read7BitEncodedInt32();
			CampType = binaryReader.Read7BitEncodedInt32();
			HP = binaryReader.Read7BitEncodedInt32();
			Attack = binaryReader.Read7BitEncodedInt32();
			HitBoxId = binaryReader.Read7BitEncodedInt32();
			Shape = binaryReader.ReadString();
			Parameter1 = binaryReader.ReadSingle();
			Parameter2 = binaryReader.ReadSingle();
			Parameter3 = binaryReader.ReadSingle();
			CenterOffset = binaryReader.ReadListFloat();
			Time = binaryReader.ReadSingle();
			InteractiveBtnAssetPath = binaryReader.ReadString();
			DailyRefresh = binaryReader.ReadBoolean();
			MapItemType = binaryReader.Read7BitEncodedInt32();
			MarkType = binaryReader.Read7BitEncodedInt32();
			CanMove = binaryReader.ReadBoolean();
			BreakType = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	public float GetParameter(int id)
	{
		KeyValuePair<int, float>[] parameter = m_Parameter;
		for (int i = 0; i < parameter.Length; i++)
		{
			KeyValuePair<int, float> keyValuePair = parameter[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetParameter with invalid id '{0}'.", id));
	}

	public float GetParameterAt(int index)
	{
		if (index < 0 || index >= m_Parameter.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetParameterAt with invalid index '{0}'.", index));
		}
		return m_Parameter[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_Parameter = new KeyValuePair<int, float>[3]
		{
			new KeyValuePair<int, float>(1, Parameter1),
			new KeyValuePair<int, float>(2, Parameter2),
			new KeyValuePair<int, float>(3, Parameter3)
		};
	}
}
