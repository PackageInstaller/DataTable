namespace P08.EnvironmentHelper;

public abstract class TimelineSceneSettingHelperBase : TimelineBase
{
	protected SceneSetting _sceneSetting;

	public void InitSceneSetting(SceneSetting pSceneSetting)
	{
		if (_sceneSetting == null)
		{
			_sceneSetting = pSceneSetting;
			InitOriginData(pSceneSetting);
		}
	}

	protected abstract void InitOriginData(SceneSetting pSceneSetting);
}
