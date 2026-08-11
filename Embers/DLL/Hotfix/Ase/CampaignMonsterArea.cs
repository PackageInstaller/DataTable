using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class CampaignMonsterArea : CampaignAreaView
{
	[SerializeField]
	private GameObject challengeInfo;

	[SerializeField]
	private TextMeshProUGUI timesInfo;

	[SerializeField]
	private TextMeshProUGUI leftTimeInfo;

	[SerializeField]
	private GameObject bossChallengeInfo;

	[SerializeField]
	private TextMeshProUGUI bossHpInfo;

	[SerializeField]
	private GameObject defeated;

	[SerializeField]
	private GameObject bossLoopEffect;

	[SerializeField]
	private GameObject eliteLoopEffect;

	[SerializeField]
	private GameObject searchEffect;

	[SerializeField]
	private Animation searchAnimation;

	private CampaignMonsterData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<CampaignMonsterData>(userData);
		BindingSet<CampaignMonsterArea, CampaignMonsterData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(defeated).For((GameObject v) => v.activeSelf).To((CampaignMonsterData vm) => vm.Defeated);
		bindingSet.Bind(challengeInfo).For((GameObject v) => v.activeSelf).To((CampaignMonsterData vm) => vm.ShowChallengeInfo);
		bindingSet.Bind<TextMeshProUGUI>(timesInfo).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMonsterData vm) => vm.TimesInfo);
		bindingSet.Bind<TextMeshProUGUI>(leftTimeInfo).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMonsterData vm) => vm.LeftTimeInfo);
		bindingSet.Bind(bossChallengeInfo).For((GameObject v) => v.activeSelf).To((CampaignMonsterData vm) => vm.ShowBossChallengeInfo);
		bindingSet.Bind<TextMeshProUGUI>(bossHpInfo).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMonsterData vm) => vm.BossHpInfo);
		bindingSet.Bind(bossLoopEffect).For((GameObject v) => v.activeSelf).ToExpression((CampaignMonsterData vm) => (int)vm.Type == 4);
		bindingSet.Bind(eliteLoopEffect).For((GameObject v) => v.activeSelf).ToExpression((CampaignMonsterData vm) => (int)vm.Type == 3);
		bindingSet.Build();
	}

	public override void OnShow()
	{
		base.OnShow();
		if (_viewModel != null)
		{
			if (!_viewModel.SearchNew)
			{
				searchEffect.SetActive(value: false);
				searchAnimation.playAutomatically = false;
				((Behaviour)(object)searchAnimation).enabled = false;
			}
			else
			{
				searchEffect.SetActive(value: true);
				searchAnimation.playAutomatically = false;
				((Behaviour)(object)searchAnimation).enabled = true;
				searchAnimation.Play();
				_viewModel.SearchNew = false;
			}
		}
	}
}
