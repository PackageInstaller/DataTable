using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class ActivityCenterView : BaseUIView<ActivityCenterViewInputController>
{
	public GameObject LeftPart;

	public RectTransform ActivityPanel;

	public ScrollRect TabScrollRect;

	public RectTransform TabContent;

	public ActivityCenterTab ActivityCenterTabAsset;

	public ActButton CloseButton;

	public GameObject GamepadRBGameobject;

	private Dictionary<int, ActivityCenterTab> _activityCenterTabDic;

	private Dictionary<int, IActivityCenterSubUIView> _subViewDic;

	private List<ActivityCenterData> _openingActivitys;

	private int _currentSelectActivityID;

	private int _lastSelectActivityID;

	private List<AssetLoadHandle> assetLoadHandles = new List<AssetLoadHandle>();

	private bool isExit;

	private float updateSafeTime = 5f;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_CloseActivityCenterView, CloseActivityCenterView);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_RefreshActivityCenter, RefreshActivityCenter);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_CloseActivityCenterView, CloseActivityCenterView);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_RefreshActivityCenter, RefreshActivityCenter);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectCallback();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectCallback();
		}).Play();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		if (_activityCenterTabDic == null)
		{
			_activityCenterTabDic = new Dictionary<int, ActivityCenterTab>();
		}
		if (_subViewDic == null)
		{
			_subViewDic = new Dictionary<int, IActivityCenterSubUIView>();
		}
		RefreshUI();
	}

	protected override void Init()
	{
		base.Init();
		isExit = false;
		LeftPart.SetActive(value: true);
		CloseButton.SetBtnClick(() =>
		{
			Exit();
		}, "event:/UI/Common/Return_Click");
		Singleton<RedDotManager>.instance.RefreshUnLockSystemRedDot(3001);
		Model<ActivityCenterModel>.Interface.RefreshRedDot();
		if (Time.unscaledTime - Model<ActivityCenterModel>.Interface.LastRefreshTime >= updateSafeTime)
		{
			Model<ActivityCenterModel>.Interface.ReqRefreshActivity();
		}
		SetTabInView(_currentSelectActivityID);
	}

	protected override void ReInit()
	{
		base.ReInit();
		LeftPart.SetActive(value: true);
		OnClickTabButtonHandle(GetSelectActivityID());
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void CloseComplete()
	{
		base.CloseComplete();
		if (_subViewDic.TryGetValue(_currentSelectActivityID, out var value))
		{
			value?.FocusOut();
			value?.gameObject.SetActive(value: false);
		}
		if (_activityCenterTabDic.TryGetValue(_currentSelectActivityID, out var value2))
		{
			value2.SetSelect(value: false);
		}
		_currentSelectActivityID = 0;
		_lastSelectActivityID = 0;
		Model<ActivityCenterModel>.Interface.SelectActivityId = -1;
		Model<ActivityCenterModel>.Interface.OpenActivityID = -1;
	}

	protected override void OnPopStack()
	{
		base.OnPopStack();
		if (_subViewDic.TryGetValue(_currentSelectActivityID, out var value))
		{
			value?.OnPopStack();
		}
	}

	protected override void OnPushStack()
	{
		base.OnPushStack();
		if (_subViewDic.TryGetValue(_currentSelectActivityID, out var value))
		{
			value?.OnPushStack();
		}
	}

	private void RefreshUI()
	{
		_openingActivitys = Model<ActivityCenterModel>.Interface.GetOpeningActivitys();
		if (_openingActivitys.Count <= 0)
		{
			Exit();
			return;
		}
		ClearFailureActivity();
		for (int i = 0; i < _openingActivitys.Count; i++)
		{
			int activityId = _openingActivitys[i].ActivityId;
			if (!_activityCenterTabDic.ContainsKey(activityId))
			{
				ActivityCenterTab activityCenterTab = LoadActivityCenterTab(activityId);
				activityCenterTab.transform.SetSiblingIndex(i);
				_activityCenterTabDic.Add(activityId, activityCenterTab);
			}
			if (_subViewDic.TryGetValue(activityId, out var value))
			{
				if (value == null)
				{
					_subViewDic[activityId] = CreateActivityPanel(_openingActivitys[i]);
				}
			}
			else
			{
				_subViewDic.Add(activityId, CreateActivityPanel(_openingActivitys[i]));
			}
		}
		if (_currentSelectActivityID > 0)
		{
			if (!Model<ActivityCenterModel>.Interface.GetActivityIsOpening(_currentSelectActivityID))
			{
				OnClickTabButtonHandle(_openingActivitys[0].ActivityId);
			}
		}
		else
		{
			OnClickTabButtonHandle(GetSelectActivityID());
		}
		PlayItemAnimation();
	}

	private void ClearFailureActivity()
	{
		List<int> list = _activityCenterTabDic.Keys.ToList();
		for (int i = 0; i < list.Count; i++)
		{
			int num = list[i];
			if (!Model<ActivityCenterModel>.Interface.GetActivityIsOpening(num))
			{
				if (num == _currentSelectActivityID)
				{
					_subViewDic[num].FocusOut();
				}
				Object.Destroy(_activityCenterTabDic[num].gameObject);
				Object.Destroy(_subViewDic[num].gameObject);
				_activityCenterTabDic.Remove(num);
				_subViewDic.Remove(num);
			}
		}
	}

	private ActivityCenterTab LoadActivityCenterTab(int activityId)
	{
		if (_activityCenterTabDic.TryGetValue(activityId, out var value) && value != null)
		{
			return null;
		}
		if (!RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value2))
		{
			return null;
		}
		ActivityCenterTab component = Object.Instantiate(ActivityCenterTabAsset, TabContent).GetComponent<ActivityCenterTab>();
		component.UpdateTabView(Station, value2);
		component.SetClickCallBack(OnClickTabButtonHandle);
		return component;
	}

	private void CloseActivityCenterView(BaseEventContent handle)
	{
		Model<ActivityCenterModel>.Interface.OpenActivityID = -1;
		Close();
	}

	private void RefreshActivityCenter(BaseEventContent handle)
	{
		RefreshUI();
	}

	private int GetSelectActivityID()
	{
		if (uiViewData is ActivityCenterViewData { ActivityId: var activityId })
		{
			for (int i = 0; i < _openingActivitys.Count; i++)
			{
				if (_openingActivitys[i].ActivityId == activityId)
				{
					return activityId;
				}
			}
		}
		if (Model<ActivityCenterModel>.Interface.OpenActivityID <= 0)
		{
			return _openingActivitys[0].ActivityId;
		}
		for (int j = 0; j < _openingActivitys.Count; j++)
		{
			if (_openingActivitys[j].ActivityId == Model<ActivityCenterModel>.Interface.OpenActivityID)
			{
				return _openingActivitys[j].ActivityId;
			}
		}
		return _currentSelectActivityID;
	}

	private void OnClickTabButtonHandle(int activityID)
	{
		if (_currentSelectActivityID != activityID)
		{
			_lastSelectActivityID = _currentSelectActivityID;
			_currentSelectActivityID = activityID;
			Model<ActivityCenterModel>.Interface.SelectActivityId = _currentSelectActivityID;
			if (_lastSelectActivityID != 0 && _activityCenterTabDic.ContainsKey(_lastSelectActivityID))
			{
				_activityCenterTabDic[_lastSelectActivityID].SetSelect(value: false);
			}
			_activityCenterTabDic[_currentSelectActivityID].SetSelect(value: true);
			OpenActivityPanel(_currentSelectActivityID);
			Model<ActivityCenterModel>.Interface.OpenActivityID = activityID;
			ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
			evt.activityId = activityID;
			evt.status = 1;
			evt.challengeGroupId = 0;
			evt.challengeId = 0;
			evt.isPopup = false;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	private void OpenActivityPanel(int activityID)
	{
		if (_subViewDic.TryGetValue(_lastSelectActivityID, out var value))
		{
			value?.FocusOut();
			value?.gameObject.SetActive(value: false);
		}
		if (!_subViewDic.ContainsKey(activityID))
		{
			IActivityCenterSubUIView value2 = CreateActivityPanel(_openingActivitys[activityID]);
			_subViewDic.Add(activityID, value2);
		}
		if (_subViewDic[activityID] == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Activity Open Fail! ActivityID：{activityID}");
			}
		}
		else
		{
			_subViewDic[activityID].gameObject.SetActive(value: true);
			_subViewDic[activityID].FocusIn();
		}
	}

	private IActivityCenterSubUIView CreateActivityPanel(ActivityCenterData activityCenterData)
	{
		if (activityCenterData == null)
		{
			return null;
		}
		ActivityData activityData = RuntimeConfigs.data.activityDatas[activityCenterData.ActivityId];
		string prefabPathByActivityType = Model<ActivityCenterModel>.Interface.GetPrefabPathByActivityType(activityData.activityType, activityData.prefabType);
		if (string.IsNullOrEmpty(prefabPathByActivityType))
		{
			return null;
		}
		AssetLoadHandle item = Station.Load<GameObject>(prefabPathByActivityType);
		GameObject gameObject = Object.Instantiate(item.AsGameObject(), ActivityPanel);
		gameObject.SetActive(value: false);
		assetLoadHandles.Add(item);
		IActivityCenterSubUIView component = gameObject.GetComponent<IActivityCenterSubUIView>();
		if (component == null)
		{
			return null;
		}
		component.ActivityCenterView = this;
		component.FocusOut();
		return component;
	}

	public void Exit()
	{
		if (!isExit)
		{
			isExit = true;
			Model<ActivityCenterModel>.Interface.OpenActivityID = -1;
			Close();
		}
	}

	public void Release()
	{
		for (int i = 0; i < assetLoadHandles.Count; i++)
		{
			if (AssetLoadHandleExtensions.IsValid(assetLoadHandles[i]))
			{
				Station.Release(assetLoadHandles[i]);
			}
		}
		assetLoadHandles.Clear();
	}

	private void SetTabInView(int activityId)
	{
		if (_activityCenterTabDic.TryGetValue(activityId, out var value) && value.TryGetComponent<SelectionUGUI>(out var component))
		{
			component.ScrollTargetToShow(component.transform);
		}
	}

	private async void PlayItemAnimation()
	{
		foreach (KeyValuePair<int, ActivityCenterTab> item in _activityCenterTabDic)
		{
			item.Value.PlayInitAnimation();
			await UniTask.Delay(3);
		}
	}

	public bool IsAllowChangeTab()
	{
		if (!LeftPart.activeSelf)
		{
			return false;
		}
		return true;
	}

	public void LeftShoulder()
	{
		if (!IsAllowChangeTab())
		{
			return;
		}
		List<ActivityCenterTab> list = ListPool<ActivityCenterTab>.Get();
		for (int i = 0; i < TabContent.childCount; i++)
		{
			ActivityCenterTab component = TabContent.GetChild(i).GetComponent<ActivityCenterTab>();
			if (!(component == null) && component.gameObject.activeSelf)
			{
				list.Add(component);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			if (list[j].ActivityId == _currentSelectActivityID)
			{
				if (j == 0)
				{
					return;
				}
				OnClickTabButtonHandle(list[j - 1].ActivityId);
				break;
			}
		}
		ListPool<ActivityCenterTab>.Release(list);
		TargetToShow(_activityCenterTabDic[_currentSelectActivityID].transform, TabScrollRect.viewport, TabScrollRect.content, vertical: true, horizontal: false, 20f);
	}

	public void RightShoulder()
	{
		if (!IsAllowChangeTab())
		{
			return;
		}
		List<ActivityCenterTab> list = ListPool<ActivityCenterTab>.Get();
		for (int i = 0; i < TabContent.childCount; i++)
		{
			ActivityCenterTab component = TabContent.GetChild(i).GetComponent<ActivityCenterTab>();
			if (!(component == null) && component.gameObject.activeSelf)
			{
				list.Add(component);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			if (list[j].ActivityId == _currentSelectActivityID)
			{
				if (j == list.Count - 1)
				{
					return;
				}
				OnClickTabButtonHandle(list[j + 1].ActivityId);
				break;
			}
		}
		ListPool<ActivityCenterTab>.Release(list);
		TargetToShow(_activityCenterTabDic[_currentSelectActivityID].transform, TabScrollRect.viewport, TabScrollRect.content, vertical: true, horizontal: false, 20f);
	}

	private void TargetToShow(Transform target, RectTransform viewport, RectTransform content, bool vertical, bool horizontal, float showOffset)
	{
		RectTransform component = target.GetComponent<RectTransform>();
		RectTransformUtility.ScreenPointToLocalPointInRectangle(viewport, RectTransformUtility.WorldToScreenPoint(null, target.position), null, out var localPoint);
		Vector2 zero = Vector2.zero;
		if (vertical)
		{
			float num = localPoint.y + component.rect.yMin;
			float num2 = localPoint.y + component.rect.yMax;
			if (num2 > viewport.rect.yMax)
			{
				zero.y = num2 - viewport.rect.yMax + showOffset;
			}
			else if (num < viewport.rect.yMin)
			{
				zero.y = num - viewport.rect.yMin - showOffset;
			}
		}
		if (horizontal)
		{
			float num3 = localPoint.x + component.rect.xMin;
			float num4 = localPoint.x + component.rect.xMax;
			if (num3 < viewport.rect.xMin)
			{
				zero.x = num3 - viewport.rect.xMin + showOffset;
			}
			else if (num4 > viewport.rect.xMax)
			{
				zero.x = num4 - viewport.rect.xMax - showOffset;
			}
		}
		content.anchoredPosition -= zero;
	}
}
