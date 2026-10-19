using ACT.Game.Data;
using Bamboo.ImageCenter;

namespace ACT.UI;

public class EliteLevelUpPanelDataNew : LevelUpPanelData
{
	public Character character { get; private set; }

	public int ElitePointId { get; private set; }

	public int RemainTokenId { get; private set; }

	public int RemainTokenNum { get; private set; }

	public int AvailableTokenId { get; private set; }

	public int AvailableTokenNum { get; private set; }

	public int CostTokeNumPerLevel { get; private set; }

	public ImageAssetStation ImageStation { get; private set; }

	public bool isTrialCharacter { get; private set; }

	public void SetEliteVal(Character curCharacter, int elitePointId, int remainTokenId, int remainTokenNum, int availableTokenId, int availableTokenNum, int costTokeNumPerLevel, ImageAssetStation imageStation, bool isTrial)
	{
		character = curCharacter;
		ElitePointId = elitePointId;
		RemainTokenId = remainTokenId;
		RemainTokenNum = remainTokenNum;
		AvailableTokenId = availableTokenId;
		AvailableTokenNum = availableTokenNum;
		CostTokeNumPerLevel = costTokeNumPerLevel;
		ImageStation = imageStation;
		_station = imageStation;
		isTrialCharacter = isTrial;
	}

	public override void Recycle()
	{
		base.Recycle();
		character = null;
		ElitePointId = 0;
		RemainTokenNum = 0;
		RemainTokenId = 0;
		AvailableTokenId = 0;
		AvailableTokenNum = 0;
		CostTokeNumPerLevel = 0;
		ImageStation = null;
		isTrialCharacter = false;
	}
}
