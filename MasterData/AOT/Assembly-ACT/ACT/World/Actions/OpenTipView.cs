using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class OpenTipView : InteractAction
{
	[Header("要显示的字ID")]
	public int id;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		GameUtility.OpenToolTip(id);
		return UniTask.CompletedTask;
	}
}
