using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class BuffDataModifyVelocity : BuffDataBase
{
	public float vel;

	public Vector3 direct;

	public override BuffOperationType EffectType => BuffOperationType.ModifyVelocity;

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
		Desc = "该Buff不支持显示数据信息";
	}

	protected override void OnResetParams(params object[] args)
	{
		vel = (float)args[0];
		direct = (Vector3)args[1];
	}

	protected override string OnGetDataString()
	{
		return string.Empty;
	}
}
