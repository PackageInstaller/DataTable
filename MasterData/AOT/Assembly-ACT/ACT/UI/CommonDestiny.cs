using System.Text;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

[DisallowMultipleComponent]
public class CommonDestiny : BaseUIComponent
{
	private const int DefaultDestinyIconCharacterId = 10101;

	private const int MaxDestinyCount = 6;

	[SerializeField]
	private BImage destinyIcon;

	[SerializeField]
	public ActButton destinyEnter;

	[SerializeField]
	private TextMeshProUGUI activeDestinyCount;

	[SerializeField]
	private RedDotItem destinyRedDot;

	private readonly StringBuilder _countBuilder = new StringBuilder(4);

	public void Refresh(int characterId, Character character, ImageAssetStation station, bool isTrialCharacter, UnityAction openDestiny)
	{
		if (destinyEnter != null && openDestiny != null)
		{
			destinyEnter.SetBtnClick(openDestiny);
		}
		if (destinyIcon != null)
		{
			station?.LoadImage(152, characterId, 10101, destinyIcon);
		}
		RefreshRedDot(characterId, isTrialCharacter);
		RefreshActiveCount(characterId, character, isTrialCharacter);
	}

	private void RefreshRedDot(int characterId, bool isTrialCharacter)
	{
		if (destinyRedDot == null)
		{
			return;
		}
		destinyRedDot.ForbidDotShow = isTrialCharacter;
		if (isTrialCharacter)
		{
			destinyRedDot.gameObject.SetActive(value: false);
			return;
		}
		string text = string.Format(RedDotPathDefine.Character + "|{0}|Constellation", characterId);
		if (!Singleton<RedDotManager>.instance.IsPathRegistered(text) && Singleton<RedDotManager>.instance.GetNode(text) == null)
		{
			Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(text);
		}
		destinyRedDot.InitRedDot(text);
	}

	private void RefreshActiveCount(int characterId, Character character, bool isTrialCharacter)
	{
		if (!(activeDestinyCount == null))
		{
			int value = ((isTrialCharacter && character != null) ? character.GetActiveDestinyCount() : Model<DestinyModel>.Interface.GetCharacterDestinyActiveCount(characterId));
			_countBuilder.Clear();
			_countBuilder.Append(value).Append('/').Append(6);
			activeDestinyCount.SetText(_countBuilder);
		}
	}
}
