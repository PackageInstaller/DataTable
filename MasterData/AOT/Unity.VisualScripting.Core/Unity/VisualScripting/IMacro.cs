using UnityEngine;

namespace Unity.VisualScripting;

public interface IMacro : IGraphRoot, IGraphParent, ISerializationDependency, ISerializationCallbackReceiver, IAotStubbable
{
	IGraph graph { get; set; }
}
