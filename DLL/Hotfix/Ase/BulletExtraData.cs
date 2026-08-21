namespace Ase;

public class BulletExtraData
{
	public BulletInitData initData;

	public BulletRuntimeConfigData runtimeConfigData;

	public BulletMoveDataBase moveData;

	public BulletViewData viewData;

	public BulletBattleOnceData battleOnceData;

	public BulletMapExData bulletMapExData;

	public BulletReboundData reboundData;

	public BulletExtraData Clone()
	{
		return new BulletExtraData
		{
			runtimeConfigData = runtimeConfigData.Clone(),
			moveData = moveData.Clone(),
			viewData = viewData.Clone(),
			battleOnceData = battleOnceData.Clone(),
			bulletMapExData = bulletMapExData.Clone(),
			reboundData = reboundData.Clone()
		};
	}
}
