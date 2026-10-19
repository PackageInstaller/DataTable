using Cysharp.Threading.Tasks;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopUpWorldLevelIntroductionView : BaseUIView<PopupWorldLevelIntroductionViewInputController>
{
	private PopUpWorldLevelIntroductionViewData m_data;

	public LocalizeStringEvent title;

	public LocalizeStringEvent description;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		m_data = (PopUpWorldLevelIntroductionViewData)uiViewData;
		Refresh();
	}

	private void Refresh()
	{
		title.StringReference.TableEntryReference = m_data.title;
		description.StringReference.TableEntryReference = m_data.description;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
