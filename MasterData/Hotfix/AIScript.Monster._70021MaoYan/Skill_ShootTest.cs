using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_ShootTest : SkillBaseMaoYan
{
	private CoroutineNode shootCor;

	private bool interrupt;

	protected override void OnSkillEnable()
	{
		interrupt = true;
	}

	protected override void OnSkillDisable()
	{
		if (interrupt && shootState)
		{
			StopCor(shootCor);
			shootState = false;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		FanMultipleShoot("Bullet_Fire_Strike_COM", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 1.7, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0, 0);
		PlayEffect("fx_70021_base_Fire", 1f, default, default, default, 1f, actorScale: true);
		yield break;
	}
}
