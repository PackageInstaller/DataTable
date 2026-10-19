using UnityEngine;

namespace Unity.VisualScripting;

public interface IGraphParent
{
	IGraph childGraph { get; }

	bool isSerializationRoot { get; }

	Object serializedObject { get; }

	IGraph DefaultGraph();
}
