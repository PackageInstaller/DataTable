using System.Collections.Generic;

namespace Ase;

public class BuffDataModifyBulletHitSiteLevelByConfigId : BuffDataBase
{
	public int bulletId;

	public BulletModifySiteLevelEnum modifySiteLevelEnum;

	public override BuffOperationType EffectType => BuffOperationType.ModifyBulletHitSiteLevelByConfigId;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		bulletId = Utility.Convert.StringToInt(paramList[0]);
		modifySiteLevelEnum = Utility.Convert.StringToEnum<BulletModifySiteLevelEnum>(paramList[1]);
	}

	protected override void OnResetParams(params object[] args)
	{
	}

	protected override string OnGetDataString()
	{
		return $"{bulletId},{modifySiteLevelEnum}";
	}
}
