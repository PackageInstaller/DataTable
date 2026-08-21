using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Debug Log", 0)]
[Category("✫ Utility")]
[Description("Display a UI label on the agent's position if seconds to run is not 0 and also logs the message, which can also be mapped to any variable.")]
public class DebugLogText : ActionTask<Transform>
{
}
