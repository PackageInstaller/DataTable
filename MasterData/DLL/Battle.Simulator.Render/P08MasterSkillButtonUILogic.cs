using Config;
using UnityEngine;
using UnityEngine.UI;

public class P08MasterSkillButtonUILogic : P08ButtonUILogic, IButtonUILogic
{
	public Image uniqueBar;

	public GameObject qteEffect;

	public Image masterIcon;

	public TuneIndicatorHelper tuneIndicator;

	private bool _lastActiveStatus;

	private int _currentEnergy;

	private int _maxEnergy;

	private bool useableEnergy;

	private bool _useable = true;

	private P08UISwitch _uiSwitch;

	private bool _currentActive = true;

	public P08MasterSkillButtonUILogic(Image abilityIcon, Text cdText, Image cdMaskImage, GameObject qteEffect, Image uniqueBar, GameObject disableGo, P08UISwitch uiSwitch, Image masterIcon)
	{
		base.abilityIcon = abilityIcon;
		base.cdText = cdText;
		base.cdMaskImage = cdMaskImage;
		this.qteEffect = qteEffect;
		this.uniqueBar = uniqueBar;
		base.disableGo = disableGo;
		ChargingController = null;
		_lastActiveStatus = false;
		_uiSwitch = uiSwitch;
		this.masterIcon = masterIcon;
	}

	public void UpdateUIContent(NAgent agent)
	{
		if (!(agent == null))
		{
			OnUpdate(agent);
		}
	}

	private void SetQTEBar(int current, int max)
	{
		if (current == 0 && max == 0)
		{
			useableEnergy = true;
			return;
		}
		max = ((max <= 0) ? 1 : max);
		float b = (float)current * 1f / (float)max;
		if (_currentEnergy != current || _maxEnergy != max || !Mathf.Approximately(uniqueBar.fillAmount, b))
		{
			_currentEnergy = current;
			_maxEnergy = max;
			if (uniqueBar != null)
			{
				uniqueBar.fillAmount = (float)current * 1f / (float)max;
			}
			if (current >= max)
			{
				useableEnergy = true;
			}
			else
			{
				useableEnergy = false;
			}
		}
	}

	private void SetEnable()
	{
		bool flag = useableCD && useableEnergy;
		if (flag == _useable && (qteEffect == null || qteEffect.activeSelf == flag))
		{
			return;
		}
		_useable = flag;
		if (qteEffect != null)
		{
			qteEffect.SetActive(flag);
		}
		if (abilityIcon == null)
		{
			return;
		}
		if (flag)
		{
			Color color = abilityIcon.color;
			color.a = 1f;
			abilityIcon.color = color;
			if (masterIcon != null)
			{
				masterIcon.color = color;
			}
		}
		else
		{
			Color color2 = abilityIcon.color;
			color2.a = 8f / 85f;
			abilityIcon.color = color2;
			if (masterIcon != null)
			{
				masterIcon.color = color2;
			}
		}
	}

	private void OnUpdate(NAgent agent)
	{
		BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
		if (bBHumanoid == null || bBHumanoid.m_NextSimFrameData == null)
		{
			return;
		}
		int mEntityMasterSkillMaxCD = bBHumanoid.m_NextSimFrameData.mEntityMasterSkillMaxCD;
		int mEntityMasterSkillMaxValue = bBHumanoid.m_NextSimFrameData.mEntityMasterSkillMaxValue;
		int mEntityMasterSkillConfigID = bBHumanoid.m_NextSimFrameData.mEntityMasterSkillConfigID;
		if ((mEntityMasterSkillMaxCD == 0 && mEntityMasterSkillMaxValue == 0) || mEntityMasterSkillConfigID == 0)
		{
			if (_uiSwitch != null && _currentActive)
			{
				_uiSwitch.SetActive(isActive: false, BattleUIElementActiveChangeReason.OtherReason1);
				_currentActive = false;
			}
			return;
		}
		if (_uiSwitch != null && !_currentActive)
		{
			_currentActive = true;
			_uiSwitch.SetActive(isActive: true, BattleUIElementActiveChangeReason.OtherReason1);
		}
		if (!_lastActiveStatus)
		{
			_lastActiveStatus = true;
			InitQteIcon(mEntityMasterSkillConfigID);
		}
		int mEntityMasterSkillCurCD = bBHumanoid.m_NextSimFrameData.mEntityMasterSkillCurCD;
		int mEntityMasterSkillCurValue = bBHumanoid.m_NextSimFrameData.mEntityMasterSkillCurValue;
		SetCD(mEntityMasterSkillCurCD, mEntityMasterSkillMaxCD, 0);
		SetQTEBar(mEntityMasterSkillCurValue, mEntityMasterSkillMaxValue);
		SetEnable();
		if (tuneIndicator != null && tuneIndicator.OnUpdate(_useable) && qteEffect != null && qteEffect.activeSelf)
		{
			qteEffect.SetActive(value: false);
		}
	}

	public void InitQteIcon(int configID)
	{
		if (abilityIcon == null)
		{
			return;
		}
		ConfigHelper.GetInstance().TryGetConfig<ai_chip>(configID, out var config);
		if (config != null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				abilityIcon.sprite = AtlasManager.GetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" + battleScene.roleSkinID);
			}
			else
			{
				abilityIcon.sprite = AtlasManager.GetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" + config.PictureId);
			}
			if (masterIcon != null && battleScene != null)
			{
				masterIcon.sprite = AtlasManager.GetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" + battleScene.masterSkinID);
			}
		}
	}
}
