using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class QTEUINode_Press_Behaviour : QTEUINodeBehaviour
{
	public float timeLimit;

	public int style;

	public AnimationCurve growCurve;

	public AnimationCurve falloffCurve;

	public string iconImagePath;

	public bool useAtlas;

	public string atlasName;

	public string iconName;

	public int textId;

	public List<OnceProgressActiveEvent> progressActiveEvent;

	public List<OnceProgressDisableEvent> progressDisableEvent;

	private PlayableDirector _pd;

	private float prev_percent;

	public override void OnGraphStart(Playable playable)
	{
		base.OnGraphStart(playable);
		_pd = playable.GetGraph().GetResolver() as PlayableDirector;
	}

	public override void CreateUI()
	{
		base.CreateUI();
		if (_ui != null)
		{
			GameObject goFromCfg = _ui.GetGoFromCfg("_text");
			if (goFromCfg != null)
			{
				goFromCfg.SetActive(textId != 0);
				goFromCfg.GetComponent<Text>().text = WorldStateManager.GetTipsContent(textId);
			}
		}
		prev_percent = 0f;
	}

	public override void UpdateUIPos()
	{
		if (!base._hasCreatedUI)
		{
			return;
		}
		GameObject goFromCfg = _ui.GetGoFromCfg("_slider");
		if (goFromCfg != null)
		{
			RectTransform rectTransform = goFromCfg.transform as RectTransform;
			if (uiAnchor == QTEUIAnchor.Center)
			{
				Vector2 anchorMin = (rectTransform.anchorMax = Vector2.one * 0.5f);
				rectTransform.anchorMin = anchorMin;
			}
			else if (uiAnchor == QTEUIAnchor.LeftBottom)
			{
				Vector2 anchorMin = (rectTransform.anchorMax = Vector2.zero);
				rectTransform.anchorMin = anchorMin;
			}
			else if (uiAnchor == QTEUIAnchor.RightBottom)
			{
				Vector2 anchorMin = (rectTransform.anchorMax = Vector2.right);
				rectTransform.anchorMin = anchorMin;
			}
			else if (uiAnchor == QTEUIAnchor.RightUp)
			{
				Vector2 anchorMin = (rectTransform.anchorMax = Vector2.one);
				rectTransform.anchorMin = anchorMin;
			}
			else if (uiAnchor == QTEUIAnchor.LeftUp)
			{
				Vector2 anchorMin = (rectTransform.anchorMax = Vector2.up);
				rectTransform.anchorMin = anchorMin;
			}
			rectTransform.anchoredPosition = uiPos;
		}
	}

	public override void RegisterUIEvent()
	{
		base.RegisterUIEvent();
		P08StoryQTEPress p08StoryQTEPress = _ui as P08StoryQTEPress;
		if (!(p08StoryQTEPress == null))
		{
			p08StoryQTEPress.Init(timeLimit, style, growCurve, falloffCurve, delegate
			{
				OnSuccess();
			}, delegate
			{
				OnFailed();
			});
			p08StoryQTEPress.RegistProgreeUpdateEvent(OnProgress);
		}
	}

	private void OnProgress(float percent)
	{
		OnProgressActive(percent);
		OnProgressDisable(percent);
		prev_percent = percent;
	}

	private void OnProgressActive(float percent)
	{
		if (progressActiveEvent.Count == 0)
		{
			return;
		}
		for (int i = 0; i < progressActiveEvent.Count; i++)
		{
			OnceProgressActiveEvent onceProgressActiveEvent = progressActiveEvent[i];
			bool flag = QTEUINode.VerifyCompare(percent, onceProgressActiveEvent.percent, onceProgressActiveEvent.compareType);
			if (onceProgressActiveEvent.compareType == ECompareType.Equal)
			{
				flag = (onceProgressActiveEvent.percent > prev_percent && onceProgressActiveEvent.percent <= percent) || (onceProgressActiveEvent.percent <= prev_percent && onceProgressActiveEvent.percent > percent);
			}
			if (!flag || string.IsNullOrEmpty(onceProgressActiveEvent.goName) || (!onceProgressActiveEvent.isRepeat && onceProgressActiveEvent.hasTrigger))
			{
				continue;
			}
			if (_pd != null)
			{
				Transform transform = _pd.transform.Find(onceProgressActiveEvent.goName);
				if (transform != null)
				{
					PlayableDirector component = transform.gameObject.GetComponent<PlayableDirector>();
					if (onceProgressActiveEvent.resetActive)
					{
						transform.gameObject.SetActive(value: false);
						if (component != null)
						{
							component.Stop();
						}
					}
					transform.gameObject.SetActive(value: true);
				}
			}
			onceProgressActiveEvent.hasTrigger = true;
		}
	}

	private void OnProgressDisable(float percent)
	{
		if (progressDisableEvent.Count == 0)
		{
			return;
		}
		for (int i = 0; i < progressDisableEvent.Count; i++)
		{
			OnceProgressDisableEvent onceProgressDisableEvent = progressDisableEvent[i];
			bool flag = QTEUINode.VerifyCompare(percent, onceProgressDisableEvent.percent, onceProgressDisableEvent.compareType);
			if (onceProgressDisableEvent.compareType == ECompareType.Equal)
			{
				flag = (onceProgressDisableEvent.percent > prev_percent && onceProgressDisableEvent.percent <= percent) || (onceProgressDisableEvent.percent <= prev_percent && onceProgressDisableEvent.percent > percent);
			}
			if (!flag || string.IsNullOrEmpty(onceProgressDisableEvent.goName) || (!onceProgressDisableEvent.isRepeat && onceProgressDisableEvent.hasTrigger))
			{
				continue;
			}
			if (_pd != null)
			{
				Transform transform = _pd.transform.Find(onceProgressDisableEvent.goName);
				if (transform != null)
				{
					transform.gameObject.SetActive(value: false);
				}
			}
			onceProgressDisableEvent.hasTrigger = true;
		}
	}
}
