using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterGroup : LoopScrollBaseItem
{
	[SerializeField]
	private TextMeshProUGUI _favorLevel;

	[SerializeField]
	private Image _characterPlotImage;

	[SerializeField]
	private Image _characterPlotDarkImage;

	[SerializeField]
	private Image _chatImage;

	[SerializeField]
	private Image _chatDarkImage;

	[SerializeField]
	private Image _chatAndPlotImage;

	[SerializeField]
	private Image _chatAndPlotDarkImage;

	[SerializeField]
	private BImage _characterHeadImage;

	[SerializeField]
	private LocalizeStringEvent characterNameLocalize;

	[SerializeField]
	private LocalizeStringEvent _favorName;

	private ImageAssetStation station;

	public override void ScrollCellIndex(int idx)
	{
		gameObject.SetActive(value: true);
		index = idx;
		InviteCharacterConfirmPanelData inviteCharacterConfirmPanelData = Model<InviteCharacterModel>.Interface.InviteCharacterList[idx];
		int characterId = inviteCharacterConfirmPanelData.characterId;
		int pointId = inviteCharacterConfirmPanelData.pointId;
		if (RuntimeConfigs.data.entityDatas.TryGetValue(characterId, out var value))
		{
			characterNameLocalize.StringReference.TableEntryReference = value.nameLocal;
		}
		if (station == null)
		{
			station = GetComponentInParent<IBaseUIView>().Station;
		}
		station.LoadImage(126, CharacterSkinRuntimeUtility.ResolveBagCharacterSkinId(characterId), _characterHeadImage);
		int num = Model<LoungeModel>.Interface.GetCharacterFavorInfo(characterId).Item1;
		if (num == 0)
		{
			num = 1;
		}
		_favorLevel.text = num.ToString();
		_favorName.StringReference.TableEntryReference = Model<FavorabilityModel>.Interface.GetFavorabilityName(num);
		Model<InviteCharacterModel>.Interface.GetSideIconDisplay(characterId, pointId, out var plotBright, out var plotDark, out var chatBright, out var chatDark);
		ApplySideIconVisual(plotBright, plotDark, chatBright, chatDark);
	}

	private void ApplySideIconVisual(bool plotBright, bool plotDark, bool chatBright, bool chatDark)
	{
		ResetSideIcons();
		if (plotBright & chatBright)
		{
			_chatAndPlotImage.gameObject.SetActive(value: true);
			return;
		}
		if (plotDark & chatDark)
		{
			_chatAndPlotDarkImage.gameObject.SetActive(value: true);
			return;
		}
		if (plotBright)
		{
			_characterPlotImage.gameObject.SetActive(value: true);
		}
		if (plotDark)
		{
			_characterPlotDarkImage.gameObject.SetActive(value: true);
		}
		if (chatBright)
		{
			_chatImage.gameObject.SetActive(value: true);
		}
		if (chatDark)
		{
			_chatDarkImage.gameObject.SetActive(value: true);
		}
	}

	private void ResetSideIcons()
	{
		_characterPlotImage.gameObject.SetActive(value: false);
		_characterPlotDarkImage.gameObject.SetActive(value: false);
		_chatImage.gameObject.SetActive(value: false);
		_chatDarkImage.gameObject.SetActive(value: false);
		_chatAndPlotImage.gameObject.SetActive(value: false);
		_chatAndPlotDarkImage.gameObject.SetActive(value: false);
	}
}
