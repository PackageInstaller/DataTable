using ACT.Battle;
using ACT.Event;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoRespawnView : BaseUIView<MonoRespawnViewInputController>
{
	[SerializeField]
	private ActButton _closeBtn;

	protected override void Init()
	{
		base.Init();
		_closeBtn.SetBtnClick(ToBattleMain);
		MonoECS.instance.PushPauseInput();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show").Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide").Play();
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.PopPauseInput();
	}

	public void ToBattleMain()
	{
		_closeBtn.OnClick.RemoveAllListeners();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		Singleton<RespawnManager>.instance.ConfirmRespawn();
		DispatchRespawnEvent();
	}

	public void InvokeCloseBtn()
	{
		_closeBtn.OnClick?.Invoke();
	}

	private void DispatchRespawnEvent()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Player_Refresh, null);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Player_Respawn, null);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
	}
}
