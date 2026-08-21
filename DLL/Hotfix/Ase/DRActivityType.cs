using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRActivityType : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, int>[] m_AdditionalParam;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Item { get; private set; }

	public int Priority { get; private set; }

	public string ViewPath { get; private set; }

	public string ViewModelName { get; private set; }

	public int TimeLimit { get; private set; }

	public List<int> StartCondition { get; private set; }

	public List<int> StartConditionValue { get; private set; }

	public int EndCondition { get; private set; }

	public int EndConditionValue { get; private set; }

	public int UnlockCondition { get; private set; }

	public int UnlockConditionValue { get; private set; }

	public int StartType { get; private set; }

	public int EndType { get; private set; }

	public int ChangeType { get; private set; }

	public string ChangeEx { get; private set; }

	public int FinishType { get; private set; }

	public string FinishEx { get; private set; }

	public string Desc { get; private set; }

	public int RewardId { get; private set; }

	public int ActType { get; private set; }

	public int AdditionalParam1 { get; private set; }

	public int AdditionalParamCount => m_AdditionalParam.Length;

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
		Item = array[num++];
		Priority = int.Parse(array[num++]);
		ViewPath = array[num++];
		ViewModelName = array[num++];
		TimeLimit = int.Parse(array[num++]);
		StartCondition = DataTableExtension.ParseListInt(array[num++]);
		StartConditionValue = DataTableExtension.ParseListInt(array[num++]);
		EndCondition = int.Parse(array[num++]);
		EndConditionValue = int.Parse(array[num++]);
		UnlockCondition = int.Parse(array[num++]);
		UnlockConditionValue = int.Parse(array[num++]);
		StartType = int.Parse(array[num++]);
		EndType = int.Parse(array[num++]);
		ChangeType = int.Parse(array[num++]);
		ChangeEx = array[num++];
		FinishType = int.Parse(array[num++]);
		FinishEx = array[num++];
		Desc = array[num++];
		RewardId = int.Parse(array[num++]);
		ActType = int.Parse(array[num++]);
		AdditionalParam1 = int.Parse(array[num++]);
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
			Item = binaryReader.ReadString();
			Priority = binaryReader.Read7BitEncodedInt32();
			ViewPath = binaryReader.ReadString();
			ViewModelName = binaryReader.ReadString();
			TimeLimit = binaryReader.Read7BitEncodedInt32();
			StartCondition = binaryReader.ReadListInt();
			StartConditionValue = binaryReader.ReadListInt();
			EndCondition = binaryReader.Read7BitEncodedInt32();
			EndConditionValue = binaryReader.Read7BitEncodedInt32();
			UnlockCondition = binaryReader.Read7BitEncodedInt32();
			UnlockConditionValue = binaryReader.Read7BitEncodedInt32();
			StartType = binaryReader.Read7BitEncodedInt32();
			EndType = binaryReader.Read7BitEncodedInt32();
			ChangeType = binaryReader.Read7BitEncodedInt32();
			ChangeEx = binaryReader.ReadString();
			FinishType = binaryReader.Read7BitEncodedInt32();
			FinishEx = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
			RewardId = binaryReader.Read7BitEncodedInt32();
			ActType = binaryReader.Read7BitEncodedInt32();
			AdditionalParam1 = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	public int GetAdditionalParam(int id)
	{
		KeyValuePair<int, int>[] additionalParam = m_AdditionalParam;
		for (int i = 0; i < additionalParam.Length; i++)
		{
			KeyValuePair<int, int> keyValuePair = additionalParam[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetAdditionalParam with invalid id '{0}'.", id));
	}

	public int GetAdditionalParamAt(int index)
	{
		if (index < 0 || index >= m_AdditionalParam.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetAdditionalParamAt with invalid index '{0}'.", index));
		}
		return m_AdditionalParam[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_AdditionalParam = new KeyValuePair<int, int>[1]
		{
			new KeyValuePair<int, int>(1, AdditionalParam1)
		};
	}
}
