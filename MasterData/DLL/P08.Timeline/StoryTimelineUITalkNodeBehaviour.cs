using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class StoryTimelineUITalkNodeBehaviour : PlayableBehaviour
{
	public string path = "Widget/System/Story/StoryCharTalkUI";

	public string charIcon;

	public int context = 3;

	public int charName;

	public Vector2 pos;

	public bool needClick;

	public bool canSkip;

	public int skipFrame;

	private bool inited;

	private GameObject gameObjectUI;

	private GameObject textPanel;

	private Image icon;

	private Text contextText;

	private Text nameText;

	private Sprite iconSprite;

	private Button buttonSkip;

	private Button buttonNext;

	private Controller controller;

	private bool isRunning;

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
			gameObjectUI.SetActive(value: false);
		}
		if (textPanel != null)
		{
			textPanel.SetActive(value: false);
		}
		if (buttonNext != null)
		{
			buttonNext.gameObject.SetActive(value: false);
			buttonNext.onClick.RemoveAllListeners();
		}
		if (buttonSkip != null)
		{
			buttonSkip.gameObject.SetActive(value: false);
			buttonNext.onClick.RemoveAllListeners();
		}
	}

	public void GetUIGameObject()
	{
		if (gameObjectUI == null)
		{
			GameObject gameObject = GameObject.Find("UICamera/Canvas/UIMain");
			if (gameObject == null)
			{
				return;
			}
			Transform transform = gameObject.transform.Find("StoryCharTalkUI");
			if (transform == null)
			{
				GameObject gameObject2 = Asset.InstantiateWithoutCache(path);
				if (gameObject2 == null)
				{
					return;
				}
				gameObject2.name = "StoryCharTalkUI";
				gameObject2.transform.SetParent(gameObject.transform, worldPositionStays: false);
				gameObject2.transform.SetSiblingIndex(4);
				transform = gameObject2.transform;
			}
			gameObjectUI = transform.gameObject;
		}
		if (!(gameObjectUI == null))
		{
			if (textPanel == null)
			{
				textPanel = gameObjectUI.transform.Find("TextPanel").gameObject;
			}
			if (icon == null)
			{
				icon = gameObjectUI.transform.Find("TextPanel/profile/Image/head").GetComponent<Image>();
			}
			if (iconSprite == null && charIcon.IsNotNullOrEmpty() && Application.isPlaying)
			{
				iconSprite = AtlasManager.GetSpriteWithoutAtlas(charIcon);
			}
			if (contextText == null)
			{
				contextText = gameObjectUI.transform.Find("TextPanel/Scroll View/Viewport/Content/contextText").GetComponent<Text>();
			}
			if (nameText == null)
			{
				nameText = gameObjectUI.transform.Find("TextPanel/nameText").GetComponent<Text>();
			}
			if (buttonSkip == null)
			{
				buttonSkip = gameObjectUI.transform.Find("ButtonSkip").GetComponent<Button>();
			}
			if (buttonNext == null)
			{
				buttonNext = gameObjectUI.transform.Find("ButtonNext").GetComponent<Button>();
			}
			if (controller == null && textPanel != null)
			{
				controller = textPanel.GetComponent<Controller>();
			}
		}
	}

	public void SetContent(Playable playable)
	{
		if (inited)
		{
			return;
		}
		if (gameObjectUI == null)
		{
			GetUIGameObject();
		}
		if (gameObjectUI == null)
		{
			return;
		}
		if (!gameObjectUI.activeSelf)
		{
			gameObjectUI.SetActive(value: true);
		}
		string newValue = (NScene.GetCurrentScene() as BattleScene)?.nickName;
		if (textPanel != null)
		{
			textPanel.transform.localPosition = pos;
			textPanel.SetActive(value: true);
		}
		if (icon != null && iconSprite != null)
		{
			icon.sprite = iconSprite;
		}
		if (contextText != null)
		{
			string tipsContent = WorldStateManager.GetTipsContent(context);
			contextText.text = tipsContent.Replace("#{nickname}#", newValue);
		}
		bool flag = false;
		if (nameText != null)
		{
			string tipsContent2 = WorldStateManager.GetTipsContent(charName);
			nameText.text = tipsContent2.Replace("#{nickname}#", newValue);
			flag = !string.IsNullOrEmpty(tipsContent2);
		}
		if (controller != null)
		{
			if ((iconSprite != null) & flag)
			{
				controller.SetSelectedState("profile");
			}
			else if ((iconSprite == null) & flag)
			{
				controller.SetSelectedState("noprofile");
			}
			else if (iconSprite != null && !flag)
			{
				controller.SetSelectedState("noname");
			}
			else
			{
				controller.SetSelectedState("nonanone");
			}
		}
		if (buttonNext != null && needClick)
		{
			buttonNext.gameObject.SetActive(value: true);
			buttonNext.onClick.RemoveAllListeners();
			buttonNext.onClick.AddListener(delegate
			{
				NextAction(playable);
			});
		}
		if (buttonSkip != null && canSkip)
		{
			buttonSkip.onClick.RemoveAllListeners();
			buttonSkip.gameObject.SetActive(value: true);
			buttonSkip.onClick.AddListener(delegate
			{
				SkipAction(playable);
			});
		}
		inited = true;
	}

	public void NextAction(Playable playable)
	{
		needClick = false;
		buttonNext.onClick.RemoveAllListeners();
		(playable.GetGraph().GetResolver() as PlayableDirector).Resume();
	}

	public void SkipAction(Playable playable)
	{
		NextAction(playable);
		buttonSkip.onClick.RemoveAllListeners();
		(playable.GetGraph().GetResolver() as PlayableDirector).time = (double)skipFrame / 30.0;
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
}
