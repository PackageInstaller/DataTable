using System.Collections;
using TrueSync;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Attack03 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Atk, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Start");
		yield return WaitFrame(30);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (eventName == "Eot")
		{
			if (GetBuffNum(_actor, 503110002) >= 1)
			{
				SpawnEot02();
				Shoot01();
			}
			else
			{
				SpawnEot01();
				Shoot01();
			}
		}
	}

	protected void Shoot01()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		Shoot("Bullet_50311_DaWuGui_Skill03", entityPositionObsoleted, 0, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget);
	}

	protected void SpawnEot01()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		PlayAreaEffect("Area_50311_DaWuGui_Skill03", entityPositionObsoleted);
	}

	protected void SpawnEot02()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		PlayAreaEffect("Area_50311_DaWuGui_Skill03_Ex", entityPositionObsoleted);
	}
}
