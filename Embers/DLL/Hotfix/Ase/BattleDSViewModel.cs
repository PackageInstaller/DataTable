#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using System.Text;
using Ase.ECS;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleDSViewModel : OptionBase
{
	private Dictionary<int, DamageInfoViewModel> itemVMs = new Dictionary<int, DamageInfoViewModel>();

	private readonly InteractionRequest changeDSShowRequest = new InteractionRequest();

	private Transform root;

	private bool downState;

	private string totalDownDamageText;

	private float totalDownDamage;

	private StringBuilder _stringBuilder;

	private InteractionRequest bossDownStateRequest = new InteractionRequest();

	public IInteractionRequest ChangeDSShowRequest => changeDSShowRequest;

	public Dictionary<int, DamageInfoViewModel> ItemVMs => itemVMs;

	public Transform Root => root;

	public bool DownState => downState;

	public string TotalDownDamageText
	{
		get
		{
			return totalDownDamageText;
		}
		private set
		{
			Set(ref totalDownDamageText, value, "TotalDownDamageText");
		}
	}

	public InteractionRequest BossDownStateRequest => bossDownStateRequest;

	public override void ItemOnClick(object obj)
	{
	}

	public BattleDSViewModel()
	{
	}

	public BattleDSViewModel(OptionBase parent, Transform root)
	{
		base.parent = parent;
		this.root = root;
	}

	public void OnDataComplete(BattleUserInfoViewModel userInfo, Dictionary<int, EntityStatInfo> datas)
	{
		int num = 0;
		foreach (KeyValuePair<int, EntityStatInfo> data in datas)
		{
			num++;
			BattleHeroData heroDataByEntityId = userInfo.GetHeroDataByEntityId(data.Key);
			if (heroDataByEntityId != null)
			{
				DamageInfoViewModel value = new DamageInfoViewModel(this, heroDataByEntityId, num);
				itemVMs.Add(data.Key, value);
			}
		}
		changeDSShowRequest.Raise();
	}

	public void RefreshDS(int entityId, EntityStatInfo data, Dictionary<int, EntityStatInfo> total)
	{
		if (!itemVMs.ContainsKey(entityId))
		{
			return;
		}
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		foreach (EntityStatInfo value in total.Values)
		{
			if (value.Damage > num)
			{
				num = value.Damage;
			}
			if (value.Tenacity > num2)
			{
				num2 = value.Tenacity;
			}
			if (value.CurativeDose > num3)
			{
				num3 = value.CurativeDose;
			}
		}
		itemVMs[entityId].RefreshDS(data, num, num2, num3);
		if (downState)
		{
			totalDownDamage = 0f;
		}
		foreach (DamageInfoViewModel value2 in itemVMs.Values)
		{
			value2.RefreshDS(num, num2, num3);
			if (downState)
			{
				totalDownDamage += value2.GetToTalDownDamage();
			}
		}
	}

	public void RefreshSelf(BattleUserInfoViewModel userInfo)
	{
		foreach (KeyValuePair<int, DamageInfoViewModel> itemVM in itemVMs)
		{
			BattleHeroData heroDataByEntityId = userInfo.GetHeroDataByEntityId(itemVM.Key);
			if (heroDataByEntityId != null)
			{
				itemVM.Value.RefreshSelf(heroDataByEntityId.IsSelf);
			}
			else
			{
				Log.Error($"战斗统计，实体id{itemVM.Key} 找不到对应实体的英雄数据！");
			}
		}
	}

	public void ResetAllDS()
	{
		itemVMs.Clear();
	}

	public void SetBossDown(bool enterDown)
	{
		if (downState == enterDown)
		{
			return;
		}
		downState = enterDown;
		foreach (DamageInfoViewModel value in itemVMs.Values)
		{
			value.SetDownState(enterDown);
		}
		if (enterDown)
		{
			totalDownDamage = 0f;
			TotalDownDamageText = "";
			if (_stringBuilder == null)
			{
				_stringBuilder = new StringBuilder(100);
			}
			else
			{
				_stringBuilder.Clear();
			}
		}
		else
		{
			string text = ((long)totalDownDamage).ToString();
			for (int i = 0; i < text.Length; i++)
			{
				_stringBuilder.Append($"<sprite={text[i]}>");
			}
			TotalDownDamageText = _stringBuilder.ToString();
		}
		bossDownStateRequest.Raise();
	}

	public void SetBossShowUp(bool showUp)
	{
		if (!showUp && downState)
		{
			SetBossDown(enterDown: false);
		}
	}
}
