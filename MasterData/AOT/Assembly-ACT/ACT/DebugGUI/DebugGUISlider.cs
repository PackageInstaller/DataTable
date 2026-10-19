using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUISlider : DebugGUI
{
	public string label;

	public float value;

	public float leftValue;

	public float rightValue;

	public DebugGUISlider()
	{
	}

	public DebugGUISlider(string label, float value, float leftValue, float rightValue)
	{
		this.label = label;
		this.value = value;
		this.leftValue = leftValue;
		this.rightValue = rightValue;
	}

	public override void Draw()
	{
		GUILayout.BeginHorizontal();
		GUILayout.Label(label);
		value = GUILayout.HorizontalSlider(value, leftValue, rightValue);
		GUILayout.EndHorizontal();
	}
}
