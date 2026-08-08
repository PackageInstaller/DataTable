using Config;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class P08MeleeButtonUILogic : IButtonUILogic
{
	public const string ATLAS_PATH = "Atlas/";

	public Image abilityIcon;

	public PlayableDirector effectSwitchAbility;

	private NAgent currentAgent;

	public P08MeleeButtonUILogic(Image abilityIcon, GameObject effectSwitchAbility)
	{
		this.abilityIcon = abilityIcon;
		if (effectSwitchAbility != null)
		{
			PlayableDirector componentInChildren = effectSwitchAbility.GetComponentInChildren<PlayableDirector>(includeInactive: true);
			if (componentInChildren != null)
			{
				StopTimeline(componentInChildren);
				componentInChildren.stopped += OnTimelineStop;
				this.effectSwitchAbility = componentInChildren;
			}
		}
	}

	public void UpdateUIContent(NAgent agent)
	{
		if (abilityIcon == null || agent == null || agent == currentAgent)
		{
			return;
		}
		currentAgent = agent;
		if (!(agent.Blackboard as BBHumanoid == null))
		{
			RoleConfig roleLogicConfig = (agent.Blackboard as BBHumanoid).RoleLogicConfig;
			if (roleLogicConfig != null && roleLogicConfig.Melees.Count > 0)
			{
				abilityIcon.sprite = AtlasManager.GetSprite("Atlas/" + roleLogicConfig.ID, roleLogicConfig.Melees.get_Item(0).ToString());
			}
		}
	}

	private void StopTimeline(PlayableDirector playableDirector)
	{
		playableDirector.Stop();
		playableDirector.gameObject.SetActive(value: false);
	}

	private void OnTimelineStop(PlayableDirector playableDirector)
	{
		playableDirector.gameObject.SetActive(value: false);
	}

	private void PlayTimeline(PlayableDirector playableDirector)
	{
		if (!(playableDirector == null))
		{
			playableDirector.gameObject.SetActive(value: true);
			playableDirector.time = 0.0;
			playableDirector.Play();
		}
	}

	public void PlayEffectOfSwitchAbility()
	{
		PlayTimeline(effectSwitchAbility);
	}
}
