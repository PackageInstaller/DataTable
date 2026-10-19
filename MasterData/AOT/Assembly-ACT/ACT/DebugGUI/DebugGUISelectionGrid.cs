using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUISelectionGrid : DebugGUI
{
	public string label;

	public int selected;

	public string[] texts;

	public bool selectable;

	private bool m_ShowMenu;

	private Vector2 m_Pos;

	public DebugGUISelectionGrid()
	{
	}

	public DebugGUISelectionGrid(string label = "", bool selectable = true, string[] texts = null)
	{
		this.label = label;
		this.texts = texts;
		this.selectable = selectable;
	}

	public override void Draw()
	{
		GUILayout.BeginHorizontal();
		if (GUILayout.Button("▼"))
		{
			m_ShowMenu = !m_ShowMenu;
		}
		GUILayout.Label(label);
		if (texts != null && texts.Length != 0)
		{
			if (selected >= texts.Length)
			{
				selected = texts.Length - 1;
			}
			GUILayout.Label(texts[selected]);
		}
		GUILayout.EndHorizontal();
		if (!m_ShowMenu || texts == null || texts.Length == 0)
		{
			return;
		}
		using (new GUILayout.VerticalScope(GUILayout.MaxHeight(60f), GUILayout.MaxWidth(100f)))
		{
			if (selectable)
			{
				selected = GUILayout.SelectionGrid(selected, texts, 1);
			}
			else
			{
				GUILayout.SelectionGrid(selected, texts, 1);
			}
		}
	}
}
