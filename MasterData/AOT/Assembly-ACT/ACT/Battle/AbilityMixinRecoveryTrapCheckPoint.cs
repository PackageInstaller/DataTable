using System;
using System.Threading;
using ACT.Battle.Configs;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Battle;

public class AbilityMixinRecoveryTrapCheckPoint : BaseAbilityMixin
{
	private ConfigMixinRecoveryTrapCheckPoint m_Config;

	public AbilityMixinRecoveryTrapCheckPoint(ConfigMixinRecoveryTrapCheckPoint config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void OnAdd()
	{
		Teleport();
	}

	private async void Teleport(CancellationToken token = default(CancellationToken))
	{
		MonoECS instance = MonoECS.instance;
		if (owner.GetCompMotion().curMotionState == MotionState.Die)
		{
			Entity switchCharacter = instance.localPlayer.GetSwitchCharacter(0);
			Entity switchCharacter2 = instance.localPlayer.GetSwitchCharacter(1);
			if (switchCharacter.IsAlive())
			{
				owner.Teleport(MonoECS.instance.checkPointManager.GetLastCheckPoint());
				instance.ChangeCharacter(instance.localPlayer.IndexOfTeamCharacter(switchCharacter));
			}
			else if (switchCharacter2.IsAlive())
			{
				owner.Teleport(MonoECS.instance.checkPointManager.GetLastCheckPoint());
				instance.ChangeCharacter(instance.localPlayer.IndexOfTeamCharacter(switchCharacter2));
			}
			owner.GetCompAbility().RemoveAbility(ability.config.name);
			return;
		}
		MonoECS.instance.PushPauseInput();
		Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
		{
			fadeInTime = TimeSpan.FromSeconds(m_Config.fadeInTime)
		}).Forget();
		await UniTask.Delay(TimeSpan.FromSeconds(m_Config.fadeInTime + m_Config.lastTime / 2f), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
		owner.Teleport(MonoECS.instance.checkPointManager.GetLastCheckPoint());
		State state = owner.GetCompMotion().moveController.childrenStateLayers[0].states.Find((State x) => x.value.stateType == MotionState.Idle);
		Singleton<GameManager>.instance.ecsManager.systemBehave.ForcedChangeToMotionState(owner, state);
		await UniTask.Delay(TimeSpan.FromSeconds(m_Config.lastTime / 2f));
		Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
		{
			fadeOutTime = TimeSpan.FromSeconds(m_Config.fadeOutTime)
		}).Forget();
		await UniTask.Delay(TimeSpan.FromSeconds(m_Config.fadeOutTime));
		MonoECS.instance.PopPauseInput();
		owner.GetCompAbility().RemoveAbility(ability.config.name);
	}
}
