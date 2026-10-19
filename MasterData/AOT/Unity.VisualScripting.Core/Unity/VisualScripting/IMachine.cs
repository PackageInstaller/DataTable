using UnityEngine;

namespace Unity.VisualScripting;

public interface IMachine : IGraphRoot, IGraphParent, IGraphNester, IAotStubbable
{
	IGraphData graphData { get; set; }

	GameObject threadSafeGameObject { get; }
}
