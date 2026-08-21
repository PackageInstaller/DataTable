#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class BattleSelectResult
{
	private Dictionary<string, object> battleResult;

	private OptionBase lastVM;

	private SelectType selectType;

	private Loading disableTouch;

	public SelectType SelectType => selectType;

	public BattleSelectResult(OptionBase lastVM, SelectType selectType)
	{
		battleResult = new Dictionary<string, object>();
		this.selectType = selectType;
		this.lastVM = lastVM;
	}

	public void UpdateSelectType(OptionBase lastVM, SelectType selectType)
	{
		this.lastVM = lastVM;
		this.selectType = selectType;
	}

	public void AddDisableTouch(Loading disableTouch)
	{
		if (this.disableTouch != null)
		{
			Toast.ShowError("已添加Loading屏蔽界面！");
			Log.Error("已添加Loading屏蔽界面！");
		}
		else
		{
			this.disableTouch = disableTouch;
		}
	}

	public void Add(string paramName, object paramVal)
	{
		if (battleResult.ContainsKey(paramName))
		{
			Log.Error("参数 " + paramName + " 已存在！");
		}
		else
		{
			battleResult.Add(paramName, paramVal);
		}
	}

	public T Get<T>(string paramName) where T : new()
	{
		try
		{
			if (battleResult.ContainsKey(paramName))
			{
				return (T)battleResult[paramName];
			}
			Log.Error("参数 " + paramName + " 不存在！");
		}
		catch (Exception)
		{
			Log.Error("类型转换异常！");
			throw;
		}
		return new T();
	}
}
