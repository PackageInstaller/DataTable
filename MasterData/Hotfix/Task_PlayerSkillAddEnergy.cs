using TrueSync;
using UnityEngine;

[AddComponentMenu("触发器结果/玩家事件/角色大招充能", 2)]
public class Task_PlayerSkillAddEnergy : TaskCellBase
{
	public enum targetType
	{
		[InspectorName("当前角色")]
		currPlayer,
		[InspectorName("全队角色")]
		playerGroup,
		[InspectorName("1号位同伴")]
		firstSlotActor,
		[InspectorName("2号位同伴")]
		secondSlotActor
	}

	public enum ChargeType
	{
		[InspectorName("百分比")]
		Percent,
		[InspectorName("绝对值")]
		Absolute
	}

	public targetType _targetType;

	public ChargeType chargeType;

	public int energy;

	protected override void OnExecute()
	{
		if (_targetType == targetType.currPlayer)
		{
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (activedPlayerActor != null)
			{
				if (chargeType == ChargeType.Percent)
				{
					int totalEnergy = activedPlayerActor.playerSkillCd.GetTotalEnergy();
					FDP fDP = FDP.FromPercent(energy);
					activedPlayerActor.playerSkillCd.AddEnergy(totalEnergy * fDP);
				}
				else
				{
					activedPlayerActor.playerSkillCd.AddEnergy(energy);
				}
			}
		}
		else if (_targetType == targetType.playerGroup)
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (chargeType == ChargeType.Percent)
				{
					int totalEnergy2 = playerAdventureActor.playerSkillCd.GetTotalEnergy();
					FDP fDP2 = FDP.FromPercent(energy);
					playerAdventureActor.playerSkillCd.AddEnergy(totalEnergy2 * fDP2);
				}
				else
				{
					playerAdventureActor.playerSkillCd.AddEnergy(energy);
				}
			}
		}
		else
		{
			PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(1);
			if (_targetType == targetType.secondSlotActor)
			{
				playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(2);
			}
			if (chargeType == ChargeType.Percent)
			{
				int totalEnergy3 = playerAdventureActor2.playerSkillCd.GetTotalEnergy();
				FDP fDP3 = FDP.FromPercent(energy);
				playerAdventureActor2.playerSkillCd.AddEnergy(totalEnergy3 * fDP3);
			}
			else
			{
				playerAdventureActor2.playerSkillCd.AddEnergy(energy);
			}
		}
		EndAction();
	}

	private void Test()
	{
		OnExecute();
	}
}
