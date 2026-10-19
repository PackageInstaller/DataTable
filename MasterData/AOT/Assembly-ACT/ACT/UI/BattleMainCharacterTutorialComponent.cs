using ACT.Model;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class BattleMainCharacterTutorialComponent : MonoBehaviour, IBattleMainComponent
{
	[SerializeReference]
	private RectTransform characterTutorialRoot;

	[SerializeReference]
	private GameObject characterTutorialCompPrefab;

	private CharacterTutorialComp _characterTutorialComp;

	private ImageAssetStation _imageStation;

	private OperateBtnComp _operateBtnComp;

	public void Initialize(MonoBattleMainBaseView view)
	{
		_operateBtnComp = view.operateBtnComp;
	}

	public void UnInitialize()
	{
		CloseComponent();
	}

	public void OpenComponent()
	{
		Model<CharacterTutorialModel>.Interface.OnTutorialStart -= InitCharacterTutorialComp;
		Model<CharacterTutorialModel>.Interface.OnTutorialStart += InitCharacterTutorialComp;
		Model<CharacterTutorialModel>.Interface.OnTutorialFinish -= UnInitCharacterTutorialComp;
		Model<CharacterTutorialModel>.Interface.OnTutorialFinish += UnInitCharacterTutorialComp;
		UnloadPrefab();
	}

	public void CloseComponent()
	{
		Model<CharacterTutorialModel>.Interface.OnTutorialStart -= InitCharacterTutorialComp;
		Model<CharacterTutorialModel>.Interface.OnTutorialFinish -= UnInitCharacterTutorialComp;
		UnloadPrefab(forceUnload: true);
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void UnloadPrefab(bool forceUnload = false)
	{
		HudType hudType = Model<BattleMainModel>.Interface.hudType;
		if (forceUnload || hudType != HudType.characterTutorial)
		{
			if (_imageStation != null)
			{
				ImageManager.instance.UnloadAssetStation(_imageStation);
				_imageStation = null;
			}
			if (_characterTutorialComp != null)
			{
				_characterTutorialComp.UnInit();
				_characterTutorialComp = null;
			}
			Model<CharacterTutorialModel>.Interface.HighLightCountDataDic.Clear();
			Model<CharacterTutorialModel>.Interface.CharacterTutorialShowHighLight = false;
		}
	}

	public void InitCharacterTutorialComp()
	{
		CleanupStaleTutorialComp();
		if (!(_characterTutorialComp != null) && !(characterTutorialRoot == null))
		{
			_imageStation = ImageManager.instance.GetAssetStation();
			_characterTutorialComp = Object.Instantiate(characterTutorialCompPrefab, characterTutorialRoot).GetComponent<CharacterTutorialComp>();
			_characterTutorialComp.Init(_imageStation, _operateBtnComp);
		}
	}

	public void UnInitCharacterTutorialComp()
	{
		if (_imageStation != null)
		{
			ImageManager.instance.UnloadAssetStation(_imageStation);
			_imageStation = null;
		}
		if (_characterTutorialComp != null)
		{
			_characterTutorialComp.UnInit();
			_characterTutorialComp = null;
		}
		if (Model<CharacterTutorialModel>.Interface.TryConsumeTutorialCompleteFlag() && Model<RaidModel>.HasInstance())
		{
			Model<RaidModel>.Interface.RaidSettlement();
		}
	}

	private void CleanupStaleTutorialComp()
	{
		if (characterTutorialRoot == null)
		{
			return;
		}
		CharacterTutorialComp[] componentsInChildren = characterTutorialRoot.GetComponentsInChildren<CharacterTutorialComp>(includeInactive: true);
		foreach (CharacterTutorialComp characterTutorialComp in componentsInChildren)
		{
			if (!(characterTutorialComp == null) && (!(_characterTutorialComp != null) || !(characterTutorialComp == _characterTutorialComp)))
			{
				Object.Destroy(characterTutorialComp.gameObject);
			}
		}
		if (_characterTutorialComp != null && _characterTutorialComp.gameObject == null)
		{
			_characterTutorialComp = null;
		}
	}
}
