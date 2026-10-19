using ACT.Core;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class EnemySelectPanel : SubUIView<EnemySelectPanelSubController>
{
	public Transform content;

	public Button closeBtn;

	public GameObject enemySelectTypeGroup;

	public int localBossId;

	public int localmonsterId;

	public int localeliteId;

	public ViewControlRoot controlRoot;

	public ViewControlLayer controlLayer;

	private TrainingGroundView _trainingView;

	private MonsterItem _curSelectedItem;

	public BetterAnimation betterAnimation;

	public void Init()
	{
		closeBtn?.SetBtnClick(() =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Close");
			Close();
		});
		_trainingView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_TRAININGGROUND) as TrainingGroundView;
		CreateEnemyTypeGruop();
	}

	public void PlayShowAnimation()
	{
		betterAnimation.GetSequence("Show")?.Play();
	}

	private void CreateEnemyTypeGruop()
	{
		_curSelectedItem = null;
		Transform transform = content;
		if ((object)transform != null && transform.childCount > 0)
		{
			for (int i = 0; i < content.childCount; i++)
			{
				GameObject gameObject = content.GetChild(i).gameObject;
				gameObject.SetActive(value: false);
				Object.Destroy(gameObject);
			}
		}
		int[] monsterHandListType = RuntimeConfigs.data.game.MonsterHandListType;
		for (int j = 0; j < monsterHandListType.Length; j++)
		{
			if (!_trainingView._enemyDatas.TryGetValue(monsterHandListType[j], out var datas))
			{
				continue;
			}
			MonsterTypeGroup monsterTypeGroup = UIUtility.AddWidget<MonsterTypeGroup>(content, enemySelectTypeGroup);
			monsterTypeGroup.Name.StringReference.TableEntryReference = ((monsterHandListType[j] == 2) ? localmonsterId : ((monsterHandListType[j] == 3) ? localBossId : localeliteId));
			for (int k = 0; k < datas.Count; k++)
			{
				MonsterItem monsterItem = UIUtility.AddWidget<MonsterItem>(monsterTypeGroup.TfItemGroup, monsterTypeGroup.MonsterItemPrefab);
				monsterItem.Init(datas[k]);
				int i2 = k;
				monsterItem.OnClick = (int _) =>
				{
					if (_curSelectedItem != monsterItem)
					{
						_curSelectedItem?.OnSelect(isshow: false);
						monsterItem.OnSelect(isshow: true);
						_curSelectedItem = monsterItem;
					}
					_trainingView.OnEnemySelectChanged(datas[i2].id, formInit: false);
				};
				if (datas[k].id == _trainingView.orginalEnemyConfig.enemyId)
				{
					monsterItem.OnSelect(isshow: true);
					_curSelectedItem = monsterItem;
					_trainingView.OnEnemySelectChanged(datas[i2].id, formInit: true, closePanel: false);
				}
			}
		}
	}

	public void RefreshLayout()
	{
		Canvas.ForceUpdateCanvases();
		if (content is RectTransform layoutRoot)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRoot);
		}
		Canvas.ForceUpdateCanvases();
	}

	public void Open()
	{
		gameObject.SetActive(value: true);
		RefreshLayout();
		FocusIn();
		PlayShowAnimation();
	}

	public void Close()
	{
		PlayHideAnimation();
		FocusOut();
		gameObject.SetActive(value: false);
	}

	private void PlayHideAnimation()
	{
		betterAnimation.GetSequence("Hide")?.Play();
	}

	public ACT.ViewControl.SelectableEx GetCurEnemyCellSelectable()
	{
		if (_curSelectedItem == null)
		{
			return null;
		}
		return _curSelectedItem.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}
}
