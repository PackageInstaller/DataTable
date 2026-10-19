using ACT.Battle;
using Bamboo.ECS;

namespace ACT.DebugGUI;

public class GMButtonsMonitor : SingleMonitor
{
	public static bool charging;

	public static bool specialCharging;

	public static bool bigCharging;

	public static bool disableCoolDown;

	public static bool assistCharging;

	private GMButtonsWindow window;

	protected override bool OnInit()
	{
		DebugWindowManager.instance.singleWindow.AddGUI(new DebugGUIButton("GM按钮菜单", () =>
		{
			if (window == null)
			{
				window = new GMButtonsWindow();
			}
			if (window.Active)
			{
				window.Close();
			}
			else
			{
				window.Open();
			}
		}));
		return base.OnInit();
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		CompAbility compAbility = MonoECS.instance.mainEntity.GetCompAbility();
		if (charging)
		{
			compAbility.ModifyNormalEnergy(compAbility.MaxNormalEnergy);
		}
		if (bigCharging)
		{
			compAbility.CurrentUltimateSkillValue += 50f;
		}
		if (specialCharging)
		{
			compAbility.ModifySpecialEnergy(compAbility.MaxSpecialEnergy);
		}
		if (disableCoolDown)
		{
			foreach (Skill skill in MonoECS.instance.mainEntity.GetCompMotion().skills)
			{
				if (!skill.config.name.Equals("switchSkillCD"))
				{
					skill.SetSkillCd(0f, exceeds: false);
				}
			}
		}
		if (assistCharging)
		{
			GameManager.assistSystem.ChangeAssistValueForCharacter(MonoECS.instance.mainEntity, 100f, CompAbility.AssistChangeReason.Gm);
		}
	}
}
