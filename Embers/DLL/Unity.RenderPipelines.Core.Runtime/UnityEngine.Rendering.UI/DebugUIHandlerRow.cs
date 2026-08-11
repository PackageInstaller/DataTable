namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerRow : DebugUIHandlerFoldout
{
	private float m_Timer;

	protected override void OnEnable()
	{
		m_Timer = 0f;
	}

	protected void Update()
	{
		DebugUI.Table.Row row = CastWidget<DebugUI.Table.Row>();
		DebugUI.Table table = row.parent as DebugUI.Table;
		float num = 0.1f;
		bool flag = m_Timer >= num;
		if (flag)
		{
			m_Timer -= num;
		}
		m_Timer += Time.deltaTime;
		for (int i = 0; i < row.children.Count; i++)
		{
			GameObject gameObject = base.gameObject.transform.GetChild(1).GetChild(i).gameObject;
			bool columnVisibility = table.GetColumnVisibility(i);
			gameObject.SetActive(columnVisibility);
			if (columnVisibility & flag)
			{
				if (gameObject.TryGetComponent<DebugUIHandlerColor>(out var component))
				{
					component.UpdateColor();
				}
				if (gameObject.TryGetComponent<DebugUIHandlerToggle>(out var component2))
				{
					component2.UpdateValueLabel();
				}
			}
		}
		DebugUIHandlerWidget debugUIHandlerWidget = base.gameObject.transform.GetChild(1).GetChild(0).gameObject.GetComponent<DebugUIHandlerWidget>();
		DebugUIHandlerWidget debugUIHandlerWidget2 = null;
		for (int j = 0; j < row.children.Count; j++)
		{
			debugUIHandlerWidget.previousUIHandler = debugUIHandlerWidget2;
			if (table.GetColumnVisibility(j))
			{
				debugUIHandlerWidget2 = debugUIHandlerWidget;
			}
			bool flag2 = false;
			for (int k = j + 1; k < row.children.Count; k++)
			{
				if (table.GetColumnVisibility(k))
				{
					DebugUIHandlerWidget debugUIHandlerWidget3 = (debugUIHandlerWidget.nextUIHandler = base.gameObject.transform.GetChild(1).GetChild(k).gameObject.GetComponent<DebugUIHandlerWidget>());
					debugUIHandlerWidget = debugUIHandlerWidget3;
					j = k - 1;
					flag2 = true;
					break;
				}
			}
			if (!flag2)
			{
				debugUIHandlerWidget.nextUIHandler = null;
				break;
			}
		}
	}
}
