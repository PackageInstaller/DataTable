using ACT.Config;

namespace ACT.Model;

public class VideoStepData : GuideStepData
{
	private int _guideTableId;

	public int GuideTableId => _guideTableId;

	public VideoStepData(VideoStepConfig config, int index)
		: base(config, index)
	{
		_guideTableId = config.guideTableId;
		_successCondition = new VideoOverSC();
	}

	public override void OnStart()
	{
	}

	public override void OnFinish()
	{
	}
}
