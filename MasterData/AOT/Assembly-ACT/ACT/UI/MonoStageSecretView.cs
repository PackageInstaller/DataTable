using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class MonoStageSecretView : BaseUIView
{
	public GameObject specailEntry;

	public GameObject normalEntry;

	public Transform specailParent;

	public Transform normalParent;

	public List<Entry> specialEntries = new List<Entry>();

	public List<Entry> normalEntries = new List<Entry>();

	public TextMeshProUGUI score;

	private int m_uiScore;

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Stage_Score, ScoreChange);
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Stage_Score, ScoreChange);
	}

	protected override void Init()
	{
		base.Init();
		m_uiScore = 0;
		LoadEntry();
	}

	protected override void UnInit()
	{
		base.UnInit();
		foreach (Entry specialEntry in specialEntries)
		{
			Object.Destroy(specialEntry.gameObject);
		}
		for (int i = 0; i < normalEntries.Count; i++)
		{
			normalEntries[i].normalToggles.Clear();
			Object.Destroy(normalEntries[i].gameObject);
		}
		specialEntries.Clear();
		normalEntries.Clear();
	}

	public void ScoreChange(BaseEventContent obj)
	{
		StageSecretScoreChange stageSecretScoreChange = (StageSecretScoreChange)obj;
		m_uiScore += stageSecretScoreChange.score;
		score.SetText("{0:0}", m_uiScore);
	}

	public void StartGame()
	{
		StageChallengeManager.Instance.curBossID = 5;
		StageChallengeManager.Instance.GetChallgeInfo(StageChallengeManager.Instance.curBossID).curScore = m_uiScore;
	}

	private void LoadEntry()
	{
		foreach (KeyValuePair<int, Challenge> challenge in RuntimeConfigs.data.challenges)
		{
			if (challenge.Value.type == 2)
			{
				Entry component = Object.Instantiate(specailEntry, specailParent).GetComponent<Entry>();
				component.challenge = challenge.Value;
				component.InitSpecial();
				specialEntries.Add(component);
			}
			else if (challenge.Value.type == 1)
			{
				Entry component2 = Object.Instantiate(normalEntry, normalParent).GetComponent<Entry>();
				component2.challenge = challenge.Value;
				component2.subId = challenge.Key;
				component2.InitNormal();
				normalEntries.Add(component2);
			}
		}
	}
}
