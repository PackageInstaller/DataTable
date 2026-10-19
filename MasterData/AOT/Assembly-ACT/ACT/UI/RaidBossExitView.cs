using System;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class RaidBossExitView : BaseUIView
{
	public class RaidBossExitData : UIViewData
	{
		public Action OnCloseHandle;
	}

	private RaidBossExitData raidBossExitData;

	[SerializeField]
	private ParticleSystem betterParticle;

	private bool flag;

	[SerializeField]
	private GameObject m_UIParticle_BossExit;

	protected override async void Init()
	{
		base.Init();
		raidBossExitData = uiViewData as RaidBossExitData;
		m_UIParticle_BossExit.gameObject.SetActive(value: false);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Boss_Win");
	}

	private void Update()
	{
		if (!flag && m_UIParticle_BossExit.activeSelf)
		{
			flag = true;
			betterParticle.Play();
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("All").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
			Close();
			raidBossExitData.OnCloseHandle?.Invoke();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}
}
