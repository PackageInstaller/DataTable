using ACT.Battle;
using ACT.Battle.Configs;
using ACT.EventTrack;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class RecoverBloodBottle : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Server;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		RecoverBloodItemEvt evt = EventTrackSolver.Instance.GetEvt<RecoverBloodItemEvt>();
		evt.teleportId = stateObjectBase.swid;
		EventTrackSolver.Instance.Dispatch(evt);
		Singleton<BloodBottleHandler>.instance.RecoverItems();
		if (MPPlayer.local.CurrentActiveBattlePotionId != 0)
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			CompAbility compAbility = mainEntity.GetCompAbility();
			if (compAbility != null && compAbility.TryGetAbility("RecoverMaxHP", includeAdd: true, out var ab) && !GameUtility.BloodBottleRecoverMax)
			{
				BloodBottleRecoverMax evt2 = Singleton<GameManager>.instance.ecsManager.systemAbility.GetEvt<BloodBottleRecoverMax>(mainEntity, ab);
				evt2.bloodbottleRecoverMax = true;
				evt2.mainEntity = mainEntity;
				Singleton<GameManager>.instance.ecsManager.systemAbility.FireEvt(evt2);
				Singleton<GameManager>.instance.ecsManager.systemAbility.ReleaseEvt(evt2);
			}
		}
		return UniTask.CompletedTask;
	}
}
