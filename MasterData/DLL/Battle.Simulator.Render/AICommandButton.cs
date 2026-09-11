using System;
using NetProcol;
using UnityEngine;
using UnityEngine.UI;

public class AICommandButton : MonoBehaviour
{
	private Button currentCommandButton;

	private Image currentCommandImage;

	private Transform currentCommandHitButton;

	private Image currentCommandHitImage;

	private Text currentCommandHitText;

	private Button setFireButton;

	private Image setFireImage;

	private Button setButton;

	private Image setImage;

	private Button spreadButton;

	private Image spreadImage;

	private Button coverButton;

	private Image coverImage;

	private Transform commands;

	private void Awake()
	{
		currentCommandButton = base.transform.Find("Button").GetComponent<Button>();
		currentCommandImage = base.transform.Find("Button/image").GetComponent<Image>();
		currentCommandHitButton = base.transform.Find("Button/ButtonCurrent");
		currentCommandHitImage = base.transform.Find("Button/ButtonCurrent/image").GetComponent<Image>();
		currentCommandHitText = base.transform.Find("Button/ButtonCurrent/text").GetComponent<Text>();
		commands = base.transform.Find("Commands");
		setFireButton = base.transform.Find("Commands/Button").GetComponent<Button>();
		setFireImage = base.transform.Find("Commands/Button/image").GetComponent<Image>();
		setButton = base.transform.Find("Commands/Button (1)").GetComponent<Button>();
		setImage = base.transform.Find("Commands/Button (1)/image").GetComponent<Image>();
		spreadButton = base.transform.Find("Commands/Button (2)").GetComponent<Button>();
		spreadImage = base.transform.Find("Commands/Button (2)/image").GetComponent<Image>();
		coverButton = base.transform.Find("Commands/Button (3)").GetComponent<Button>();
		coverImage = base.transform.Find("Commands/Button (3)/image").GetComponent<Image>();
		currentCommandButton.onClick.AddListener(CurrentCommandButtonClick);
		setFireButton.onClick.AddListener(SetFireButtonClick);
		setButton.onClick.AddListener(SetButtonClick);
		spreadButton.onClick.AddListener(SpreadButtonCllick);
		coverButton.onClick.AddListener(CoverButtonClick);
	}

	public void CurrentCommandButtonClick()
	{
		LeanTween.moveLocalX(currentCommandButton.gameObject, -350f, 0.1f);
		LeanTween.moveLocalX(commands.gameObject, -7.25f, 0.1f).setDelay(0.05f);
		LeanTween.moveLocalX(currentCommandButton.gameObject, 0f, 0.1f).setDelay(2.5f);
		LeanTween.moveLocalX(commands.gameObject, -214.55f, 0.1f).setDelay(2.55f);
	}

	public void SetFireButtonClick()
	{
		currentCommandHitButton.gameObject.SetActive(value: true);
		currentCommandHitImage.sprite = setFireImage.sprite;
		currentCommandImage.sprite = setFireImage.sprite;
		currentCommandHitText.text = "集 火";
		LeanTween.moveLocalX(currentCommandButton.gameObject, 0f, 0.1f);
		LeanTween.moveLocalX(commands.gameObject, -214.55f, 0.1f);
		LeanTween.moveLocalY(currentCommandHitButton.gameObject, 60f, 0.1f).setDelay(2f);
		LeanTween.color(currentCommandHitButton as RectTransform, Color.clear, 0.1f).setDelay(2f).setOnComplete((Action)delegate
		{
			currentCommandHitButton.gameObject.SetActive(value: false);
			currentCommandHitButton.localPosition = currentCommandHitButton.localPosition.NewY(0f);
			LeanTween.color(currentCommandHitButton as RectTransform, Color.white, 0f);
		});
		AICommond aICommond = CommandFactory.Create(NetprotoOperationCode.CmdAiCommand) as AICommond;
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent();
		if (playerAgent != null)
		{
			_ = playerAgent.Blackboard;
			aICommond.SetData(playerAgent.AgentID, AICommandType.FocusOnMyTarget);
			ClientSimulator.Instance.SendLocalCommand(aICommond);
		}
	}

	public void SetButtonClick()
	{
		currentCommandHitButton.gameObject.SetActive(value: true);
		currentCommandHitImage.sprite = setImage.sprite;
		currentCommandImage.sprite = setImage.sprite;
		currentCommandHitText.text = "集 合";
		LeanTween.moveLocalX(currentCommandButton.gameObject, 0f, 0.1f);
		LeanTween.moveLocalX(commands.gameObject, -214.55f, 0.1f);
		LeanTween.moveLocalY(currentCommandHitButton.gameObject, 60f, 0.1f).setDelay(2f);
		LeanTween.color(currentCommandHitButton as RectTransform, Color.clear, 0.1f).setDelay(2f).setOnComplete((Action)delegate
		{
			currentCommandHitButton.gameObject.SetActive(value: false);
			currentCommandHitButton.localPosition = currentCommandHitButton.localPosition.NewY(0f);
			LeanTween.color(currentCommandHitButton as RectTransform, Color.white, 0f);
		});
		AICommond aICommond = CommandFactory.Create(NetprotoOperationCode.CmdAiCommand) as AICommond;
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent();
		if (playerAgent != null)
		{
			_ = playerAgent.Blackboard;
			aICommond.SetData(playerAgent.AgentID, AICommandType.Follow);
			ClientSimulator.Instance.SendLocalCommand(aICommond);
		}
	}

	public void SpreadButtonCllick()
	{
		currentCommandHitButton.gameObject.SetActive(value: true);
		currentCommandHitImage.sprite = spreadImage.sprite;
		currentCommandImage.sprite = spreadImage.sprite;
		currentCommandHitText.text = "解 散";
		LeanTween.moveLocalX(currentCommandButton.gameObject, 0f, 0.1f);
		LeanTween.moveLocalX(commands.gameObject, -214.55f, 0.1f);
		LeanTween.moveLocalY(currentCommandHitButton.gameObject, 60f, 0.1f).setDelay(2f);
		LeanTween.color(currentCommandHitButton as RectTransform, Color.clear, 0.1f).setDelay(2f).setOnComplete((Action)delegate
		{
			currentCommandHitButton.gameObject.SetActive(value: false);
			currentCommandHitButton.localPosition = currentCommandHitButton.localPosition.NewY(0f);
			LeanTween.color(currentCommandHitButton as RectTransform, Color.white, 0f);
		});
		AICommond aICommond = CommandFactory.Create(NetprotoOperationCode.CmdAiCommand) as AICommond;
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent();
		if (playerAgent != null)
		{
			_ = playerAgent.Blackboard;
			aICommond.SetData(playerAgent.AgentID, AICommandType.Dispersed);
			ClientSimulator.Instance.SendLocalCommand(aICommond);
		}
	}

	public void CoverButtonClick()
	{
		currentCommandHitButton.gameObject.SetActive(value: true);
		currentCommandHitImage.sprite = coverImage.sprite;
		currentCommandImage.sprite = coverImage.sprite;
		currentCommandHitText.text = "掩 护";
		LeanTween.moveLocalX(currentCommandButton.gameObject, 0f, 0.1f);
		LeanTween.moveLocalX(commands.gameObject, -214.55f, 0.1f);
		LeanTween.moveLocalY(currentCommandHitButton.gameObject, 60f, 0.1f).setDelay(2f);
		LeanTween.color(currentCommandHitButton as RectTransform, Color.clear, 0.1f).setDelay(2f).setOnComplete((Action)delegate
		{
			currentCommandHitButton.gameObject.SetActive(value: false);
			currentCommandHitButton.localPosition = currentCommandHitButton.localPosition.NewY(0f);
			LeanTween.color(currentCommandHitButton as RectTransform, Color.white, 0f);
		});
		AICommond aICommond = CommandFactory.Create(NetprotoOperationCode.CmdAiCommand) as AICommond;
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent();
		if (playerAgent != null)
		{
			_ = playerAgent.Blackboard;
			aICommond.SetData(playerAgent.AgentID, AICommandType.Help);
			ClientSimulator.Instance.SendLocalCommand(aICommond);
		}
	}
}
