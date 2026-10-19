using UnityEngine.Playables;

namespace ACT.UI;

public class MonoCgView : BaseUIView
{
	public PlayableDirector timeline;

	public void Skip()
	{
		timeline.Stop();
	}
}
