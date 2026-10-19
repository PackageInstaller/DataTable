using System.Collections.Generic;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class TempleTaskItem : CommonTaskItemBase
{
	[SerializeField]
	private GameObject _target2;

	[SerializeField]
	private TextMeshProUGUI _collectBoxText;

	[SerializeField]
	private List<GameObject> _activeRobots;

	[SerializeField]
	private List<BetterAnimation> _betterAnimations;

	private int animDelay = 30;

	public override void Refresh(SettlementType settlementType)
	{
		RefreshAsync().Forget();
	}

	private async UniTaskVoid RefreshAsync()
	{
		SetActive(active: true);
		int totalSeconds = (int)Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
		UpdateTotalTime(totalSeconds);
		TempleData templeData = Model<TempleModel>.Interface.GetCurChallengeTempleData();
		if (templeData != null)
		{
			for (int i = 0; i < _activeRobots.Count && i < templeData.gotStars.Length; i++)
			{
				_activeRobots[i].SetActive(templeData.gotStars[i]);
			}
		}
		int totalTreasureBox = await Model<TempleModel>.Interface.GetTotalTreasureBoxCount(Model<TempleModel>.Interface.CurChallengeTempleId);
		int num = await Model<TempleModel>.Interface.GetTreasureBoxCount(Model<TempleModel>.Interface.CurChallengeTempleId);
		_target2.SetActive(totalTreasureBox > 0);
		_collectBoxText.SetText("{0:0}/{1:0}", num, totalTreasureBox);
		_title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, templeData.staticData.name);
		for (int j = 0; j < _betterAnimations.Count; j++)
		{
			_betterAnimations[j].GetComponent<CanvasGroup>().alpha = 0f;
		}
	}

	public override async void PlayItemAnimation(SettlementType settlementType)
	{
		for (int i = 0; i < _betterAnimations.Count; i++)
		{
			if (_betterAnimations[i].gameObject.activeSelf)
			{
				_betterAnimations[i].GetComponent<CanvasGroup>().alpha = 1f;
				_betterAnimations[i].GetSequence("NormalShow").Play();
				await UniTask.Delay(animDelay);
			}
		}
	}
}
