using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRUIHeroSkill : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, int>[] m_StarId;

	private KeyValuePair<int, string>[] m_StarName;

	private KeyValuePair<int, string>[] m_StarDesc;

	private KeyValuePair<int, string>[] m_AllStarDesc;

	private KeyValuePair<int, string>[] m_SimpleDesc;

	public override int Id => m_Id;

	public int HeroId { get; private set; }

	public string HeroName { get; private set; }

	public string Name { get; private set; }

	public string Icon { get; private set; }

	public string SimpleDesc { get; private set; }

	public string StaminaCost { get; private set; }

	public string Desc { get; private set; }

	public int StarId1 { get; private set; }

	public string StarName1 { get; private set; }

	public string StarDesc1 { get; private set; }

	public int StarId2 { get; private set; }

	public string StarName2 { get; private set; }

	public string StarDesc2 { get; private set; }

	public int StarId3 { get; private set; }

	public string StarName3 { get; private set; }

	public string StarDesc3 { get; private set; }

	public string AllStarDesc1 { get; private set; }

	public string AllStarDesc2 { get; private set; }

	public string AllStarDesc3 { get; private set; }

	public string SimpleDesc1 { get; private set; }

	public string SimpleDesc2 { get; private set; }

	public string SimpleDesc3 { get; private set; }

	public int SkillId { get; private set; }

	public string SkillType { get; private set; }

	public string SkillFunc { get; private set; }

	public int StarIdCount => m_StarId.Length;

	public int StarNameCount => m_StarName.Length;

	public int StarDescCount => m_StarDesc.Length;

	public int AllStarDescCount => m_AllStarDesc.Length;

	public int SimpleDescCount => m_SimpleDesc.Length;

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
		HeroId = int.Parse(array[num++]);
		HeroName = array[num++];
		Name = array[num++];
		Icon = array[num++];
		SimpleDesc = array[num++];
		StaminaCost = array[num++];
		Desc = array[num++];
		StarId1 = int.Parse(array[num++]);
		StarName1 = array[num++];
		StarDesc1 = array[num++];
		StarId2 = int.Parse(array[num++]);
		StarName2 = array[num++];
		StarDesc2 = array[num++];
		StarId3 = int.Parse(array[num++]);
		StarName3 = array[num++];
		StarDesc3 = array[num++];
		AllStarDesc1 = array[num++];
		AllStarDesc2 = array[num++];
		AllStarDesc3 = array[num++];
		SimpleDesc1 = array[num++];
		SimpleDesc2 = array[num++];
		SimpleDesc3 = array[num++];
		SkillId = int.Parse(array[num++]);
		SkillType = array[num++];
		SkillFunc = array[num++];
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
			HeroId = binaryReader.Read7BitEncodedInt32();
			HeroName = binaryReader.ReadString();
			Name = binaryReader.ReadString();
			Icon = binaryReader.ReadString();
			SimpleDesc = binaryReader.ReadString();
			StaminaCost = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
			StarId1 = binaryReader.Read7BitEncodedInt32();
			StarName1 = binaryReader.ReadString();
			StarDesc1 = binaryReader.ReadString();
			StarId2 = binaryReader.Read7BitEncodedInt32();
			StarName2 = binaryReader.ReadString();
			StarDesc2 = binaryReader.ReadString();
			StarId3 = binaryReader.Read7BitEncodedInt32();
			StarName3 = binaryReader.ReadString();
			StarDesc3 = binaryReader.ReadString();
			AllStarDesc1 = binaryReader.ReadString();
			AllStarDesc2 = binaryReader.ReadString();
			AllStarDesc3 = binaryReader.ReadString();
			SimpleDesc1 = binaryReader.ReadString();
			SimpleDesc2 = binaryReader.ReadString();
			SimpleDesc3 = binaryReader.ReadString();
			SkillId = binaryReader.Read7BitEncodedInt32();
			SkillType = binaryReader.ReadString();
			SkillFunc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	public int GetStarId(int id)
	{
		KeyValuePair<int, int>[] starId = m_StarId;
		for (int i = 0; i < starId.Length; i++)
		{
			KeyValuePair<int, int> keyValuePair = starId[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetStarId with invalid id '{0}'.", id));
	}

	public int GetStarIdAt(int index)
	{
		if (index < 0 || index >= m_StarId.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetStarIdAt with invalid index '{0}'.", index));
		}
		return m_StarId[index].Value;
	}

	public string GetStarName(int id)
	{
		KeyValuePair<int, string>[] starName = m_StarName;
		for (int i = 0; i < starName.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = starName[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetStarName with invalid id '{0}'.", id));
	}

	public string GetStarNameAt(int index)
	{
		if (index < 0 || index >= m_StarName.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetStarNameAt with invalid index '{0}'.", index));
		}
		return m_StarName[index].Value;
	}

	public string GetStarDesc(int id)
	{
		KeyValuePair<int, string>[] starDesc = m_StarDesc;
		for (int i = 0; i < starDesc.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = starDesc[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetStarDesc with invalid id '{0}'.", id));
	}

	public string GetStarDescAt(int index)
	{
		if (index < 0 || index >= m_StarDesc.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetStarDescAt with invalid index '{0}'.", index));
		}
		return m_StarDesc[index].Value;
	}

	public string GetAllStarDesc(int id)
	{
		KeyValuePair<int, string>[] allStarDesc = m_AllStarDesc;
		for (int i = 0; i < allStarDesc.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = allStarDesc[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetAllStarDesc with invalid id '{0}'.", id));
	}

	public string GetAllStarDescAt(int index)
	{
		if (index < 0 || index >= m_AllStarDesc.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetAllStarDescAt with invalid index '{0}'.", index));
		}
		return m_AllStarDesc[index].Value;
	}

	public string GetSimpleDesc(int id)
	{
		KeyValuePair<int, string>[] simpleDesc = m_SimpleDesc;
		for (int i = 0; i < simpleDesc.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = simpleDesc[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetSimpleDesc with invalid id '{0}'.", id));
	}

	public string GetSimpleDescAt(int index)
	{
		if (index < 0 || index >= m_SimpleDesc.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetSimpleDescAt with invalid index '{0}'.", index));
		}
		return m_SimpleDesc[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_StarId = new KeyValuePair<int, int>[3]
		{
			new KeyValuePair<int, int>(1, StarId1),
			new KeyValuePair<int, int>(2, StarId2),
			new KeyValuePair<int, int>(3, StarId3)
		};
		m_StarName = new KeyValuePair<int, string>[3]
		{
			new KeyValuePair<int, string>(1, StarName1),
			new KeyValuePair<int, string>(2, StarName2),
			new KeyValuePair<int, string>(3, StarName3)
		};
		m_StarDesc = new KeyValuePair<int, string>[3]
		{
			new KeyValuePair<int, string>(1, StarDesc1),
			new KeyValuePair<int, string>(2, StarDesc2),
			new KeyValuePair<int, string>(3, StarDesc3)
		};
		m_AllStarDesc = new KeyValuePair<int, string>[3]
		{
			new KeyValuePair<int, string>(1, AllStarDesc1),
			new KeyValuePair<int, string>(2, AllStarDesc2),
			new KeyValuePair<int, string>(3, AllStarDesc3)
		};
		m_SimpleDesc = new KeyValuePair<int, string>[3]
		{
			new KeyValuePair<int, string>(1, SimpleDesc1),
			new KeyValuePair<int, string>(2, SimpleDesc2),
			new KeyValuePair<int, string>(3, SimpleDesc3)
		};
	}
}
