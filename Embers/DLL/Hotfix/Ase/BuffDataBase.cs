using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

[Serializable]
public abstract class BuffDataBase : IReference
{
	protected string label0;

	protected string label1;

	protected string label2;

	protected string label3;

	protected string label4;

	protected string label5;

	protected string label6;

	protected string label7;

	protected string label8;

	protected string label9;

	protected string label10;

	public string Title = "Buff类型数据";

	public string Desc = "buff 描述测试 test 0.1";

	public abstract BuffOperationType EffectType { get; }

	protected abstract int paramsMinCount { get; }

	public bool IsVaild { get; protected set; }

	public void Init(List<string> paramList)
	{
		if (paramList != null)
		{
			if (paramList.Count < paramsMinCount && paramsMinCount != -1)
			{
				IsVaild = true;
			}
			else
			{
				OnInit(paramList);
			}
		}
	}

	protected abstract void OnInit(List<string> paramList);

	public void ResetParams(params object[] args)
	{
		if (args == null || args.Length == 0)
		{
			IsVaild = true;
		}
		else
		{
			OnResetParams(args);
		}
	}

	protected abstract void OnResetParams(params object[] args);

	protected void LogWarning(string msg)
	{
	}

	public string GetDataString()
	{
		return $"{(int)EffectType},{OnGetDataString()}";
	}

	protected abstract string OnGetDataString();

	public override string ToString()
	{
		return $"{(int)EffectType} {Title} \t\t 数据 :  {GetDataString()}";
	}

	public void Clear()
	{
		IsVaild = false;
		OnClear();
	}

	protected virtual void OnClear()
	{
	}
}
