using System;
using ACT.UI;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionOpenReadableView : ActionOpenUI
{
	[OdinSerialize]
	[SerializeField]
	public ActionOpenUIReadableViewData uiData;

	public override int ActionId => NpcInteractActionIds.OpenReadableView;

	protected override bool IsUIConfigurationEditable => false;

	protected override UI_TYPE UIType => UI_TYPE.UI_READABLE;

	protected override object UIData => uiData.ToUIViewData();
}
