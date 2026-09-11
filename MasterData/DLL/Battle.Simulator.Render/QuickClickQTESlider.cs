using System;
using NetProcol;
using UnityEngine;
using UnityEngine.UI;

public class QuickClickQTESlider : MonoBehaviour
{
	public Button button;

	public Slider slider;

	[SerializeField]
	private RectTransform m_HandleRect;

	public float m_startAngle;

	public float m_endAngle = 360f;

	[SerializeField]
	private float m_Radius;

	private float curValue;

	private float maxValue;

	private float consumeCD;

	private float consumeValue;

	private float resumeValue;

	private float resumeCD;

	public int id;

	private float lastClickTime;

	private float consumeCountDown;

	public float radius
	{
		get
		{
			return m_Radius;
		}
		set
		{
			m_Radius = value;
			UpdateVisuals();
		}
	}

	public void Init(int id, float initValue, float maxValue, float consumeCD, float consumeValue, float resumeValue, float resumeCD)
	{
		this.id = id;
		curValue = initValue;
		this.maxValue = maxValue;
		this.consumeCD = consumeCD;
		this.consumeValue = consumeValue;
		this.resumeValue = resumeValue;
		this.resumeCD = resumeCD;
		button.onClick.AddListener(OnButtonClick);
		base.enabled = true;
		base.gameObject.SetActive(value: true);
		lastClickTime = 0f;
		consumeCountDown = consumeCD;
	}

	public void ModifyParam(float consumeCD, float consumeValue, float resumeValue, float resumeCD)
	{
		this.consumeCD = consumeCD;
		this.consumeValue = consumeValue;
		this.resumeValue = resumeValue;
		this.resumeCD = resumeCD;
	}

	public void SetPos(Transform buttonParent, Vector2 buttonOffset, Transform sliderParent, Vector2 sliderOffset)
	{
		if (buttonParent != null)
		{
			Vector2 vector = ((button.transform as RectTransform).pivot - (buttonParent as RectTransform).pivot) * (buttonParent as RectTransform).sizeDelta;
			vector.x *= buttonParent.localScale.x;
			vector.y *= buttonParent.localScale.y;
			(button.transform as RectTransform).position = (buttonParent as RectTransform).position;
			(button.transform as RectTransform).anchoredPosition += vector + buttonOffset;
			(button.transform as RectTransform).localScale = buttonParent.localScale;
		}
		if (slider != null && sliderParent != null)
		{
			Vector2 vector2 = ((slider.transform as RectTransform).pivot - (sliderParent as RectTransform).pivot) * (sliderParent as RectTransform).sizeDelta;
			(slider.transform as RectTransform).position = (sliderParent as RectTransform).position;
			(slider.transform as RectTransform).anchoredPosition += vector2 + sliderOffset;
		}
	}

	public void Release()
	{
		button.onClick.RemoveAllListeners();
		base.enabled = false;
		base.gameObject.SetActive(value: false);
	}

	private void OnButtonClick()
	{
		if (lastClickTime > resumeCD)
		{
			curValue += resumeValue;
			lastClickTime = 0f;
		}
	}

	private void Update()
	{
		lastClickTime += Time.deltaTime;
		consumeCountDown -= Time.deltaTime;
		if (consumeCountDown < 0f)
		{
			consumeCountDown += consumeCD;
			curValue -= consumeValue;
		}
		if (curValue <= 0f)
		{
			FinishAction(flag: false);
			Release();
		}
		if (curValue >= maxValue)
		{
			FinishAction(flag: true);
			Release();
		}
		if (maxValue > 0f && slider != null)
		{
			slider.value = curValue / maxValue;
			UpdateVisuals();
		}
	}

	private Vector2 CalPos(float angle)
	{
		Vector2 zero = Vector2.zero;
		angle = MathF.PI / 180f * angle;
		zero.y = Mathf.Sin(angle) * m_Radius;
		zero.x = Mathf.Cos(angle) * m_Radius;
		return zero;
	}

	private void UpdateVisuals()
	{
		if (m_HandleRect != null && slider != null)
		{
			float angle = slider.value * (m_endAngle - m_startAngle) + m_startAngle;
			m_HandleRect.transform.localPosition = CalPos(angle);
		}
	}

	public void FinishAction(bool flag)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager != null)
		{
			NAgent playerAgent = agentManager.GetPlayerAgent();
			if (!(playerAgent == null))
			{
				QTECommand qTECommand = CommandFactory.Create(NetprotoOperationCode.CmdQte) as QTECommand;
				qTECommand.SetData(playerAgent.AgentID, flag ? QTEStatusType.Success : QTEStatusType.Failed);
				ClientSimulator.Instance.SendLocalCommand(qTECommand);
			}
		}
	}

	private void Test()
	{
		UpdateVisuals();
	}
}
