using UnityEngine;

public class BattleUIPortrait : MonoBehaviour
{
	[SerializeField]
	private BattleUIPortraitItem item1;

	[SerializeField]
	private BattleUIPortraitItem item2;

	public void Play(string path, float time)
	{
		BattleUIPortraitItem battleUIPortraitItem = item1;
		if (battleUIPortraitItem.IsRunning())
		{
			battleUIPortraitItem = item2;
		}
		if (battleUIPortraitItem.IsRunning())
		{
			battleUIPortraitItem = item1;
		}
		Sprite spriteWithoutAtlas = AtlasManager.GetSpriteWithoutAtlas(path);
		battleUIPortraitItem.Play(spriteWithoutAtlas, time);
	}

	private void Update()
	{
		if (item1 != null)
		{
			item1.Update(Time.deltaTime);
		}
		if (item2 != null)
		{
			item2.Update(Time.deltaTime);
		}
	}
}
