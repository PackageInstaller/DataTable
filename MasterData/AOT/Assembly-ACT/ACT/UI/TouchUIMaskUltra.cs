using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Sound;
using Bamboo.ECS;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TouchUIMaskUltra : TouchUIMaskBase
{
	public List<Image> imageList = new List<Image>();

	public List<Renderer> rendererList = new List<Renderer>();

	public Animator animator;

	public string completeParam;

	public Image cdMask;

	public TextMeshProUGUI cdText;

	private MaterialPropertyBlock m_Mpb;

	private void Awake()
	{
		m_Mpb = new MaterialPropertyBlock();
	}

	public override void SetValue()
	{
		foreach (Image image in imageList)
		{
			image.fillAmount = value;
		}
		if (m_Mpb != null)
		{
			m_Mpb.SetFloat("_Cut", 1f - value);
		}
		foreach (Renderer renderer in rendererList)
		{
			renderer.SetPropertyBlock(m_Mpb);
		}
		animator.SetBool(completeParam, Mathf.Approximately(value, 1f));
	}

	public void PlayFullEnergySound()
	{
		if (Mathf.Approximately(value, 1f))
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Charge_Complete", new AudioPlayOptions
			{
				attachTarget = Camera.main.transform
			});
		}
	}

	public void RefreshCD(Skill skill)
	{
		float num = ((skill.NowCount != skill.config.maxCount) ? (skill.NowCd / skill.config.CD) : 0f);
		cdMask.fillAmount = num;
		cdText.SetText("{0:0}", Mathf.FloorToInt(skill.NowCd));
		cdMask.gameObject.SetActive(num != 0f);
	}

	public void Init(Ability ab)
	{
		ConfigCharacter config = ab.owner.GetConfig();
		for (int i = 0; i < config.skills.Length; i++)
		{
			SkillConfig skillConfig = config.skills[i];
			if (skillConfig.name != "skillCD")
			{
				continue;
			}
			for (int j = 0; j < skillConfig.motions.Length; j++)
			{
				if (ab.owner.GetCompMotion().skillLookup.TryGetValue(skillConfig.motions[j], out var skillStart) && skillStart != null)
				{
					RefreshCD(skillStart);
					skillStart.onChanged += () =>
					{
						RefreshCD(skillStart);
					};
				}
			}
		}
	}

	private void OnEnable()
	{
		OpenRefresh();
	}

	public void OpenRefresh()
	{
		animator.SetBool(completeParam, Mathf.Approximately(value, 1f));
	}
}
