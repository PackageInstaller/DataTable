using System.Collections.Generic;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[AddComponentMenu("Behavior Designer/Behavior Game GUI")]
public class BehaviorGameGUI : MonoBehaviour
{
	private BehaviorManager behaviorManager;

	private Camera mainCamera;

	public void Start()
	{
		mainCamera = Camera.main;
	}

	public void OnGUI()
	{
		if (behaviorManager == null)
		{
			behaviorManager = BehaviorManager.instance;
		}
		if (behaviorManager == null || mainCamera == null)
		{
			return;
		}
		List<BehaviorManager.BehaviorTree> behaviorTrees = behaviorManager.BehaviorTrees;
		for (int i = 0; i < behaviorTrees.Count; i++)
		{
			BehaviorManager.BehaviorTree behaviorTree = behaviorTrees[i];
			string text = "";
			for (int j = 0; j < behaviorTree.activeStack.Count; j++)
			{
				Stack<int> stack = behaviorTree.activeStack[j];
				if (stack.Count != 0 && behaviorTree.taskList[stack.Peek()] is Action)
				{
					text = text + behaviorTree.taskList[behaviorTree.activeStack[j].Peek()].FriendlyName + ((j < behaviorTree.activeStack.Count - 1) ? "\n" : "");
				}
			}
			Transform transform = behaviorTree.behavior.transform;
			Vector2 vector = GUIUtility.ScreenToGUIPoint(mainCamera.WorldToScreenPoint(transform.position));
			GUIContent content = new GUIContent(text);
			Vector2 vector2 = GUI.skin.label.CalcSize(content);
			vector2.x += 14f;
			vector2.y += 5f;
			GUI.Box(new Rect(vector.x - vector2.x / 2f, (float)Screen.height - vector.y + vector2.y / 2f, vector2.x, vector2.y), content);
		}
	}
}
