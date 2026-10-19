using System;
using UnityEngine.SceneManagement;

namespace Unity.VisualScripting;

[UnitSurtitle("Scene")]
public sealed class GetSceneVariable : GetVariableUnit, ISceneVariableUnit, IVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public GetSceneVariable()
	{
	}

	public GetSceneVariable(string defaultName)
		: base(defaultName)
	{
	}

	protected override VariableDeclarations GetDeclarations(Flow flow)
	{
		Scene? scene = flow.stack.scene;
		if (!scene.HasValue)
		{
			return null;
		}
		return Variables.Scene(scene.Value);
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
