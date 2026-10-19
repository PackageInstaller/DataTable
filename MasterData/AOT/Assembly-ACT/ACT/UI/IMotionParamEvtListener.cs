using ACT.Event;

namespace ACT.UI;

public interface IMotionParamEvtListener
{
	void OnBoolParamChange(MotionBoolParamChangeEvt evt);

	void OnIntParamChange(MotionIntParamChangeEvt evt);
}
