using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取怪物弱点数据", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取指定怪物实体的弱点数据，包括总时长、大弱点数量、大弱点开始时刻和结束时刻")]
public class GetMonsterWeaknessDataAction : ActionTaskBase
{
	[Name("怪物实体ID", 0)]
	[Description("要获取弱点数据的怪物实体的ID")]
	public BBParameter<int> monsterId;

	[Name("弱点总时长", 0)]
	[Description("存储怪物弱点的总时长")]
	public BBParameter<float> timer;

	[Name("大弱点数量", 0)]
	[Description("存储怪物的大弱点数量")]
	public BBParameter<float> weaknessCount;

	[Name("大弱点开始时刻", 0)]
	[Description("存储每个大弱点的开始时刻")]
	public BBParameter<List<float>> weaknessStartTimer;

	[Name("大弱点结束时刻", 0)]
	[Description("存储每个大弱点的结束时刻")]
	public BBParameter<List<float>> weaknessEndTimer;

	protected override void OnExecute()
	{
		base.OnExecute();
		weaknessStartTimer.value = new List<float>();
		weaknessEndTimer.value = new List<float>();
		weaknessCount.value = 0f;
		BaseEntity entity = GetEntity(monsterId.value, isSyncEntity: false);
		if (entity != null)
		{
			BaseWeaknessData monsterWeaknessData = entity.GetComponent<WeaknessComponent>().GetMonsterWeaknessData();
			if (monsterWeaknessData != null)
			{
				timer.value = ((monsterWeaknessData.Lifetime - monsterWeaknessData.Runtime > 0f) ? (monsterWeaknessData.Lifetime - monsterWeaknessData.Runtime) : 0f);
				int num = 0;
				foreach (WeaknessStateInfo item in monsterWeaknessData.weaknessState)
				{
					if (item.ConfigId > num)
					{
						num = item.ConfigId;
					}
				}
				foreach (WeaknessStateInfo item2 in monsterWeaknessData.weaknessState)
				{
					if (item2.ConfigId == num)
					{
						float num2 = item2.StartTimer - monsterWeaknessData.Runtime;
						num2 = ((num2 > 0f) ? num2 : 0f);
						weaknessStartTimer.value.Add(num2);
						float num3 = item2.EndTimer - monsterWeaknessData.Runtime;
						num3 = ((num3 > 0f) ? num3 : 0f);
						weaknessEndTimer.value.Add(num3);
						weaknessCount.value++;
					}
				}
			}
		}
		OnActionFinish();
	}
}
