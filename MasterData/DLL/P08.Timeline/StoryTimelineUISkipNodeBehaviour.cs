using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class StoryTimelineUISkipNodeBehaviour : PlayableBehaviour
{
	public string path = "Widget/System/Story/StorySkip3UI";

	private GameObject gameObjectUI;

	private Button skipButton;

	public int skipFrame;

	private bool inited;

	public GameObject GetUIGameObject()
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas");
		if (gameObject == null)
		{
			return null;
		}
		Transform transform = gameObject.transform.Find("UITips");
		if (transform == null)
		{
			return null;
		}
		Transform transform2 = transform.Find("StorySkip");
		if (transform2 == null)
		{
			GameObject gameObject2 = Asset.InstantiateWithoutCache(path);
			if (gameObject2 == null)
			{
				return null;
			}
			gameObject2.name = "StorySkip";
			gameObject2.transform.SetParent(transform, worldPositionStays: false);
			transform2 = gameObject2.transform;
		}
		return transform2.gameObject;
	}

	public void SetContent(Playable playable)
	{
		if (inited)
		{
			return;
		}
		if (gameObjectUI == null)
		{
			gameObjectUI = GetUIGameObject();
		}
		if (gameObjectUI == null)
		{
			return;
		}
		if (!gameObjectUI.activeSelf)
		{
			gameObjectUI.SetActive(value: true);
		}
		Transform transform = gameObjectUI.transform;
		if (skipButton == null)
		{
			Transform transform2 = transform.Find("SkipButton");
			if (transform2 != null)
			{
				skipButton = transform2.GetComponent<Button>();
			}
		}
		if (skipButton != null)
		{
			skipButton.onClick.RemoveAllListeners();
			skipButton.gameObject.SetActive(value: true);
			skipButton.onClick.AddListener(delegate
			{
				SkipAction(playable);
			});
		}
		inited = true;
	}

	public void SkipAction(Playable playable)
	{
		skipButton.onClick.RemoveAllListeners();
		(playable.GetGraph().GetResolver() as PlayableDirector).time = (double)skipFrame / 30.0;
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		SetContent(playable);
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		inited = false;
		if (skipButton != null)
		{
			skipButton.onClick.RemoveAllListeners();
			skipButton.gameObject.SetActive(value: false);
		}
	}
}
