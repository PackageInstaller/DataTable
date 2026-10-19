using ACT.Event;
using ACT.UI;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("切换操作按钮禁用态", "Action", new string[] { "operate", "button", "disable", "ui", "hud" })]
public class ActionOperateBtnConfigDisable : ConfigAction
{
	private static readonly CustomUICompType[] OperateBtnTypes = new CustomUICompType[5]
	{
		CustomUICompType.JumpBtn,
		CustomUICompType.DodgeBtn,
		CustomUICompType.AttackBtn,
		CustomUICompType.SpAttackBtn,
		CustomUICompType.UltraBtn
	};

	public CustomUICompType btnType;

	public bool enterDisableState;

	public override void Do(ActionMemory memory)
	{
		SetOperateBtnConfigDisableEvt evt = Singleton<EventManager>.instance.GetEvt<SetOperateBtnConfigDisableEvt>();
		evt.entityId = memory.target.entity.Id;
		evt.customUICompType = btnType;
		evt.enterDisableState = enterDisableState;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OperateBtn_SetConfigDisable, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
