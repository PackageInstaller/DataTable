using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("1093忍印(渲染)", 0)]
[Category("Render/UI")]
[Description("1099的蓄力条逻辑;\n 资源路径从 Prefab 下开始,例如要加载 AbilityPressingProgress ,则填写 UI/AbilityPressingProgress;\n【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo")]
public class CustomUI1093Mudra : CustomUIBaseEvent
{
	private ValueInput<string> _Sky1PathInput;

	private ValueInput<string> _Sky2PathInput;

	private ValueInput<string> _Ground1PathInput;

	private ValueInput<string> _Ground2PathInput;

	private ValueInput<string> _ExecuteEffectPathInput;

	private GameObject _Sky1;

	private GameObject _Sky2;

	private GameObject _Ground1;

	private GameObject _Ground2;

	private GameObject _ExecuteEffect;

	private int _GroundCount;

	private int _SkyCount;

	protected override void OnAgentInit(EntitySpawnedEvent pEventReceived)
	{
	}

	protected override void OnBind(GameObject pPanel, string pPrefabPath, ref BuffState pBuffState)
	{
		if (_effectInstance == null)
		{
			GameObject gameObject = Asset.Instantiate(_effectPathInput.GetValue());
			if (gameObject == null)
			{
				return;
			}
			_effectInstance = gameObject;
			_effectInstance.transform.SetParent(pPanel.transform, worldPositionStays: false);
			FindChild(ref _Sky1, _Sky1PathInput.GetValue());
			FindChild(ref _Sky2, _Sky2PathInput.GetValue());
			FindChild(ref _Ground1, _Ground1PathInput.GetValue());
			FindChild(ref _Ground2, _Ground2PathInput.GetValue());
			ResetAllMudra();
			FindChild(ref _ExecuteEffect, _ExecuteEffectPathInput.GetValue());
			SetActvieOfChild(_ExecuteEffect, value: false);
		}
		switch ((int)pBuffState.mBuffParams.v1)
		{
		case 1:
			SkyAdd();
			break;
		case 2:
			GroundAdd();
			break;
		}
	}

	private void SkyAdd()
	{
		if (_GroundCount == 0 && _SkyCount == 0)
		{
			SetActvieOfChild(_Sky1, value: true);
		}
		else
		{
			SetActvieOfChild(_Sky2, value: true);
		}
		_SkyCount++;
	}

	private void GroundAdd()
	{
		if (_GroundCount == 0 && _SkyCount == 0)
		{
			SetActvieOfChild(_Ground1, value: true);
		}
		else
		{
			SetActvieOfChild(_Ground2, value: true);
		}
		_GroundCount++;
	}

	private void ResetAllMudra()
	{
		SetActvieOfChild(_Sky1, value: false);
		SetActvieOfChild(_Sky2, value: false);
		SetActvieOfChild(_Ground1, value: false);
		SetActvieOfChild(_Ground2, value: false);
		_SkyCount = 0;
		_GroundCount = 0;
	}

	private void FindChild(ref GameObject pHandler, string pPath)
	{
		Transform transform = _effectInstance.transform.Find(pPath);
		if (transform != null)
		{
			pHandler = transform.gameObject;
		}
	}

	private void SetActvieOfChild(GameObject pHandler, bool value)
	{
		if (pHandler != null)
		{
			pHandler.SetActive(value);
		}
	}

	protected override void OnTick(ref BuffState pBuffState)
	{
	}

	protected override void OnLeave(ref BuffState pBuffState)
	{
		SetActvieOfChild(_ExecuteEffect, value: false);
		SetActvieOfChild(_ExecuteEffect, value: true);
		ResetAllMudra();
	}

	protected override void AddCustomValueInput()
	{
		_Sky1PathInput = AddValueInput<string>("天印1", "sky1").SetDefaultAndSerializedValue("1093Dou/Sky1");
		_Sky2PathInput = AddValueInput<string>("天印2", "sky2").SetDefaultAndSerializedValue("1093Dou/Sky2");
		_Ground1PathInput = AddValueInput<string>("地印1", "ground1").SetDefaultAndSerializedValue("1093Dou/Ground1");
		_Ground2PathInput = AddValueInput<string>("地印2", "ground2").SetDefaultAndSerializedValue("1093Dou/Ground2");
		_ExecuteEffectPathInput = AddValueInput<string>("释放", "execute").SetDefaultAndSerializedValue("1093Hebing/hebing");
	}
}
