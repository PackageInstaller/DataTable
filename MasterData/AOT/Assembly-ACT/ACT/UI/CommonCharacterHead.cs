using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class CommonCharacterHead : MonoBehaviour
{
	[SerializeField]
	private BImage headImage;

	private int _characterId;

	public void Init(int characterId, ImageAssetStation station)
	{
		_characterId = characterId;
		station.LoadImage(126, characterId, headImage);
	}

	public void SetActive(bool active)
	{
		gameObject.SetActive(active);
	}
}
