using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DRTeaching : DataRowBase
{
	private int m_Id;

	private KeyValuePair<int, string>[] m_PopupTitle;

	private KeyValuePair<int, string>[] m_PopupPicture;

	private KeyValuePair<int, string>[] m_PopupText;

	private KeyValuePair<int, string>[] m_PopupVideo;

	public override int Id => m_Id;

	public bool SaveData { get; private set; }

	public int TeachingType { get; private set; }

	public bool Manual { get; private set; }

	public bool Pause { get; private set; }

	public int FinishCondition { get; private set; }

	public bool ClickDownFinish { get; private set; }

	public float TimeDelay { get; private set; }

	public bool BlackShade { get; private set; }

	public float TimeAutoComplete { get; private set; }

	public int FrameTarget { get; private set; }

	public int FrameTargetDir { get; private set; }

	public List<float> FrameTargetOffset { get; private set; }

	public bool CanClikOtherArea { get; private set; }

	public string SelectUI { get; private set; }

	public int TargetUIIndex { get; private set; }

	public List<float> FrameSize { get; private set; }

	public List<float> FrameShifting { get; private set; }

	public List<int> HideUIIndex { get; private set; }

	public List<int> ShowUIIndex { get; private set; }

	public float DelayShowTime { get; private set; }

	public int NextGuideId { get; private set; }

	public float NextGuideDelayTime { get; private set; }

	public string FrameText { get; private set; }

	public List<int> PopupConfigure { get; private set; }

	public string PopupTitle1 { get; private set; }

	public string PopupPicture1 { get; private set; }

	public string PopupText1 { get; private set; }

	public string PopupVideo1 { get; private set; }

	public string PopupTitle2 { get; private set; }

	public string PopupPicture2 { get; private set; }

	public string PopupText2 { get; private set; }

	public string PopupVideo2 { get; private set; }

	public string PopupTitle3 { get; private set; }

	public string PopupPicture3 { get; private set; }

	public string PopupText3 { get; private set; }

	public string PopupVideo3 { get; private set; }

	public int PopupTitleCount => m_PopupTitle.Length;

	public int PopupPictureCount => m_PopupPicture.Length;

	public int PopupTextCount => m_PopupText.Length;

	public int PopupVideoCount => m_PopupVideo.Length;

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
		SaveData = bool.Parse(array[num++]);
		TeachingType = int.Parse(array[num++]);
		Manual = bool.Parse(array[num++]);
		Pause = bool.Parse(array[num++]);
		FinishCondition = int.Parse(array[num++]);
		ClickDownFinish = bool.Parse(array[num++]);
		TimeDelay = float.Parse(array[num++]);
		BlackShade = bool.Parse(array[num++]);
		TimeAutoComplete = float.Parse(array[num++]);
		FrameTarget = int.Parse(array[num++]);
		FrameTargetDir = int.Parse(array[num++]);
		FrameTargetOffset = DataTableExtension.ParseListFloat(array[num++]);
		CanClikOtherArea = bool.Parse(array[num++]);
		SelectUI = array[num++];
		TargetUIIndex = int.Parse(array[num++]);
		FrameSize = DataTableExtension.ParseListFloat(array[num++]);
		FrameShifting = DataTableExtension.ParseListFloat(array[num++]);
		HideUIIndex = DataTableExtension.ParseListInt(array[num++]);
		ShowUIIndex = DataTableExtension.ParseListInt(array[num++]);
		DelayShowTime = float.Parse(array[num++]);
		NextGuideId = int.Parse(array[num++]);
		NextGuideDelayTime = float.Parse(array[num++]);
		FrameText = array[num++];
		PopupConfigure = DataTableExtension.ParseListInt(array[num++]);
		PopupTitle1 = array[num++];
		PopupPicture1 = array[num++];
		PopupText1 = array[num++];
		PopupVideo1 = array[num++];
		PopupTitle2 = array[num++];
		PopupPicture2 = array[num++];
		PopupText2 = array[num++];
		PopupVideo2 = array[num++];
		PopupTitle3 = array[num++];
		PopupPicture3 = array[num++];
		PopupText3 = array[num++];
		PopupVideo3 = array[num++];
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
			SaveData = binaryReader.ReadBoolean();
			TeachingType = binaryReader.Read7BitEncodedInt32();
			Manual = binaryReader.ReadBoolean();
			Pause = binaryReader.ReadBoolean();
			FinishCondition = binaryReader.Read7BitEncodedInt32();
			ClickDownFinish = binaryReader.ReadBoolean();
			TimeDelay = binaryReader.ReadSingle();
			BlackShade = binaryReader.ReadBoolean();
			TimeAutoComplete = binaryReader.ReadSingle();
			FrameTarget = binaryReader.Read7BitEncodedInt32();
			FrameTargetDir = binaryReader.Read7BitEncodedInt32();
			FrameTargetOffset = binaryReader.ReadListFloat();
			CanClikOtherArea = binaryReader.ReadBoolean();
			SelectUI = binaryReader.ReadString();
			TargetUIIndex = binaryReader.Read7BitEncodedInt32();
			FrameSize = binaryReader.ReadListFloat();
			FrameShifting = binaryReader.ReadListFloat();
			HideUIIndex = binaryReader.ReadListInt();
			ShowUIIndex = binaryReader.ReadListInt();
			DelayShowTime = binaryReader.ReadSingle();
			NextGuideId = binaryReader.Read7BitEncodedInt32();
			NextGuideDelayTime = binaryReader.ReadSingle();
			FrameText = binaryReader.ReadString();
			PopupConfigure = binaryReader.ReadListInt();
			PopupTitle1 = binaryReader.ReadString();
			PopupPicture1 = binaryReader.ReadString();
			PopupText1 = binaryReader.ReadString();
			PopupVideo1 = binaryReader.ReadString();
			PopupTitle2 = binaryReader.ReadString();
			PopupPicture2 = binaryReader.ReadString();
			PopupText2 = binaryReader.ReadString();
			PopupVideo2 = binaryReader.ReadString();
			PopupTitle3 = binaryReader.ReadString();
			PopupPicture3 = binaryReader.ReadString();
			PopupText3 = binaryReader.ReadString();
			PopupVideo3 = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	public string GetPopupTitle(int id)
	{
		KeyValuePair<int, string>[] popupTitle = m_PopupTitle;
		for (int i = 0; i < popupTitle.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = popupTitle[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetPopupTitle with invalid id '{0}'.", id));
	}

	public string GetPopupTitleAt(int index)
	{
		if (index < 0 || index >= m_PopupTitle.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetPopupTitleAt with invalid index '{0}'.", index));
		}
		return m_PopupTitle[index].Value;
	}

	public string GetPopupPicture(int id)
	{
		KeyValuePair<int, string>[] popupPicture = m_PopupPicture;
		for (int i = 0; i < popupPicture.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = popupPicture[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetPopupPicture with invalid id '{0}'.", id));
	}

	public string GetPopupPictureAt(int index)
	{
		if (index < 0 || index >= m_PopupPicture.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetPopupPictureAt with invalid index '{0}'.", index));
		}
		return m_PopupPicture[index].Value;
	}

	public string GetPopupText(int id)
	{
		KeyValuePair<int, string>[] popupText = m_PopupText;
		for (int i = 0; i < popupText.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = popupText[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetPopupText with invalid id '{0}'.", id));
	}

	public string GetPopupTextAt(int index)
	{
		if (index < 0 || index >= m_PopupText.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetPopupTextAt with invalid index '{0}'.", index));
		}
		return m_PopupText[index].Value;
	}

	public string GetPopupVideo(int id)
	{
		KeyValuePair<int, string>[] popupVideo = m_PopupVideo;
		for (int i = 0; i < popupVideo.Length; i++)
		{
			KeyValuePair<int, string> keyValuePair = popupVideo[i];
			if (keyValuePair.Key == id)
			{
				return keyValuePair.Value;
			}
		}
		throw new GameFrameworkException(Utility.Text.Format("GetPopupVideo with invalid id '{0}'.", id));
	}

	public string GetPopupVideoAt(int index)
	{
		if (index < 0 || index >= m_PopupVideo.Length)
		{
			throw new GameFrameworkException(Utility.Text.Format("GetPopupVideoAt with invalid index '{0}'.", index));
		}
		return m_PopupVideo[index].Value;
	}

	private void GeneratePropertyArray()
	{
		m_PopupTitle = new KeyValuePair<int, string>[3]
		{
			new KeyValuePair<int, string>(1, PopupTitle1),
			new KeyValuePair<int, string>(2, PopupTitle2),
			new KeyValuePair<int, string>(3, PopupTitle3)
		};
		m_PopupPicture = new KeyValuePair<int, string>[3]
		{
			new KeyValuePair<int, string>(1, PopupPicture1),
			new KeyValuePair<int, string>(2, PopupPicture2),
			new KeyValuePair<int, string>(3, PopupPicture3)
		};
		m_PopupText = new KeyValuePair<int, string>[3]
		{
			new KeyValuePair<int, string>(1, PopupText1),
			new KeyValuePair<int, string>(2, PopupText2),
			new KeyValuePair<int, string>(3, PopupText3)
		};
		m_PopupVideo = new KeyValuePair<int, string>[3]
		{
			new KeyValuePair<int, string>(1, PopupVideo1),
			new KeyValuePair<int, string>(2, PopupVideo2),
			new KeyValuePair<int, string>(3, PopupVideo3)
		};
	}
}
