using Fundamental;

namespace ACT.Battle;

public struct ButtonState
{
	public bool pressed;

	public bool currentFramePressed;

	public bool isPressedAtCurrentFrame;

	public float pressDuration;

	public Fire fire;

	public ActionList clickAction;

	public ActionList<int> stateChange;
}
