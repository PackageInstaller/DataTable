using System;
using ACT.UI;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionOpenRaidView : ActionOpenUI
{
	[OdinSerialize]
	[SerializeField]
	public ActionOpenUIRaidViewData uiData;

	public override int ActionId => NpcInteractActionIds.OpenRaidView;

	protected override bool IsUIConfigurationEditable => false;

	protected override UI_TYPE UIType => UI_TYPE.UI_RAID;

	protected override object UIData => uiData.ToUIViewData();
}
