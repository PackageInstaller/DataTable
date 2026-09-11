using System.Collections.Generic;
using NetProcol;
using UnityEngine;
using UnityEngine.UI;

public class TalkButton : MonoBehaviour
{
	private struct SignalExchangeStruct
	{
		public int entityID;

		public int contentID;
	}

	public TalkContentButton tmp;

	public GameObject panel;

	public CanvasGroup canvasGroup;

	public float leantweenTime = 0.17f;

	public Vector3 startPos = new Vector3(17f, 27f, 41f);

	public Vector3 targetPos = new Vector3(-39f, 27f, 0f);

	public Button button;

	public float minTime = 3f;

	public float maxTime = 6f;

	public Image cdMask;

	public Text cdText;

	public float cd = 9f;

	private float cdCur;

	private Stack<TalkContentButton> pools = new Stack<TalkContentButton>();

	private Stack<TalkContentButton> running = new Stack<TalkContentButton>();

	private bool hideFlag = true;

	public Image showImage;

	public Image hideImage;

	public TalkTextPanel selfTalkPanel;

	private Queue<SignalExchangeStruct> queue = new Queue<SignalExchangeStruct>();

	private List<float> queueTime = new List<float>();

	private void Awake()
	{
		tmp.gameObject.SetActive(value: false);
		Hide();
		selfTalkPanel.HideText();
		button.onClick.AddListener(delegate
		{
			if (hideFlag)
			{
				Show();
			}
			else
			{
				Hide();
			}
		});
	}

	public TalkContentButton Get()
	{
		if (pools.Count > 0)
		{
			return pools.Pop();
		}
		return Object.Instantiate(tmp.gameObject, tmp.transform.parent).GetComponent<TalkContentButton>();
	}

	public void Init(List<int> contentList)
	{
		while (running.Count > 0)
		{
			TalkContentButton talkContentButton = running.Pop();
			talkContentButton.gameObject.SetActive(value: false);
			pools.Push(talkContentButton);
		}
		for (int i = 0; i < contentList.Count; i++)
		{
			TalkContentButton talkContentButton2 = Get();
			if (talkContentButton2 != null)
			{
				talkContentButton2.gameObject.SetActive(value: true);
				talkContentButton2.Init(contentList[i]);
				running.Push(talkContentButton2);
			}
			else
			{
				Debug.LogError("出错");
			}
		}
	}

	public void Hide()
	{
		LeanTween.cancel(panel);
		LeanTween.scaleX(panel, 0f, leantweenTime);
		hideFlag = true;
		showImage.enabled = true;
		hideImage.enabled = false;
	}

	public void Show()
	{
		if (!(cdCur > 0f))
		{
			LeanTween.cancel(panel);
			canvasGroup.alpha = 0f;
			LeanTween.alphaCanvas(canvasGroup, 1f, leantweenTime);
			panel.transform.localScale = Vector3.one;
			panel.transform.localPosition = startPos;
			LeanTween.moveLocal(panel, targetPos, leantweenTime);
			hideFlag = false;
			showImage.enabled = false;
			hideImage.enabled = true;
		}
	}

	public void Click(int id)
	{
		SignalExchangeCommand signalExchangeCommand = CommandFactory.Create(NetprotoOperationCode.CmdSignalExchange) as SignalExchangeCommand;
		signalExchangeCommand.SetData(AgentManager.GetAgentManager().mPlayerAgentID, id);
		ClientSimulator.Instance.SendLocalCommand(signalExchangeCommand);
		selfTalkPanel.ShowText(WorldStateManager.GetTipsContent(id), 3000f);
		cdCur = cd;
		Hide();
	}

	public void OnSignalExchangeEvent(int entityID, int contentID)
	{
		queue.Enqueue(new SignalExchangeStruct
		{
			entityID = entityID,
			contentID = contentID
		});
		queueTime.Add(0f);
	}

	public void Update()
	{
		if (cdCur > 0f)
		{
			if (!cdMask.gameObject.activeSelf)
			{
				cdMask.enabled = true;
				cdMask.gameObject.SetActive(value: true);
			}
			if (!cdText.enabled)
			{
				cdText.enabled = true;
			}
			cdMask.fillAmount = cdCur / cd;
			cdText.text = Mathf.CeilToInt(cdCur).ToString();
			cdCur -= Time.deltaTime;
		}
		else
		{
			if (cdMask.gameObject.activeSelf)
			{
				cdMask.enabled = false;
				cdMask.gameObject.SetActive(value: false);
			}
			if (cdText.enabled)
			{
				cdText.enabled = false;
			}
		}
		if (queue.Count <= 0)
		{
			return;
		}
		SignalExchangeStruct signalExchangeStruct = queue.Peek();
		AgentHuman agentHuman = AgentManager.GetAgentManager().GetAgent(signalExchangeStruct.entityID) as AgentHuman;
		if (agentHuman == null || agentHuman.RoleTalkPanel == null)
		{
			queue.Dequeue();
			queueTime.RemoveAt(0);
			return;
		}
		if (queueTime[0] == 0f)
		{
			agentHuman.RoleTalkPanel.m_talkTextPanel.ShowText(WorldStateManager.GetTipsContent(signalExchangeStruct.contentID), (int)(maxTime * 1000f));
		}
		queueTime[0] += Time.deltaTime;
		if ((queueTime[0] > minTime && queue.Count > 1) || queueTime[0] > maxTime)
		{
			agentHuman.RoleTalkPanel.m_talkTextPanel.HideText();
			queue.Dequeue();
			queueTime.RemoveAt(0);
		}
	}
}
