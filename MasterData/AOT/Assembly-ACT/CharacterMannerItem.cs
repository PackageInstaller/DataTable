using Bamboo.ImageCenter;
using UnityEngine;

public class CharacterMannerItem : MonoBehaviour
{
	public BImage ImageMannerIcon;

	private void Start()
	{
	}

	public void Init(ImageAssetStation station, int mannerType)
	{
		station?.LoadImage(199, mannerType, ImageMannerIcon);
	}

	private void Update()
	{
	}
}
