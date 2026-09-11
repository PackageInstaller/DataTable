using BilliardGame.Runtime;
using UnityEngine.UI;

namespace BilliardGame;

public class BilliardGameEnemyBuffPredict : BilliardGameHud
{
	private const string PATH = "TextureConfig/Activity_SummerPub/BilliardGame/buff/{0}";

	public Image icon;

	public void RefreshPredictIcon(int id)
	{
		BilliardBuffConfig buffCfg = BilliardGameDataManager.GetBuffCfg(id);
		if (buffCfg == null)
		{
			Show(isShow: false);
			return;
		}
		Show(isShow: true);
		string spritePath = $"TextureConfig/Activity_SummerPub/BilliardGame/buff/{buffCfg.icon}";
		AtlasManager.GetSpriteWithoutAtlas(icon, spritePath);
	}
}
