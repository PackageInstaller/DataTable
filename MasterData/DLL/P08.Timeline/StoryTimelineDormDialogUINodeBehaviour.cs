using System;
using System.Collections.Generic;
using Dorm;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class StoryTimelineDormDialogUINodeBehaviour : PlayableBehaviour
{
	public string ui_path;

	public bool hideIcon;

	public string icon_path;

	public string talkId;

	public bool needClick;

	public bool canSkip;

	public int skipFrame;

	public bool showChoice;

	public List<string> choices;

	public bool effect;

	private bool isRunning;

	private bool hasClicked;

	private static GameObject ui_go;

	private Image icon_img;

	private Text name_txt;

	private Text content_txt;

	private UITypewriterEffect content_twe;

	private Button all_btn;

	private GameObject choice_parent_go;

	private List<Text> choices_txt;

	private List<GameObject> choices_go;

	private CanvasGroup ui_group;

	private PlayableDirector pd;

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

	private void Enter()
	{
		hasClicked = false;
	}

	private void Exit()
	{
		if (content_twe != null)
		{
			content_twe.percent = 1f;
			content_twe.SetDirty();
		}
		if (!(ui_go != null))
		{
			return;
		}
		if (!needClick && !showChoice)
		{
			DormStoryManager.instance.DestroyGo(ui_go);
		}
		else if (showChoice && choices != null)
		{
			choice_parent_go.SetActive(value: true);
			for (int i = 0; i < choices.Count; i++)
			{
				choices_go[i].SetActive(value: true);
				choices_txt[i].text = choices[i];
			}
			pd.Pause();
		}
		else if (needClick && !hasClicked)
		{
			pd.Pause();
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		pd = playable.GetGraph().GetResolver() as PlayableDirector;
		SetDialogContent();
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!(content_twe == null))
		{
			float num = (float)playable.GetTime();
			float num2 = (float)playable.GetDuration();
			float num3 = Mathf.Lerp(0f, 1f, num / num2);
			if (content_twe.percent < num3)
			{
				content_twe.percent = num3;
				content_twe.SetDirty();
			}
		}
	}

	private void SetDialogContent()
	{
		GetDialogUIGameObject();
		string text = "????";
		string text2 = "????";
		if (Application.isPlaying)
		{
			string text3 = LuaHelper.CallFunction("ConfigHelper_GetCfg", "StoryDormTalkCfg", int.Parse(talkId), "say")[0].ToString();
			text2 = LuaHelper.CallFunction("ConfigHelper_GetCfg", "StoryDormTalkCfg", int.Parse(talkId), "content")[0].ToString();
			text = LuaHelper.CallFunction("ConfigHelper_GetCfg", "StoryNameCfg", int.Parse(text3), "name")[0].ToString();
			if (text3 == "4" || string.IsNullOrEmpty(text3) || string.IsNullOrEmpty(text))
			{
				name_txt.transform.parent.gameObject.SetActive(value: false);
			}
			else
			{
				name_txt.transform.parent.gameObject.SetActive(value: true);
			}
		}
		if (hideIcon)
		{
			icon_img.transform.parent.gameObject.SetActive(value: false);
		}
		else
		{
			icon_img.transform.parent.gameObject.SetActive(value: true);
			if (icon_path.IsNotNullOrEmpty() && icon_img != null)
			{
				icon_img.sprite = AtlasManager.GetSpriteWithoutAtlas(icon_path);
			}
		}
		if (name_txt != null)
		{
			name_txt.text = text;
		}
		if (content_txt != null)
		{
			content_txt.text = text2;
		}
		if (content_twe != null)
		{
			content_twe.percent = 0f;
			content_twe.SetDirty();
		}
	}

	private void GetDialogUIGameObject()
	{
		if (ui_go != null)
		{
			DormStoryManager.instance.DestroyGo(ui_go);
			ui_go = null;
		}
		if (!(ui_go == null))
		{
			return;
		}
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIStory/Canvas");
		if (gameObject == null)
		{
			Debug.LogError("找不到 UICamera/Canvas/UIStory/Canvas");
			return;
		}
		GameObject gameObject2 = Asset.InstantiateWithoutCache(ui_path);
		if (gameObject2 == null)
		{
			return;
		}
		gameObject2.transform.SetParent(gameObject.transform, worldPositionStays: false);
		ui_go = gameObject2;
		icon_img = ui_go.transform.Find("panel/Canvas/dialog/bg_head/icon").gameObject.GetComponent<Image>();
		name_txt = ui_go.transform.Find("panel/Canvas/dialog/left_name/Text").gameObject.GetComponent<Text>();
		content_txt = ui_go.transform.Find("panel/Canvas/dialog/Panel/Viewport/Content/Text").gameObject.GetComponent<Text>();
		content_twe = content_txt.gameObject.GetComponent<UITypewriterEffect>();
		all_btn = ui_go.transform.Find("panel/Canvas/btn_all").gameObject.GetComponent<Button>();
		choice_parent_go = ui_go.transform.Find("choices").gameObject;
		ui_group = ui_go.GetComponent<CanvasGroup>();
		choices_go = new List<GameObject>();
		choices_txt = new List<Text>(3);
		int i;
		for (i = 1; i <= 3; i++)
		{
			choices_go.Add(choice_parent_go.transform.Find("list/item" + i).gameObject);
			choices_txt.Add(choices_go[i - 1].transform.Find("Text").gameObject.GetComponent<Text>());
			Button component = choices_go[i - 1].GetComponent<Button>();
			component.onClick.RemoveAllListeners();
			component.onClick.AddListener(delegate
			{
				OnChoiceClick(i - 1);
			});
			choices_go[i - 1].SetActive(value: false);
		}
		choice_parent_go.SetActive(value: false);
		all_btn.gameObject.SetActive(needClick);
		if (needClick)
		{
			all_btn.onClick.AddListener(delegate
			{
				OnNextClick();
			});
		}
		if (effect)
		{
			ui_go.transform.localScale = new Vector3(0.8f, 0.95f, 1f);
			LeanTween.scale(ui_go, Vector3.one, 0.2f);
			LTDescr lt = LeanTween.value(ui_go, 0f, 1f, 0.3f);
			lt.setOnUpdate(delegate(float f)
			{
				ui_group.alpha = f;
			});
			lt.setOnComplete((Action)delegate
			{
				LeanTween.cancel(ui_go);
				LeanTween.cancel(lt.id);
				ui_group.alpha = 1f;
			});
		}
	}

	private void OnNextClick()
	{
		if (pd != null)
		{
			pd.Resume();
		}
		if (content_twe != null && ui_group.alpha >= 1f && (!effect || !(content_twe.percent < 0.2f)) && !(content_twe.percent < 0.1f))
		{
			if (content_twe.percent < 1f)
			{
				content_twe.percent = 1f;
				content_twe.SetDirty();
			}
			else if (content_twe.percent >= 1f)
			{
				hasClicked = true;
				DormStoryManager.instance.DestroyGo(ui_go);
			}
		}
	}

	private void OnChoiceClick(int index)
	{
		if (pd != null)
		{
			pd.Resume();
		}
		DormStoryManager.instance.DestroyGo(ui_go);
	}
}
