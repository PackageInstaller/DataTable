using System;
using ACT.Battle;

namespace ACT.MissionSystem;

[Serializable]
public class SetInputStateActionParam
{
	public InputKey key;

	public bool active;
}
