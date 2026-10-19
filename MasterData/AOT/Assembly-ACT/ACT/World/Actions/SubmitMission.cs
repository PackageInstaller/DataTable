using ACT.Battle;
using ACT.Battle.Configs;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class SubmitMission : InteractAction
{
	public int finishSubMissionId;

	public int nextSubMissionId;

	[Header("为True要改变的状态")]
	public int swid;

	public int stateId;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPSUBMITMISSIONPANEL, finishSubMissionId);
		if (!Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_POPUPSUBMITMISSIONPANEL, out var ui))
		{
			return;
		}
		IBaseUIView uIView = ui.GetUIView();
		if (uIView is MonoPopUpMissionSubmitView submitMissionView)
		{
			submitMissionView.nextMissionId = nextSubMissionId;
			bool flag = await submitMissionView.GetSubmitMissionState();
			submitMissionView.Close();
			if (flag)
			{
				MonoECS.instance.ruleManager.SharedChangeState(swid, stateId);
			}
		}
	}
}
