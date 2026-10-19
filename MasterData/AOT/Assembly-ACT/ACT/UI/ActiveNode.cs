using System;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class ActiveNode : ActButton
{
	public TMP_Text needPoint;

	public GameObject cannotObtain;

	public GameObject canObtain;

	public GameObject hasObtain;

	public BetterAnimation betterAnimation;

	private int _dailyMissionRewardID;

	private NodeState _nodeState;

	public int DailyMissionRewardID
	{
		get
		{
			return _dailyMissionRewardID;
		}
		set
		{
			_dailyMissionRewardID = value;
			InternalUpdateStyle();
		}
	}

	public Action<ActiveNode> OnActiveNodeClick { get; set; }

	protected override void Awake()
	{
		base.Awake();
		OnClick.AddListener(() =>
		{
			OnActiveNodeClick(this);
		});
	}

	private void InternalUpdateStyle()
	{
		DailyMissionReward data = CoreUtils.GetData(DailyMissionRewardID, RuntimeConfigs.data.dailyMissionRewards);
		if (data == null)
		{
			return;
		}
		needPoint.SetText(data.creditRequire.FastToString());
		if (G.localPlayer.DailyData.HandbookRewardStatus.DailyPointReward.TryGetValue(DailyMissionRewardID, out var _))
		{
			hasObtain.SetActive(value: true);
			cannotObtain.SetActive(value: false);
			canObtain.SetActive(value: false);
			_nodeState = NodeState.HasObtain;
			return;
		}
		G.detailUserInfo.Attributes.TryGetValue(RuntimeConfigs.data.game.attrActivePoint, out var value2);
		if (value2 >= data.creditRequire)
		{
			hasObtain.SetActive(value: false);
			cannotObtain.SetActive(value: false);
			canObtain.SetActive(value: true);
			betterAnimation?.GetSequence("CanObtain")?.Play();
			_nodeState = NodeState.CanObtain;
			if (_nodeState != NodeState.CanObtain)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Daily Mission/Claim_Unlock");
			}
		}
		else
		{
			hasObtain.SetActive(value: false);
			cannotObtain.SetActive(value: true);
			canObtain.SetActive(value: false);
			_nodeState = NodeState.CannotObtain;
		}
	}
}
