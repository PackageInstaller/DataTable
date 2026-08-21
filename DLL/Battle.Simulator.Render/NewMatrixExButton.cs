using System;
using NetProcol;
using UnityEngine;
using UnityEngine.UI;

public class NewMatrixExButton : P08EXButton
{
	public ButtonType buttonType;

	public Image abilityIcon;

	public Image cdMaskImage;

	public Text cdText;

	public Text useCount;

	public Image uniqueBar;

	public GameObject disable;

	public GameObject effect;

	public Transform scaleConstraint;

	private bool useableCD = true;

	private bool useableEnergy;

	private void Awake()
	{
		actionOnPointerDown = (Action)Delegate.Combine(actionOnPointerDown, new Action(OnPointerDown));
		actionOnPointerUp = (Action)Delegate.Combine(actionOnPointerUp, new Action(OnPointerUp));
	}

	private void OnDestroy()
	{
		actionOnPointerDown = (Action)Delegate.Remove(actionOnPointerDown, new Action(OnPointerDown));
		actionOnPointerUp = (Action)Delegate.Combine(actionOnPointerUp, new Action(OnPointerUp));
	}

	public void SendCommand(bool isPress)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager != null)
		{
			NAgent playerAgent = agentManager.GetPlayerAgent();
			if (!(playerAgent == null))
			{
				StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
				startMeleeCommand.SetData(playerAgent.AgentID, (int)buttonType, isPress);
				ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
			}
		}
	}

	public void OnPointerDown()
	{
		SendCommand(isPress: true);
	}

	public void OnPointerUp()
	{
		SendCommand(isPress: false);
	}

	private void Update()
	{
		if (scaleConstraint != null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				Transform transform = battleScene.battlePanelGameObject.transform;
				Vector3 lossyScale = base.transform.lossyScale;
				if (lossyScale.x == 0f)
				{
					lossyScale.x = 1f;
				}
				if (lossyScale.y == 0f)
				{
					lossyScale.y = 1f;
				}
				if (lossyScale.z == 0f)
				{
					lossyScale.z = 1f;
				}
				if (transform != null)
				{
					Vector3 lossyScale2 = transform.lossyScale;
					scaleConstraint.localScale = new Vector3(lossyScale2.x / lossyScale.x, lossyScale2.x / lossyScale.y, lossyScale2.x / lossyScale.z);
				}
			}
			else
			{
				Debug.LogError("scene == null");
			}
		}
		else
		{
			Debug.LogError("scaleConstraint == null");
		}
	}

	public void SetIcon(string atlas, string name)
	{
		if (!(abilityIcon == null))
		{
			abilityIcon.sprite = AtlasManager.GetSprite(atlas, name);
		}
	}

	public void SetCD(int cur, int max)
	{
		if (cur > 0)
		{
			useableCD = false;
		}
		else
		{
			useableCD = true;
		}
		if (null != cdMaskImage)
		{
			if (max != 0)
			{
				cdMaskImage.fillAmount = (float)cur / (float)max;
			}
			else
			{
				cdMaskImage.fillAmount = 0f;
			}
			if (cur <= 0)
			{
				cdMaskImage.enabled = false;
			}
			else
			{
				cdMaskImage.enabled = true;
			}
		}
		if (null != cdText)
		{
			if (cur == 0)
			{
				cdText.text = string.Empty;
			}
			else
			{
				int num = Mathf.CeilToInt((float)cur / 1000f);
				if (num < CommonString.Numbers.Length)
				{
					cdText.text = CommonString.Numbers[num];
				}
				else
				{
					cdText.text = num.ToString();
				}
			}
			if (cur <= 0)
			{
				cdText.enabled = false;
			}
			else
			{
				cdText.enabled = true;
			}
		}
		UpdateUseable();
	}

	private void UpdateUseable()
	{
		int num;
		if (useableEnergy)
		{
			num = (useableCD ? 1 : 0);
			if (num != 0)
			{
				effect.SetActive(value: true);
				if (disable != null)
				{
					disable.SetActive(value: false);
				}
				goto IL_0062;
			}
		}
		else
		{
			num = 0;
		}
		effect.SetActive(value: false);
		if (disable != null)
		{
			disable.SetActive(value: true);
		}
		goto IL_0062;
		IL_0062:
		if (num != 0)
		{
			Color color = abilityIcon.color;
			color.a = 1f;
			abilityIcon.color = color;
		}
		else
		{
			Color color2 = abilityIcon.color;
			color2.a = 8f / 85f;
			abilityIcon.color = color2;
		}
	}

	public void SetEnergyBar(int cur, int max)
	{
		if (cur >= max)
		{
			useableEnergy = true;
		}
		else
		{
			useableEnergy = false;
		}
		if (useCount != null)
		{
			useCount.text = CommonString.Numbers[cur / max];
			if (cur <= max)
			{
				useCount.enabled = false;
			}
			else
			{
				useCount.enabled = true;
			}
		}
		if (uniqueBar != null)
		{
			if (max != 0)
			{
				if (cur > max)
				{
					cur %= max;
				}
				uniqueBar.fillAmount = (float)cur / (float)max;
			}
			else
			{
				uniqueBar.fillAmount = 0f;
			}
		}
		UpdateUseable();
	}
}
