using ACT.Battle.Configs;

namespace ACT.Battle;

public class AbilityMixinVirtualCamera : BaseAbilityMixin
{
	private ConfigMixinVirtualCamera m_Config;

	public AbilityMixinVirtualCamera(ConfigMixinVirtualCamera config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void OnAdd()
	{
		ActionMemory memory = new ActionMemory(caster, owner, owner);
		m_Config.configVirtualCamera.Load(memory);
	}

	internal override void OnRemove()
	{
		m_Config.configVirtualCamera.Release();
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}
}
