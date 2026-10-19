using ACT.Config;

namespace ACT.Model;

public class ImageStepData : GuideStepData
{
	private int _guideTableId;

	public int GuideTableId => _guideTableId;

	public ImageStepData(ImageStepConfig config, int index)
		: base(config, index)
	{
		_guideTableId = config.guideTableId;
		_successCondition = new ImageOverSC();
	}

	public override void OnStart()
	{
	}

	public override void OnFinish()
	{
	}
}
