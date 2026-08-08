using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class StoryTimelineUINodeBehaviour : PlayableBehaviour
{
	public UINodeType type;

	public int mainTitle = 1;

	public int subTitle = 2;

	public int context = 3;

	public int fontSize = 42;

	public TextAnchor alignment;

	public bool canSkip = true;

	public bool disableUIWhenFinished;

	public bool destroyUI;

	public string path = "";

	public AnimationCurve contextCurve;

	public AnimationCurve maskCurve;

	private GameObject gameObjectUI;

	private GameObject titleGameObject;

	private Text text;

	private UITypewriterEffect typewriter;

	private Button skipButton;

	private Image mask;

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
		Transform transform2 = transform.Find("StoryText");
		if (transform2 == null)
		{
			GameObject gameObject2 = Asset.InstantiateWithoutCache(path);
			if (gameObject2 == null)
			{
				return null;
			}
			gameObject2.name = "StoryText";
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
		if (titleGameObject == null)
		{
			titleGameObject = transform.Find("Title").gameObject;
		}
		if (text == null)
		{
			text = transform.Find("Text").GetComponent<Text>();
			typewriter = text.gameObject.GetComponent<UITypewriterEffect>();
			typewriter.percent = 0f;
		}
		if (type == UINodeType.Text)
		{
			if (text != null)
			{
				text.gameObject.SetActive(value: true);
				text.alignment = alignment;
				text.fontSize = fontSize;
				text.text = WorldStateManager.GetTipsContent(context);
			}
			if (titleGameObject != null)
			{
				titleGameObject.SetActive(value: false);
			}
		}
		else if (type == UINodeType.Title)
		{
			if (titleGameObject != null)
			{
				titleGameObject.SetActive(value: true);
				titleGameObject.transform.Find("Main").GetComponent<Text>().fontSize = fontSize;
				titleGameObject.transform.Find("Sub").GetComponent<Text>().fontSize = fontSize;
				titleGameObject.transform.Find("Main").GetComponent<Text>().text = WorldStateManager.GetTipsContent(mainTitle);
				titleGameObject.transform.Find("Sub").GetComponent<Text>().text = WorldStateManager.GetTipsContent(subTitle);
			}
			if (text != null)
			{
				text.gameObject.SetActive(value: false);
			}
		}
		skipButton = transform.Find("Button").GetComponent<Button>();
		skipButton.onClick.RemoveAllListeners();
		if (canSkip)
		{
			skipButton.gameObject.SetActive(value: true);
			skipButton.onClick.AddListener(delegate
			{
				double time = playable.GetTime();
				double duration = playable.GetDuration();
				PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
				if (playableDirector != null)
				{
					playableDirector.time += duration - time;
				}
			});
		}
		else
		{
			skipButton.gameObject.SetActive(value: false);
		}
		if (mask == null)
		{
			mask = transform.Find("Mask").GetComponent<Image>();
		}
		inited = true;
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
		}
		if (gameObjectUI != null && disableUIWhenFinished)
		{
			gameObjectUI.SetActive(value: false);
		}
		if (typewriter != null)
		{
			typewriter.percent = 1f;
		}
	}

	public override void OnGraphStop(Playable playable)
	{
		if (destroyUI && gameObjectUI != null)
		{
			UnityEngine.Object.Destroy(gameObjectUI);
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		float num = (float)playable.GetTime();
		float num2 = (float)playable.GetDuration();
		if (type == UINodeType.Text && typewriter != null && contextCurve != null)
		{
			float num3 = (float)Math.Round(contextCurve.Evaluate(num / num2), 3);
			if (num3 != typewriter.percent)
			{
				typewriter.percent = num3;
				typewriter.SetDirty();
			}
		}
		if (mask != null && maskCurve != null)
		{
			float a = (float)Math.Round(maskCurve.Evaluate(num / num2), 3);
			Color color = mask.color;
			color.a = a;
			mask.color = color;
		}
	}
}
