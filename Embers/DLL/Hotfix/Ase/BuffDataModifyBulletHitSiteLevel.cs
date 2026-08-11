using System.Collections.Generic;

namespace Ase;

public class BuffDataModifyBulletHitSiteLevel : BuffDataBase
{
	public BulletModifySiteLevelEnum modifySiteLevelEnum;

	public override BuffOperationType EffectType => BuffOperationType.ModifyBulletHitSiteLevel;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		modifySiteLevelEnum = Utility.Convert.StringToEnum<BulletModifySiteLevelEnum>(paramList[0]);
	}

	protected override void OnResetParams(params object[] args)
	{
	}

	protected override string OnGetDataString()
	{
		return $"{modifySiteLevelEnum}";
	}
}
