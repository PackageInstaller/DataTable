using Bamboo.HeartBeat;

namespace Bamboo.Chronos;

public class UpdateTimer : Timer
{
	private static UpdateTimer _default;

	public static UpdateTimer Default
	{
		get
		{
			if (_default == null)
			{
				_default = new UpdateTimer();
			}
			return _default;
		}
	}

	public UpdateTimer()
		: base(BaseDriver<UpdateTimeDriver>.Instance.NewBeat(), BaseDriver<UpdateFrameDriver>.Instance.NewBeat())
	{
	}
}
