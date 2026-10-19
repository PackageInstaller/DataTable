using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.World.Actions;

public class PlayOpenAnim : InteractAction
{
	private AsyncOperationHandle<SeparateSegmentConfig> m_Temp;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		OpenBox(behave).Forget();
	}

	private async UniTaskVoid OpenBox(Entity behave)
	{
		behave.SetTrigger("OpenBox");
		await UniTask.NextFrame();
		behave.SetFaceLeft(behave.GetCompTransform().physicsPosition.x - stateObjectBase.transform.position.x > 0f);
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtOpenBox evt = systemAbility.GetEvt<EvtOpenBox>(behave, null);
		evt.mainEntity = (behave.IsValid ? behave : MonoECS.instance.localPlayer.battleEntity);
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}
}
