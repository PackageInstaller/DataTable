using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoReadStoryView : BaseUIView
{
	public class MonoReadStoryViewData : UIViewData
	{
		public int nameLocalId;

		public int storyLocalId;
	}

	public LocalizeStringEvent storyText;

	public LocalizeStringEvent itemNameText;

	private MonoReadStoryViewData m_MonoReadStoryViewData;

	protected override void Init()
	{
		m_MonoReadStoryViewData = uiViewData as MonoReadStoryViewData;
		storyText.StringReference.TableEntryReference = m_MonoReadStoryViewData.storyLocalId;
		itemNameText.StringReference.TableEntryReference = m_MonoReadStoryViewData.nameLocalId;
	}
}
