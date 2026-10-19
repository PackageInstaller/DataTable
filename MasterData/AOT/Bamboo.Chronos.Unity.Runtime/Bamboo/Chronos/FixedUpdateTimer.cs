using Bamboo.HeartBeat;

namespace Bamboo.Chronos;

public class FixedUpdateTimer : Timer
{
	private static FixedUpdateTimer _default;

	public static FixedUpdateTimer Default
	{
		get
		{
			if (_default == null)
			{
				_default = new FixedUpdateTimer();
			}
			return _default;
		}
	}

	public FixedUpdateTimer()
		: base(BaseDriver<FixedUpdateTimeDriver>.Instance.NewBeat(), BaseDriver<FixedUpdateFrameDriver>.Instance.NewBeat())
	{
	}
}
