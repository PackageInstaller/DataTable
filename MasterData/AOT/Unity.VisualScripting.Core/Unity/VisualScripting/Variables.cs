using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Unity.VisualScripting;

[IncludeInSettings(false)]
[DisableAnnotation]
[AddComponentMenu("Visual Scripting/Variables")]
public class Variables : LudiqBehaviour, IAotStubbable
{
	[Inspectable]
	[Serialize]
	public VariableDeclarations declarations { get; internal set; } = new VariableDeclarations
	{
		Kind = VariableKind.Object
	};

	public static VariableDeclarations ActiveScene => Scene(SceneManager.GetActiveScene());

	public static VariableDeclarations Application => ApplicationVariables.current;

	public static VariableDeclarations Saved => SavedVariables.current;

	public static bool ExistInActiveScene => ExistInScene(SceneManager.GetActiveScene());

	public static VariableDeclarations Graph(GraphPointer pointer)
	{
		Ensure.That("pointer").IsNotNull(pointer);
		if (pointer.hasData)
		{
			return GraphInstance(pointer);
		}
		return GraphDefinition(pointer);
	}

	public static VariableDeclarations GraphInstance(GraphPointer pointer)
	{
		return pointer.GetGraphData<IGraphDataWithVariables>().variables;
	}

	public static VariableDeclarations GraphDefinition(GraphPointer pointer)
	{
		return GraphDefinition((IGraphWithVariables)pointer.graph);
	}

	public static VariableDeclarations GraphDefinition(IGraphWithVariables graph)
	{
		return graph.variables;
	}

	public static VariableDeclarations Object(GameObject go)
	{
		return go.GetOrAddComponent<Variables>().declarations;
	}

	public static VariableDeclarations Object(Component component)
	{
		return Object(component.gameObject);
	}

	public static VariableDeclarations Scene(Scene? scene)
	{
		return SceneVariables.For(scene);
	}

	public static VariableDeclarations Scene(GameObject go)
	{
		return Scene(go.scene);
	}

	public static VariableDeclarations Scene(Component component)
	{
		return Scene(component.gameObject);
	}

	public static bool ExistOnObject(GameObject go)
	{
		return go.GetComponent<Variables>() != null;
	}

	public static bool ExistOnObject(Component component)
	{
		return ExistOnObject(component.gameObject);
	}

	public static bool ExistInScene(Scene? scene)
	{
		if (scene.HasValue)
		{
			return SceneVariables.InstantiatedIn(scene.Value);
		}
		return false;
	}

	[ContextMenu("Show Data...")]
	protected override void ShowData()
	{
		base.ShowData();
	}

	public IEnumerable<object> GetAotStubs(HashSet<object> visited)
	{
		foreach (VariableDeclaration declaration in declarations)
		{
			ConstructorInfo constructorInfo = declaration.value?.GetType().GetPublicDefaultConstructor();
			if (constructorInfo != null)
			{
				yield return constructorInfo;
			}
		}
	}
}
