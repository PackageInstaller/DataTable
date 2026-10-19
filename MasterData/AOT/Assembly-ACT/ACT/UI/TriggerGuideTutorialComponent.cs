using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class TriggerGuideTutorialComponent : BaseUIComponent, IBattleMainComponent
{
	private static TriggerGuideTutorialComponent s_active;

	private static readonly List<TutorialComponentData> s_pendingTutorials = new List<TutorialComponentData>();

	[SerializeField]
	private ActButton _btn;

	[Space]
	public TutorialInfoTip info;

	public BetterAnimation betterAnimation;

	private Vector3 _originalPos;

	private Vector2 _positionOffset;

	private int _curTriggerTutorialId;

	private float _countdownDuration;

	private float _elapsedCountdownTime;

	private bool _isRunning;

	private MonoBattleMainBaseView _view;

	public bool isRunning => _isRunning;

	public void Show(TutorialComponentData data, ImageAssetStation station, Action onShowFail, Vector2 cpPosOffset = default(Vector2))
	{
		try
		{
			_curTriggerTutorialId = data.TutorialId;
			GuideTutorial data2 = CoreUtils.GetData(data.TutorialId, RuntimeConfigs.data.guideTutorials);
			if (data2 != null)
			{
				info.Init(data2, station);
				_originalPos = transform.localPosition;
				_positionOffset = cpPosOffset;
				MonoAsideView monoAsideView = _view?.asideUIComp;
				if (cpPosOffset != default(Vector2) && monoAsideView != null && monoAsideView.IsAsideOpen)
				{
					SetLocalPositionIfChanged(asideIsActive: true);
				}
				gameObject.SetActive(value: true);
				betterAnimation?.GetSequence("Show").Play();
				Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnAsideViewStateChange, OnAsideViewStateChange);
				onClose = () =>
				{
					transform.localPosition = _originalPos;
					Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.LowerMiddle);
				};
				_isRunning = true;
				_countdownDuration = data.CdTime;
				_elapsedCountdownTime = 0f;
				UpdateProgress(1f);
			}
		}
		catch (Exception value)
		{
			onShowFail?.Invoke();
			gameObject.SetActive(value: false);
			Console.WriteLine(value);
			throw;
		}
	}

	private void OnAsideViewStateChange(BaseEventContent obj)
	{
		if (obj is GameStateChange gameStateChange)
		{
			SetLocalPositionIfChanged(gameStateChange.IsInState);
		}
	}

	private void SetLocalPositionIfChanged(bool asideIsActive)
	{
		Vector3 localPosition = transform.localPosition;
		Vector3 vector = new Vector3(asideIsActive ? (_originalPos.x + _positionOffset.x) : _originalPos.x, asideIsActive ? (_originalPos.y + _positionOffset.y) : _originalPos.y, localPosition.z);
		if (localPosition != vector)
		{
			transform.localPosition = vector;
		}
	}

	private void UpdateProgress(float progress)
	{
		if (!gameObject.activeInHierarchy)
		{
			gameObject.SetActive(value: true);
		}
		info.SetProgress(progress);
	}

	private void Update()
	{
		if (_isRunning)
		{
			_elapsedCountdownTime += GameManager.timeSystem.GetCurrentDeltaTime();
			if (_elapsedCountdownTime >= _countdownDuration)
			{
				UpdateProgress(0f);
				Close();
			}
			else
			{
				UpdateProgress(1f - _elapsedCountdownTime / _countdownDuration);
			}
		}
	}

	private void Close()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnAsideViewStateChange, OnAsideViewStateChange);
		_isRunning = false;
		betterAnimation?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			_curTriggerTutorialId = 0;
			onClose?.Invoke();
			onClose = null;
			gameObject.SetActive(value: false);
		}).Play();
	}

	private void Refresh()
	{
		_isRunning = false;
		betterAnimation?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			_curTriggerTutorialId = 0;
			onClose?.Invoke();
			onClose = null;
		}).Play();
	}

	public void OpenGraphicGuideView()
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Tutorial))
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_GRAPHICGUIDE, new GraphicGuideViewData
			{
				jumpGuideId = _curTriggerTutorialId
			}).Forget();
			Close();
			return;
		}
		ItemKv itemKv = CoreUtils.GetData(1019, RuntimeConfigs.data.systemOpens).preconditionParam[0];
		int desId = CoreUtils.GetData(itemKv.id, RuntimeConfigs.data.preconditions).desId;
		int localizeId = CoreUtils.GetData(itemKv.count, RuntimeConfigs.data.missionBases).name;
		string localizeString = LocalizationUtility.GetLocalizeString("shortcommon", localizeId);
		Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
		{
			tableName = LocalizationUtility.localizeTableName_longcommon,
			localizeId = desId,
			variableList = new List<string> { localizeString }
		});
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		_view = view;
		_btn.SetBtnClick(OpenGraphicGuideView);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Trigger_Tutorial, PopUpTutorialEntry);
		s_active = this;
		FlushPendingTutorials();
	}

	public static bool EnqueueIfListenerNotReady(int tutorialId, float duration)
	{
		if (s_active != null)
		{
			return false;
		}
		s_pendingTutorials.Add(new TutorialComponentData
		{
			TutorialId = tutorialId,
			CdTime = duration
		});
		return true;
	}

	private void FlushPendingTutorials()
	{
		if (s_pendingTutorials.Count != 0)
		{
			for (int i = 0; i < s_pendingTutorials.Count; i++)
			{
				TutorialComponentData tutorialComponentData = s_pendingTutorials[i];
				PopUpTutorialEntry(tutorialComponentData.TutorialId, tutorialComponentData.CdTime);
			}
			s_pendingTutorials.Clear();
		}
	}

	private void PopUpTutorialEntry(BaseEventContent obj)
	{
		if (obj is TriggerGuideTutorial triggerGuideTutorial)
		{
			PopUpTutorialEntry(triggerGuideTutorial.triggerTutorialId, triggerGuideTutorial.duration);
		}
	}

	private void PopUpTutorialEntry(int tutorialId, float duration)
	{
		if ((bool)_view)
		{
			TutorialComponentData data = new TutorialComponentData
			{
				TutorialId = tutorialId,
				CdTime = duration
			};
			if (_isRunning)
			{
				Refresh();
			}
			Model<BattleMainModel>.Interface.HudPositionUIEnqueue(UIPosition.LowerMiddle, HudComponentType.TutorialTimerTip, data, 15f, 1, ignorePriorityRule: false, clearQueueByCpTypeBeforeEnter: false, new Vector2(0f, 74f));
		}
	}

	public void UnInitialize()
	{
		if (s_active == this)
		{
			s_active = null;
		}
		_view = null;
		_curTriggerTutorialId = 0;
		_isRunning = false;
		if (gameObject.activeInHierarchy)
		{
			gameObject.SetActive(value: false);
		}
		onClose?.Invoke();
		onClose = null;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Trigger_Tutorial, PopUpTutorialEntry);
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
