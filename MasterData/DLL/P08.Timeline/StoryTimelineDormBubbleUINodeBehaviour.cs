using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class StoryTimelineDormBubbleUINodeBehaviour : PlayableBehaviour
{
	public int content = 3;

	public string attachPath;

	public bool needClick;

	public bool canSkip;

	public int skipFrame;

	public string path = "UI/Dorm/SubtitleBubble";

	public string btn_path = "UI/Dorm/FullScreenBtn";

	private bool isRunning;

	private bool inited;

	private GameObject gameObjectUI;

	private Text textComp;

	private Canvas canvas;

	private Transform attachTrans;

	private Button button;

	public void SetWeight(float weight)
	{
		if (isRunning && weight == 0f)
		{
			isRunning = false;
			Exit();
		}
		if (!isRunning && weight == 1f)
		{
			isRunning = true;
			Enter();
		}
	}

	public void Enter()
	{
	}

	public void Exit()
	{
		inited = false;
		if (gameObjectUI != null)
		{
			PooledAsset.DestroyOrReturn(gameObjectUI);
		}
		if (button != null)
		{
			PooledAsset.DestroyOrReturn(button.gameObject);
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		SetContent(playable);
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		if (needClick)
		{
			(playable.GetGraph().GetResolver() as PlayableDirector).Pause();
		}
	}

	public void GetBubleUIGameObject()
	{
		if (!(gameObjectUI == null))
		{
			return;
		}
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIMain");
		if (gameObject == null)
		{
			return;
		}
		Transform transform = gameObject.transform;
		if (transform != null)
		{
			GameObject gameObject2 = Asset.InstantiateWithoutCache(path);
			if (gameObject2 == null)
			{
				return;
			}
			gameObject2.name = "Story_BubbleUI";
			gameObject2.transform.SetParent(transform.transform, worldPositionStays: false);
			gameObjectUI = gameObject2;
			textComp = gameObject2.transform.FindChildDeep("text")?.GetComponent<Text>();
			canvas = gameObject2.GetComponentInParent<Canvas>();
			if (needClick)
			{
				GameObject gameObject3 = Asset.InstantiateWithoutCache(btn_path);
				if (gameObject3 != null)
				{
					gameObject3.transform.SetParent(transform, worldPositionStays: false);
					gameObject3.name = "Story_FullScreenBtn";
					gameObject3.transform.SetSiblingIndex(-1);
					button = U3DUtil.Get<Button>(gameObject3);
				}
			}
		}
		else
		{
			Debug.LogWarning("can not found \"bubbleRoot\"");
		}
	}

	public void SetContent(Playable playable)
	{
		GetBubleUIGameObject();
		if (gameObjectUI == null)
		{
			return;
		}
		PlayableDirector pd = playable.GetGraph().GetResolver() as PlayableDirector;
		if (textComp != null)
		{
			textComp.text = WorldStateManager.GetTipsContent(content);
		}
		if (needClick && button != null)
		{
			button.onClick.RemoveAllListeners();
			button.onClick.AddListener(delegate
			{
				OnNextClick(pd);
			});
		}
		if (canSkip && button != null)
		{
			button.onClick.RemoveAllListeners();
			button.onClick.AddListener(delegate
			{
				OnSkipClick(pd);
			});
		}
		attachTrans = pd.transform.Find(attachPath);
		UpdateUIPos();
		inited = true;
	}

	public void OnNextClick(PlayableDirector pd)
	{
		needClick = false;
		button.onClick.RemoveAllListeners();
		pd.Resume();
	}

	public void OnSkipClick(PlayableDirector pd)
	{
		OnNextClick(pd);
		button.onClick.RemoveAllListeners();
		pd.time = (double)skipFrame / 30.0;
	}

	private void UpdateUIPos()
	{
		if (!(gameObjectUI == null))
		{
			Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, attachTrans.position);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(gameObjectUI.transform.parent as RectTransform, screenPoint, canvas.worldCamera, out var localPoint))
			{
				(gameObjectUI.transform as RectTransform).localPosition = localPoint;
			}
		}
	}
}
