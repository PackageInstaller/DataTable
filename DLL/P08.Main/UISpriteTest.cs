using UnityEngine;
using UnityEngine.UI;

public class UISpriteTest : MonoBehaviour
{
	public string atlasName;

	public string spriteName;

	public void Update()
	{
		GetComponent<Image>().sprite = AtlasManager.GetSprite(atlasName, spriteName);
	}
}
