namespace ACT.Config;

public abstract class RuntimeStepCondition
{
	protected bool finish;

	protected RuntimeStepCondition(GuideStepFinishConditionConfig config)
	{
	}

	public abstract void Init();

	public abstract void UnInit();

	public abstract bool CheckCondition();
}
