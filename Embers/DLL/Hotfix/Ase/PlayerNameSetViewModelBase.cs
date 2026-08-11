#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PlayerNameSetViewModelBase : OptionBase
{
	protected SimpleCommand confirmCommand;

	protected string nameInput;

	private string validateTip;

	protected List<DRRandomName> randomNamesA = new List<DRRandomName>();

	protected List<DRRandomName> randomNamesB = new List<DRRandomName>();

	protected List<DRRandomName> randomNamesC = new List<DRRandomName>();

	public string NameInput
	{
		get
		{
			return nameInput;
		}
		set
		{
			Set(ref nameInput, value, "NameInput");
		}
	}

	public string ValidateTip
	{
		get
		{
			return validateTip;
		}
		set
		{
			Set(ref validateTip, value, "ValidateTip");
		}
	}

	public SimpleCommand ConfirmCommand => confirmCommand;

	public PlayerNameSetViewModelBase(OptionBase parent)
	{
		base.parent = parent;
		confirmCommand = new SimpleCommand(Confirm);
		InitRandomName();
	}

	protected virtual async void Confirm()
	{
	}

	public void RandomName()
	{
		if (!confirmCommand.Enabled)
		{
			return;
		}
		try
		{
			NameInput = randomNamesA[UnityEngine.Random.Range(0, randomNamesA.Count)].Name + randomNamesB[UnityEngine.Random.Range(0, randomNamesB.Count)].Name + randomNamesC[UnityEngine.Random.Range(0, randomNamesC.Count)].Name;
		}
		catch (Exception ex)
		{
			Log.Error("获取随机名字发生异常 " + ex.Message + " / " + ex.StackTrace);
			Toast.ShowInfo("创建随机名字出错！请重试！");
			NameInput = "";
		}
	}

	protected bool ValidateName()
	{
		if (string.IsNullOrEmpty(nameInput) || !NameCheck(nameInput))
		{
			ValidateTip = "请输入汉字、字母或数字，1-12个字符";
			Toast.ShowInfo(ValidateTip);
			return false;
		}
		ValidateTip = "";
		return true;
	}

	protected void InitRandomName()
	{
		try
		{
			DRRandomName[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRRandomName>();
			if (allDataRow == null || allDataRow.Length == 0)
			{
				Toast.ShowError("RandomName表配置异常！");
			}
			DRRandomName[] array = allDataRow;
			foreach (DRRandomName dRRandomName in array)
			{
				if (dRRandomName.Type == 1)
				{
					randomNamesA.Add(dRRandomName);
				}
				if (dRRandomName.Type == 2)
				{
					randomNamesB.Add(dRRandomName);
				}
				if (dRRandomName.Type == 3)
				{
					randomNamesC.Add(dRRandomName);
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("获取随机名字发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
	}

	protected bool NameCheck(string name)
	{
		int num = 0;
		byte[] bytes = new ASCIIEncoding().GetBytes(name);
		for (int i = 0; i < bytes.Length; i++)
		{
			if ((bytes[i] >= 48 && bytes[i] <= 57) || bytes[i] == 63 || (bytes[i] >= 65 && bytes[i] <= 90) || (bytes[i] >= 97 && bytes[i] <= 122))
			{
				if (bytes[i] == 63)
				{
					if (!CheckChinese(i))
					{
						return false;
					}
					num += 2;
				}
				else
				{
					num++;
				}
				continue;
			}
			return false;
		}
		if (num >= 1)
		{
			return num <= 12;
		}
		return false;
	}

	private bool CheckChinese(int i)
	{
		return Regex.IsMatch(NameInput.Substring(i, 1), "^[一-龥]");
	}

	public async void SetResult(IAccountService.ChangeRoleResult result)
	{
		if (result != null && result.Code == 0)
		{
			Toast.ShowInfo("修改成功！");
			ValidateTip = "<color=green>设置成功</color>";
			Close();
		}
		confirmCommand.Enabled = true;
	}
}
