using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoMiddlePropPickingView : BaseUIComponent, IBattleMainComponent
{
	private MonoMiddlePropPickingData m_Data;

	[SerializeField]
	private BetterAnimation anim;

	[SerializeField]
	private float duration;

	[SerializeField]
	private CommonScrollBagComponent _itemRect;

	[SerializeField]
	private LocalizeStringEvent _titleStrEvent;

	private List<ItemUnifierProxy> _itemUnifierData;

	public bool middlePropIsOpen { get; private set; }

	public void Init(MonoMiddlePropPickingData data, Action openFail)
	{
		try
		{
			m_Data = data;
			_titleStrEvent.StringReference.TableEntryReference = data.Content;
			onClose = () =>
			{
				Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.Center);
			};
			_itemUnifierData = ListPool<ItemUnifierProxy>.Get();
			PlayOpenAnimation();
			InitItem(m_Data.info).Forget();
		}
		catch (Exception arg)
		{
			openFail?.Invoke();
			gameObject.SetActive(value: false);
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"稀有获得打开失败;{arg}");
			}
		}
	}

	public void UnInit()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_itemUnifierData);
		ListPool<ItemUnifierProxy>.Release(_itemUnifierData);
		PlayCloseAnimation();
	}

	private void PlayOpenAnimation(UI_TYPE uiType = UI_TYPE.UI_NONE)
	{
		gameObject.SetActive(value: true);
		middlePropIsOpen = true;
		anim?.GetSequence("RewardShow").OnAnimationPlay((AnimationBuilder _) =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Reward_Scene");
		}).Play();
	}

	private void PlayCloseAnimation(UI_TYPE uiType = UI_TYPE.UI_NONE)
	{
		anim?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			onClose?.Invoke();
			onClose = null;
			gameObject.SetActive(value: false);
			middlePropIsOpen = false;
		}).Play();
	}

	private async UniTaskVoid InitItem(List<ItemAchieveinfo> info)
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_itemUnifierData);
		_itemUnifierData.Clear();
		if (info.Any())
		{
			foreach (ItemAchieveinfo item2 in info)
			{
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.itemId, item2.itemNum);
				_itemUnifierData.Add(item);
			}
		}
		_itemRect.ClearBag();
		_itemRect.AnimName = "RewardShow";
		_itemRect.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		_itemRect.ItemSource = _itemUnifierData;
		_itemRect.Station = Station;
		_itemRect.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
		_itemRect.ItemShowType = ItemUIComponentBase.InitType.BagItem;
		await UniTask.Delay(TimeSpan.FromSeconds(duration));
		UnInit();
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
	}

	public void UnInitialize()
	{
		if (middlePropIsOpen)
		{
			UnInit();
		}
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}
