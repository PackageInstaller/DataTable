using ACT.Battle;
using ACT.Event;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MineTrainOperateBaseView : BaseUIView<MineTrainOperateViewInputController>
{
	protected MineTrainOperateBaseViewData m_data;

	[SerializeField]
	private JoyStick _onMove;

	[SerializeField]
	private CanvasGroup _promptskeyBoard;

	[SerializeField]
	private CanvasGroup _promptscontroller;

	[SerializeField]
	private ActButton _interactClose;

	[SerializeField]
	private ActButton _commonClose;

	private void BackBtnEvt()
	{
		ExitStateObjectControlEvt evt = Singleton<EventManager>.instance.GetEvt<ExitStateObjectControlEvt>();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_ExitStateObjectControl, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public override UniTask PreInit()
	{
		_interactClose.SetBtnClick(() =>
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_ExitStateObjectControl, null);
		});
		_commonClose.SetBtnClick(BackBtnEvt);
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		_onMove.Init();
		_onMove.gameObject.SetActive(!MonoECS.instance.ispc);
		InternalOnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void UnInit()
	{
		_onMove.UnInit();
		base.UnInit();
	}

	protected override void AddEventListener()
	{
		MonoECS.instance.onInputModeChange.AddListener(InternalOnInputDeviceChange);
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(InternalOnInputDeviceChange);
		base.RemoveEventListener();
	}

	private void InternalOnInputDeviceChange(DeviceInputMode type)
	{
		_promptskeyBoard.alpha = ((type == DeviceInputMode.KeyboardAndMouse) ? 1 : 0);
		_promptscontroller.alpha = ((type == DeviceInputMode.Gamepad) ? 1 : 0);
	}

	protected override void OpenEffectCallback()
	{
		if (!MonoECS.instance.mainEntity.IsAlive())
		{
			Close();
		}
		base.OpenEffectCallback();
	}

	public Entity GetControlledTarget()
	{
		return (uiViewData as MineTrainOperateBaseViewData).entity;
	}
}
