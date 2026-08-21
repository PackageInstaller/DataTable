using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRChatBox : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, string>[] m_ResPath;

	private KeyValuePair<int, string>[] m_FontColor;

	private KeyValuePair<int, string>[] m_LinkColor;

	public override int Id => m_Id;

	public int PropId { get; private set; }

	public int PropType { get; private set; }

	public string Name { get; private set; }

	public int IdGroup { get; private set; }

	public string Icon { get; private set; }

	public string TipsIcon { get; private set; }

	public string ResPath1 { get; private set; }

	public string ResPath2 { get; private set; }

	public int Quality { get; private set; }

	public int TimeLimited { get; private set; }

	public string Time { get; private set; }

	public int Sort { get; private set; }

	public string AppTxt { get; private set; }

	public string BgsTxt { get; private set; }

	public string FontColor1 { get; private set; }

	public string FontColor2 { get; private set; }

	public string LinkColor1 { get; private set; }

	public string LinkColor2 { get; private set; }

	public int ResPathCount => m_ResPath.Length;

	public int FontColorCount => m_FontColor.Length;

	public int LinkColorCount => m_LinkColor.Length;

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
		PropId = int.Parse(array[num++]);
		PropType = int.Parse(array[num++]);
		Name = array[num++];
		IdGroup = int.Parse(array[num++]);
		Icon = array[num++];
		TipsIcon = array[num++];
		ResPath1 = array[num++];
		ResPath2 = array[num++];
		Quality = int.Parse(array[num++]);
		TimeLimited = int.Parse(array[num++]);
		Time = array[num++];
		Sort = int.Parse(array[num++]);
		AppTxt = array[num++];
		BgsTxt = array[num++];
		FontColor1 = array[num++];
		FontColor2 = array[num++];
		LinkColor1 = array[num++];
		LinkColor2 = array[num++];
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
			PropId = binaryReader.Read7BitEncodedInt32();
			PropType = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			IdGroup = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			TipsIcon = binaryReader.ReadString();
			ResPath1 = binaryReader.ReadString();
			ResPath2 = binaryReader.ReadString();
			Quality = binaryReader.Read7BitEncodedInt32();
			TimeLimited = binaryReader.Read7BitEncodedInt32();
			Time = binaryReader.ReadString();
			Sort = binaryReader.Read7BitEncodedInt32();
			AppTxt = binaryReader.ReadString();
			BgsTxt = binaryReader.ReadString();
			FontColor1 = binaryReader.ReadString();
			FontColor2 = binaryReader.ReadString();
			LinkColor1 = binaryReader.ReadString();
			LinkColor2 = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	public string GetResPath(int id)
	{
		KeyValuePair<int, string>[] resPath = m_ResPath;
		for (int i = 0; i < resPath.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = resPath[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetResPath with invalid id '{0}'.", id));
	}

	public string GetResPathAt(int index)
	{
		if (index < 0 || index >= m_ResPath.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetResPathAt with invalid index '{0}'.", index));
		}
		return m_ResPath[index].Value;
	}

	public string GetFontColor(int id)
	{
		KeyValuePair<int, string>[] fontColor = m_FontColor;
		for (int i = 0; i < fontColor.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = fontColor[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetFontColor with invalid id '{0}'.", id));
	}

	public string GetFontColorAt(int index)
	{
		if (index < 0 || index >= m_FontColor.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetFontColorAt with invalid index '{0}'.", index));
		}
		return m_FontColor[index].Value;
	}

	public string GetLinkColor(int id)
	{
		KeyValuePair<int, string>[] linkColor = m_LinkColor;
		for (int i = 0; i < linkColor.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = linkColor[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetLinkColor with invalid id '{0}'.", id));
	}

	public string GetLinkColorAt(int index)
	{
		if (index < 0 || index >= m_LinkColor.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetLinkColorAt with invalid index '{0}'.", index));
		}
		return m_LinkColor[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_ResPath = new KeyValuePair<int, string>[2]
		{
			new KeyValuePair<int, string>(1, ResPath1),
			new KeyValuePair<int, string>(2, ResPath2)
		};
		m_FontColor = new KeyValuePair<int, string>[2]
		{
			new KeyValuePair<int, string>(1, FontColor1),
			new KeyValuePair<int, string>(2, FontColor2)
		};
		m_LinkColor = new KeyValuePair<int, string>[2]
		{
			new KeyValuePair<int, string>(1, LinkColor1),
			new KeyValuePair<int, string>(2, LinkColor2)
		};
	}
}
