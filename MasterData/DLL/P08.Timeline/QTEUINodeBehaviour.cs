using UnityEngine;
using UnityEngine.Playables;
using YS.CustomTimelineTrack;

public abstract class QTEUINodeBehaviour : PlayableBehaviour
{
	protected P08StoryQTEUI _ui;

	public QTEConditionType conditionType;

	public string path;

	public string parent;

	public Vector2 uiPos;

	public QTEUIAnchor uiAnchor;

	protected bool _hasCreatedUI => _ui != null;

	public override void OnGraphStart(Playable playable)
	{
		base.OnGraphStart(playable);
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!_hasCreatedUI)
		{
			CreateUI();
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (Application.isPlaying)
		{
			float num = (float)playable.GetTime();
			float num2 = (float)playable.GetDuration();
			if (num > num2 - info.deltaTime)
			{
				OnTimeout();
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (Mathf.Approximately((float)playable.GetTime(), (float)playable.GetDuration()))
		{
			OnTimeout();
		}
	}

	public virtual void CreateUI()
	{
		if (Asset.pool == null)
		{
			Asset.Initialize();
		}
		GameObject gameObject = GameObject.Find(parent);
		if (!(gameObject == null))
		{
			GameObject gameObject2 = Asset.InstantiateWithoutCache(path, gameObject.transform);
			if (gameObject2 != null)
			{
				_ui = gameObject2.GetComponent<P08StoryQTEUI>();
			}
			RegisterUIEvent();
			QTEContext.GetInstance().Reset();
			QTEContext.GetInstance().status = EQTEStatus.Running;
			QTEContext.GetInstance().type = conditionType;
			UpdateUIPos();
		}
	}

	public virtual void RegisterUIEvent()
	{
	}

	public virtual void UpdateUIPos()
	{
		if (!_hasCreatedUI)
		{
			return;
		}
		RectTransform rectTransform = _ui.transform as RectTransform;
		if (rectTransform != null)
		{
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

	public virtual void OnSuccess()
	{
		if (_hasCreatedUI)
		{
			_ui.Dispose(1f);
			_ui = null;
		}
		QTEContext.GetInstance().status = EQTEStatus.Success;
		WorldStateManager.GetWorldStateManager()?.mQteFinshEvent(obj: true);
	}

	public virtual void OnFailed()
	{
		if (_hasCreatedUI)
		{
			_ui.Dispose(1f);
			_ui = null;
		}
		QTEContext.GetInstance().status = EQTEStatus.Failed;
		WorldStateManager.GetWorldStateManager()?.mQteFinshEvent(obj: false);
	}

	public virtual void OnTimeout()
	{
		if (_hasCreatedUI)
		{
			_ui.Dispose(1f);
			_ui = null;
		}
		QTEContext.GetInstance().status = EQTEStatus.Timeout;
		WorldStateManager.GetWorldStateManager()?.mQteFinshEvent(obj: false);
	}
}
