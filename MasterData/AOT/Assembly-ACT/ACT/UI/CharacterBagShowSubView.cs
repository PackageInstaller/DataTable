using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CharacterBagShowSubView : SubUIView<CharacterBagShowSubInputController>, ICharacterSubView, ISubUIView, IBaseUIComponent
{
	public ViewControlLayer ControlLayer;

	[SerializeReference]
	private BImage ImageElementIcon;

	[SerializeField]
	private LocalizeStringEvent characterName;

	[SerializeField]
	private List<CharacterOverTagtem> _listTag;

	[SerializeField]
	private CharacterProfessionIcon CharacterProfessionIconItem;

	public CharacterMannerItem MannerItem;

	private bool _afterAnimation;

	private int _characterId;

	private ImageAssetStation _Station;

	public CharacterView CharacterView { get; private set; }

	public bool FreezeCharacterOSA => true;

	public int Depth => 2;

	public ICharacterSubView lastSubView { get; set; }

	public CharacterViewScene.CvSceneType SceneType => CharacterViewScene.CvSceneType.BagShow;

	public new object Context { get; set; }

	public bool AfterAnimation
	{
		get
		{
			return _afterAnimation;
		}
		set
		{
			_afterAnimation = value;
			if (value)
			{
				((ICharacterSubView)this).SendAfterAnimationEvent();
			}
		}
	}

	public void Init(CharacterView characterView)
	{
		CharacterView = characterView;
	}

	public void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource)
	{
		_characterId = characterId;
		gameObject.SetActive(value: true);
		_Station = station;
		Refresh(characterId);
		AfterAnimation = true;
		ControlLayer.Focus();
	}

	public void Hide()
	{
		gameObject.SetActive(value: false);
		AfterAnimation = false;
	}

	public void Freeze()
	{
		gameObject.SetActive(value: false);
	}

	public void UnFreeze(int characterId)
	{
		gameObject.SetActive(value: true);
	}

	public void OnSelectCharacter(ICharacterSource characterSource)
	{
		Refresh(_characterId = characterSource.Id());
	}

	private void Refresh(int characterId)
	{
		G.localPlayer.GetCharacter(characterId);
		EntityData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityDatas);
		EntityCharacterData data2 = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		int[] characterTagGroup = data2.characterTagGroup;
		characterName.StringReference.TableEntryReference = data.nameLocal;
		_Station.LoadImage(102, data.element, ImageElementIcon);
		CharacterProfessionIconItem.UpdateDisPlay(characterId);
		MannerItem.Init(_Station, data2.mannerType);
		for (int i = 0; i < _listTag.Count; i++)
		{
			_listTag[i].gameObject.SetActive(characterTagGroup.Length > i);
			if (characterTagGroup.Length > i)
			{
				_listTag[i].Init(characterTagGroup[i]);
				_listTag[i].BtnClick.SetBtnClick(() =>
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
					{
						characterId = characterId
					});
				});
			}
		}
	}
}
