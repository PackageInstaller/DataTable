using System.Collections.Generic;

namespace Ase;

public class BuffDataModifyBulletHitSiteLevelByTag : BuffDataBase
{
	public string bulletLabel;

	public BulletModifySiteLevelEnum modifySiteLevelEnum;

	public override BuffOperationType EffectType => BuffOperationType.ModifyBulletHitSiteLevelByTag;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		bulletLabel = paramList[0];
		modifySiteLevelEnum = Utility.Convert.StringToEnum<BulletModifySiteLevelEnum>(paramList[1]);
	}

	protected override void OnResetParams(params object[] args)
	{
	}

	protected override string OnGetDataString()
	{
		return $"{bulletLabel},{modifySiteLevelEnum}";
	}
}
