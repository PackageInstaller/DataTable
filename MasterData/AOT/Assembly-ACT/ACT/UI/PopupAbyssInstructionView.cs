using Cysharp.Threading.Tasks;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopupAbyssInstructionView : BaseUIView
{
	private PopupAbyssInstructionViewData m_data;

	public LocalizeStringEvent title;

	public LocalizeStringEvent desc;

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
		m_data = (PopupAbyssInstructionViewData)uiViewData;
		SetData();
	}

	private void SetData()
	{
		title.StringReference.TableEntryReference = m_data.title;
		desc.StringReference.TableEntryReference = m_data.desc;
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
