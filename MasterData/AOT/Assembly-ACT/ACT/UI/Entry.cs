using System.Collections.Generic;
using ACT.Config;
using ACT.Event;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class Entry : MonoBehaviour
{
	public ToggleGroup toggleGroup;

	public Toggle toggle;

	public Difficulty difficulty;

	public LocalizeStringEvent entryName;

	public TextMeshProUGUI desText;

	public TextMeshProUGUI score;

	public LocalizeStringEvent des;

	public int subId;

	public int curSelect = -1;

	public Challenge challenge;

	public GameObject normalToggle;

	public Transform limit;

	public List<NormalToggle> normalToggles = new List<NormalToggle>();

	private Color m_color1 = new Color(54f / 255f, 203f / 255f, 228f / 255f);

	private Color m_color2 = new Color(172f / 255f, 213f / 255f, 1f);

	private bool m_IsFirstSelect = true;

	private int m_Score = -1;

	public void InitNormal()
	{
		entryName.StringReference.TableEntryReference = challenge.nameLocal;
		for (int i = 0; i < challenge.desc.Length; i++)
		{
			GameObject gameObject = Object.Instantiate(normalToggle, limit);
			NormalToggle nomalinfo = gameObject.GetComponent<NormalToggle>();
			nomalinfo.index = i;
			nomalinfo.des.StringReference.TableEntryReference = challenge.descLocal[i];
			nomalinfo.toggle.group = toggleGroup;
			nomalinfo.toggle.onValueChanged.AddListener((bool ison) =>
			{
				OnChangeValue(nomalinfo);
			});
			normalToggles.Add(nomalinfo);
		}
	}

	private void OnChangeValue(NormalToggle toggle)
	{
		if (toggle.toggle.isOn)
		{
			toggle.desText.color = m_color1;
			m_Score = challenge.score[toggle.index];
			if (curSelect != toggle.index || m_IsFirstSelect)
			{
				curSelect = toggle.index;
				subId = challenge.subID[curSelect];
				StageSecretScoreChange evt = Singleton<EventManager>.instance.GetEvt<StageSecretScoreChange>();
				evt.score = m_Score;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Stage_Score, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
				m_IsFirstSelect = false;
			}
		}
		else
		{
			toggle.desText.color = m_color2;
			StageSecretScoreChange evt2 = Singleton<EventManager>.instance.GetEvt<StageSecretScoreChange>();
			evt2.score = -m_Score;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Stage_Score, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
		}
	}

	public void InitSpecial()
	{
		toggle.isOn = false;
		des.StringReference.TableEntryReference = challenge.descLocal[0];
		m_Score = challenge.score[0];
		score.text = $"{m_Score}点数";
		subId = challenge.subID[0];
		toggle.onValueChanged.AddListener((bool isOn) =>
		{
			if (isOn)
			{
				desText.color = m_color1;
				score.color = m_color1;
				StageSecretScoreChange evt = Singleton<EventManager>.instance.GetEvt<StageSecretScoreChange>();
				evt.score = m_Score;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Stage_Score, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			else
			{
				desText.color = m_color2;
				score.color = m_color2;
				StageSecretScoreChange evt2 = Singleton<EventManager>.instance.GetEvt<StageSecretScoreChange>();
				evt2.score = -m_Score;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Stage_Score, evt2);
				Singleton<EventManager>.instance.ReleaseEvt(evt2);
			}
		});
	}
}
