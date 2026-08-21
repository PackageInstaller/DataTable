using TMPro;
using UnityEngine;

public class QWorldNameHud : QWorldHudBase
{
	public TextMeshPro textComp;

	private Color black = Color.black;

	public void SetName(string text)
	{
		textComp.text = text;
	}

	public override void OnHide(float rate)
	{
		float a = textComp.color.a;
		float b = 0f;
		Color color = textComp.color;
		float a2 = (color.a = Mathf.Lerp(a, b, rate));
		black.a = a2;
		textComp.color = color;
	}

	public override void OnShow(float rate)
	{
		float a = textComp.color.a;
		float b = 1f;
		Color color = textComp.color;
		float a2 = (color.a = Mathf.Lerp(a, b, rate));
		black.a = a2;
		textComp.color = color;
	}

	public override void SetData(QWAgent agent, QWHudBehaviour hudBehaviour)
	{
		base.SetData(agent, hudBehaviour);
		SetName(agent.Blackboard.Name);
	}
}
