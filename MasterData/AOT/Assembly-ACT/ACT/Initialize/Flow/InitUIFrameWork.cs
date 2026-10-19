using ACT.Battle;
using ACT.UI;
using Fundamental;

namespace ACT.Initialize.Flow;

public class InitUIFrameWork : RuntimeLoadFlow
{
	public InitUIFrameWork()
		: base("InitUIFrameWork")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		Singleton<NewUIManager>.CreateInstance();
		Singleton<TipManager>.CreateInstance();
		Singleton<LightManager>.CreateInstance();
		NewUIManagerMonoProxy componentInChildren = LuminRuntimeInitializer.GameLoader.GetComponentInChildren<NewUIManagerMonoProxy>();
		Singleton<NewUIManager>.instance.BindMonoProxy(componentInChildren);
		WaitInitializer.CompleteOne();
	}
}
