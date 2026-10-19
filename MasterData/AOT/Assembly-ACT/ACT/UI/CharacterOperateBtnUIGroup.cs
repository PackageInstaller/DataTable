using System.Collections.Generic;
using ACT.Model;
using Bamboo.AssetField;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CharacterOperateBtnUIGroup : UIBehaviour
{
	private List<AssetLoadHandle> _btnAssetLoadHandles = new List<AssetLoadHandle>();

	private JumpBtn _jumpBtn;

	private DodgeBtn _dodgeBtn;

	private AttackBtn _attackBtn;

	private SpAttackBtn _spAttackBtn;

	private UltraBtn _ultraBtn;

	private EnergyBar _energyBar;

	private AssistComp _assistComp;

	private SpecialEnergyBar _specialEnergyBar;

	private Entity _entity;

	private bool _show;

	private ImageAssetStation _imageStation;

	private CustomUIScheme _scheme => Model<CustomUIModel>.Interface.GetCurScheme();

	public EnergyBar EnergyBar => _energyBar;

	public SpecialEnergyBar SpecialEnergyBar => _specialEnergyBar;

	protected override void OnDestroy()
	{
		ReleaseBtnAssetLoadHandles();
		base.OnDestroy();
	}

	public void Init(CharacterOperateBtnGroupData groupData, CharacterOperateBtnConfig config, Transform parent, Entity entity)
	{
		_entity = entity;
		gameObject.AddComponent<RectTransform>();
		transform.SetParent(parent);
		RectTransform obj = transform as RectTransform;
		obj.offsetMin = Vector2.zero;
		obj.offsetMax = Vector2.zero;
		obj.localPosition = Vector3.zero;
		obj.anchorMin = Vector2.zero;
		obj.anchorMax = Vector2.one;
		obj.pivot = 0.5f * Vector2.one;
		obj.localScale = Vector3.one;
		if (_imageStation == null)
		{
			_imageStation = ImageManager.instance.GetAssetStation();
		}
		CreateJumpBtn(config.jumpBtnConfig.btnPrefab, groupData.JumpBtnData, entity);
		CreateDodgeBtn(config.dodgeBtnConfig.btnPrefab, groupData.DodgeBtnData, entity);
		CreateAttackBtn(config.attackBtnConfig.btnPrefab, groupData.AttackBtnData, entity);
		CreateSpAttackBtn(config.spAttackBtnConfig.btnPrefab, groupData.SpAttackBtnData, entity);
		CreateUltraBtn(config.ultraBtnConfig.btnPrefab, groupData.UltraBtnData, entity);
		CreateEnergyBar(config.energyBarConfig.barPrefab, groupData.EnergyBarData, entity);
		CreateSpecialEnergyBar(config.specialEnergyBarConfig.barPrefab, groupData.SpecialEnergyBarData, entity);
		CreateAssist(config.assistConfig.assistPrefab, groupData.AssistData, entity);
		_show = false;
		HideImply();
	}

	public void UnInit()
	{
		if (_jumpBtn != null)
		{
			_jumpBtn.UnInit();
		}
		if (_dodgeBtn != null)
		{
			_dodgeBtn.UnInit();
		}
		if (_attackBtn != null)
		{
			_attackBtn.UnInit();
		}
		if (_spAttackBtn != null)
		{
			_spAttackBtn.UnInit();
		}
		if (_ultraBtn != null)
		{
			_ultraBtn.UnInit();
		}
		if (_assistComp != null)
		{
			_assistComp.UnInit();
		}
		if (_energyBar != null)
		{
			_energyBar.UnInit();
		}
		if (_specialEnergyBar != null)
		{
			_specialEnergyBar.UnInit();
		}
		if (_imageStation != null)
		{
			ImageManager.instance.UnloadAssetStation(_imageStation);
			_imageStation = null;
		}
		ReleaseBtnAssetLoadHandles();
		Object.Destroy(gameObject);
	}

	private void ReleaseBtnAssetLoadHandles()
	{
		for (int i = 0; i < _btnAssetLoadHandles.Count; i++)
		{
			if (AssetLoadHandleExtensions.IsValid(_btnAssetLoadHandles[i]))
			{
				AssetStationManager.BattleStation.Release(_btnAssetLoadHandles[i]);
			}
		}
		_btnAssetLoadHandles.Clear();
	}

	private void CreateJumpBtn(YooAssetReference template, JumpBtnData jumpBtnData, Entity entity)
	{
		if (template == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("JumpBtn的预制体没有配置,检查配置");
			}
			return;
		}
		AssetLoadHandle item = AssetStationManager.BattleStation.Instantiate(template, transform);
		_btnAssetLoadHandles.Add(item);
		_jumpBtn = item.AsGameObject().GetComponent<JumpBtn>();
		_jumpBtn.Init(jumpBtnData, _scheme.JumpBtnTransform, _imageStation);
		bool clientModule = Model<ClientModuleModel>.Interface.GetClientModule(ClientModuleModel.ClientModuleEnum.Input, 9);
		OnUpdateBtnActive(CustomUICompType.JumpBtn, clientModule);
	}

	private void CreateDodgeBtn(YooAssetReference template, DodgeBtnData dodgeBtnData, Entity entity)
	{
		if (template == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("DodgeBtn的预制体没有配置,检查配置");
			}
			return;
		}
		AssetLoadHandle item = AssetStationManager.BattleStation.Instantiate(template, transform);
		_btnAssetLoadHandles.Add(item);
		_dodgeBtn = item.AsGameObject().GetComponent<DodgeBtn>();
		_dodgeBtn.Init(dodgeBtnData, _scheme.DodgeBtnTransform, _imageStation);
		bool clientModule = Model<ClientModuleModel>.Interface.GetClientModule(ClientModuleModel.ClientModuleEnum.Input, 8);
		OnUpdateBtnActive(CustomUICompType.DodgeBtn, clientModule);
	}

	private void CreateAttackBtn(YooAssetReference template, AttackBtnData attackBtnData, Entity entity)
	{
		if (template == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("AttackBtn的预制体没有配置,检查配置");
			}
			return;
		}
		AssetLoadHandle item = AssetStationManager.BattleStation.Instantiate(template, transform);
		_btnAssetLoadHandles.Add(item);
		_attackBtn = item.AsGameObject().GetComponent<AttackBtn>();
		_attackBtn.Init(attackBtnData, _scheme.AttackBtnTransform, _imageStation);
		bool clientModule = Model<ClientModuleModel>.Interface.GetClientModule(ClientModuleModel.ClientModuleEnum.Input, 0);
		OnUpdateBtnActive(CustomUICompType.AttackBtn, clientModule);
	}

	private void CreateSpAttackBtn(YooAssetReference template, SpAttackBtnData spAttackBtnData, Entity entity)
	{
		if (template == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("spAttackBtn的预制体没有配置,检查配置");
			}
			return;
		}
		AssetLoadHandle item = AssetStationManager.BattleStation.Instantiate(template, transform);
		_btnAssetLoadHandles.Add(item);
		_spAttackBtn = item.AsGameObject().GetComponent<SpAttackBtn>();
		_spAttackBtn.Init(spAttackBtnData, _scheme.SpAttackBtnTransform, _imageStation);
		bool clientModule = Model<ClientModuleModel>.Interface.GetClientModule(ClientModuleModel.ClientModuleEnum.Input, 1);
		OnUpdateBtnActive(CustomUICompType.SpAttackBtn, clientModule);
	}

	private void CreateUltraBtn(YooAssetReference template, UltraBtnData ultraBtnData, Entity entity)
	{
		if (template == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("UltraBtn的预制体没有配置,检查配置");
			}
			return;
		}
		AssetLoadHandle item = AssetStationManager.BattleStation.Instantiate(template, transform);
		_btnAssetLoadHandles.Add(item);
		_ultraBtn = item.AsGameObject().GetComponent<UltraBtn>();
		_ultraBtn.Init(ultraBtnData, _scheme.UltraBtnTransform, _imageStation);
		bool clientModule = Model<ClientModuleModel>.Interface.GetClientModule(ClientModuleModel.ClientModuleEnum.Input, 7);
		OnUpdateBtnActive(CustomUICompType.UltraBtn, clientModule);
	}

	private void CreateEnergyBar(YooAssetReference template, EnergyBarData energyBarData, Entity entity)
	{
		if (template == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("EnergyBar的预制体没有配置,检查配置");
			}
		}
		else
		{
			AssetLoadHandle item = AssetStationManager.BattleStation.Instantiate(template, transform);
			_btnAssetLoadHandles.Add(item);
			_energyBar = item.AsGameObject().GetComponent<EnergyBar>();
			_energyBar.Init(energyBarData, _scheme.EnergyBarTransform, entity);
		}
	}

	private void CreateSpecialEnergyBar(YooAssetReference template, SpecialEnergyBarData specialEnergyBarData, Entity entity)
	{
		if (template == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("SpecialEnergyBar的预制体没有配置,检查配置");
			}
		}
		else
		{
			AssetLoadHandle item = AssetStationManager.BattleStation.Instantiate(template, transform);
			_btnAssetLoadHandles.Add(item);
			_specialEnergyBar = item.AsGameObject().GetComponent<SpecialEnergyBar>();
			_specialEnergyBar.Init(specialEnergyBarData, _scheme.SpecialEnergyBarTransform, entity);
		}
	}

	private void CreateAssist(YooAssetReference template, AssistData assistData, Entity entity)
	{
		if (template == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Assist的预制体没有配置,检查配置");
			}
		}
		else
		{
			AssetLoadHandle item = AssetStationManager.BattleStation.Instantiate(template, transform);
			_btnAssetLoadHandles.Add(item);
			_assistComp = item.AsGameObject().GetComponent<AssistComp>();
			_assistComp.Init(assistData, _scheme.AssistTransform, entity);
		}
	}

	public void OnUpdateScheme(CustomUIScheme scheme)
	{
		if (_jumpBtn != null)
		{
			_jumpBtn.OnUpdateScheme(scheme.JumpBtnTransform);
		}
		if (_dodgeBtn != null)
		{
			_dodgeBtn.OnUpdateScheme(scheme.DodgeBtnTransform);
		}
		if (_attackBtn != null)
		{
			_attackBtn.OnUpdateScheme(scheme.AttackBtnTransform);
		}
		if (_spAttackBtn != null)
		{
			_spAttackBtn.OnUpdateScheme(scheme.SpAttackBtnTransform);
		}
		if (_ultraBtn != null)
		{
			_ultraBtn.OnUpdateScheme(scheme.UltraBtnTransform);
		}
		if (_energyBar != null)
		{
			_energyBar.OnUpdateScheme(scheme.EnergyBarTransform);
		}
		if (_assistComp != null)
		{
			_assistComp.OnUpdateScheme(scheme.AssistTransform);
		}
		if (_specialEnergyBar != null)
		{
			_specialEnergyBar.OnUpdateScheme(scheme.SpecialEnergyBarTransform);
		}
	}

	public void Show()
	{
		if (!_show)
		{
			ShowImply();
			_show = true;
		}
	}

	private void ShowImply()
	{
		transform.localPosition = Vector3.zero;
		SetOperateBtnUIParticleActive(active: true);
	}

	public void Hide()
	{
		if (_show)
		{
			HideImply();
			_show = false;
		}
	}

	private void HideImply()
	{
		SetOperateBtnUIParticleActive(active: false);
		transform.localPosition = new Vector3(100000f, 100000f, 0f);
	}

	private void SetOperateBtnUIParticleActive(bool active)
	{
		if (_jumpBtn != null)
		{
			_jumpBtn.SetUIParticleActive(active);
		}
		if (_dodgeBtn != null)
		{
			_dodgeBtn.SetUIParticleActive(active);
		}
		if (_attackBtn != null)
		{
			_attackBtn.SetUIParticleActive(active);
		}
		if (_spAttackBtn != null)
		{
			_spAttackBtn.SetUIParticleActive(active);
		}
		if (_ultraBtn != null)
		{
			_ultraBtn.SetUIParticleActive(active);
		}
	}

	public void OnUpdateBtnActive(CustomUICompType customUICompType, bool active)
	{
		switch (customUICompType)
		{
		case CustomUICompType.JumpBtn:
			_jumpBtn.SetActive(active);
			break;
		case CustomUICompType.DodgeBtn:
			_dodgeBtn.SetActive(active);
			break;
		case CustomUICompType.AttackBtn:
			_attackBtn.SetActive(active);
			break;
		case CustomUICompType.SpAttackBtn:
			_spAttackBtn.SetActive(active);
			break;
		case CustomUICompType.UltraBtn:
			_ultraBtn.SetActive(active);
			break;
		case CustomUICompType.EnergyBar:
			_energyBar.SetActive(active);
			break;
		case CustomUICompType.Assist:
			_assistComp.SetActive(active);
			break;
		case CustomUICompType.BloodBar:
		case CustomUICompType.BuffList:
			break;
		}
	}

	public void OnUpdateBtnEffectActive(CustomUICompType customUICompType, bool active)
	{
		switch (customUICompType)
		{
		case CustomUICompType.JumpBtn:
			_jumpBtn.SetGuideEffActive(active);
			break;
		case CustomUICompType.DodgeBtn:
			_dodgeBtn.SetGuideEffActive(active);
			break;
		case CustomUICompType.AttackBtn:
			_attackBtn.SetGuideEffActive(active);
			break;
		case CustomUICompType.SpAttackBtn:
			_spAttackBtn.SetGuideEffActive(active);
			break;
		case CustomUICompType.UltraBtn:
			_ultraBtn.SetGuideEffActive(active);
			break;
		case CustomUICompType.BloodBar:
		case CustomUICompType.EnergyBar:
		case CustomUICompType.BuffList:
		case CustomUICompType.Assist:
			break;
		}
	}

	public void OnPromptBtn(CustomUICompType customUICompType)
	{
		switch (customUICompType)
		{
		case CustomUICompType.JumpBtn:
			_jumpBtn.OnPrompt();
			break;
		case CustomUICompType.DodgeBtn:
			_dodgeBtn.OnPrompt();
			break;
		case CustomUICompType.AttackBtn:
			_attackBtn.OnPrompt();
			break;
		case CustomUICompType.SpAttackBtn:
			_spAttackBtn.OnPrompt();
			break;
		case CustomUICompType.UltraBtn:
			_ultraBtn.OnPrompt();
			break;
		}
	}

	public void SetConfigDisableState(CustomUICompType customUICompType, bool enterDisableState)
	{
		switch (customUICompType)
		{
		case CustomUICompType.JumpBtn:
			SetConfigDisableState(_jumpBtn, enterDisableState);
			break;
		case CustomUICompType.DodgeBtn:
			SetConfigDisableState(_dodgeBtn, enterDisableState);
			break;
		case CustomUICompType.AttackBtn:
			SetConfigDisableState(_attackBtn, enterDisableState);
			break;
		case CustomUICompType.SpAttackBtn:
			SetConfigDisableState(_spAttackBtn, enterDisableState);
			break;
		case CustomUICompType.UltraBtn:
			SetConfigDisableState(_ultraBtn, enterDisableState);
			break;
		}
	}

	private void SetConfigDisableState(OperateBtn operateBtn, bool enterDisableState)
	{
		if (!(operateBtn == null) && operateBtn.operateBtnData.configDisableState != enterDisableState)
		{
			operateBtn.SetConfigDisableState(enterDisableState);
			if (!enterDisableState)
			{
				operateBtn.RefreshDisplay(_entity);
			}
		}
	}

	public OperateBtn GetBtnByCustomUICompType(CustomUICompType customUICompType)
	{
		return customUICompType switch
		{
			CustomUICompType.JumpBtn => (OperateBtn)_jumpBtn, 
			CustomUICompType.DodgeBtn => _dodgeBtn, 
			CustomUICompType.AttackBtn => _attackBtn, 
			CustomUICompType.SpAttackBtn => _spAttackBtn, 
			CustomUICompType.UltraBtn => _ultraBtn, 
			_ => null, 
		};
	}

	public void RefreshDisPlayOnCharacterChange(Entity eb)
	{
		if (_jumpBtn != null)
		{
			_jumpBtn.RefreshDisplay(eb);
		}
		if (_dodgeBtn != null)
		{
			_dodgeBtn.RefreshDisplay(eb);
		}
		if (_attackBtn != null)
		{
			_attackBtn.RefreshDisplay(eb);
		}
		if (_spAttackBtn != null)
		{
			_spAttackBtn.RefreshDisplay(eb);
		}
		if (_ultraBtn != null)
		{
			_ultraBtn.RefreshDisplay(eb);
		}
		if (_energyBar != null)
		{
			_energyBar.RefreshDisplay(eb);
		}
		if (_assistComp != null)
		{
			_assistComp.OnCharacterChange(eb);
		}
	}
}
