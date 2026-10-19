using System;
using System.Collections.Generic;
using ACT.Sound;

namespace ACT.UI;

public class VoicePackageViewData : UIViewData
{
	[Serializable]
	public class VoicePackageItemData
	{
		public AudioLanguageType languageType;

		public string displayName;

		public string packageSize;

		public bool isDownloaded;

		public bool isInUse;
	}

	public List<VoicePackageItemData> PackageDataList;

	public List<VoicePackageItem> ItemList = new List<VoicePackageItem>();

	public int SelectedIndex = -1;
}
