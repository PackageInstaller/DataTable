using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class CharacterProfessionIcon : BaseUIComponent
{
	[SerializeField]
	private Color[] _professionColors;

	[SerializeField]
	private BImage _board;

	[SerializeField]
	private BImage _iconBoard;

	[SerializeField]
	private BImage _icon;

	[SerializeField]
	private BImage _littleIcon;

	[SerializeField]
	private bool _showIconBoard;

	[SerializeField]
	private bool _isLittleIcon;

	public void UpdateDisPlay(int characterId)
	{
		if (characterId == 0)
		{
			return;
		}
		Station = null;
		EntityCharacterData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		if (data == null)
		{
			return;
		}
		_icon.icon.gameObject.SetActive(!_isLittleIcon);
		_iconBoard.icon.gameObject.SetActive(!_isLittleIcon && _showIconBoard);
		_littleIcon.icon.gameObject.SetActive(_isLittleIcon);
		_board.icon.gameObject.SetActive(_isLittleIcon);
		if (!_isLittleIcon)
		{
			Station?.LoadImageAsync(170, data.characterDamageType, _icon);
			if (_showIconBoard)
			{
				Station?.LoadImageAsync(171, data.characterDamageType, _iconBoard);
			}
			_icon.icon.color = Color.white;
			_iconBoard.icon.color = Color.white;
		}
		else
		{
			Station?.LoadImageAsync(172, data.characterDamageType, _littleIcon);
			Color[] professionColors = _professionColors;
			if (professionColors != null && professionColors.Length > 0)
			{
				_littleIcon.icon.color = _professionColors[data.mannerType - 1];
			}
		}
	}
}
