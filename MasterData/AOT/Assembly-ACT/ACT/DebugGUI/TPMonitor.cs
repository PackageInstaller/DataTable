using UnityEngine;

namespace ACT.DebugGUI;

public class TPMonitor : EntityBehaveMonitor
{
	public int curTPIndex;

	[SerializeField]
	private int _chunkId;

	private DebugGUIField tp;

	protected override bool OnInit()
	{
		tp = new DebugGUIField("传送功能");
		TPTextChange();
		ebwnd.AddGUI(tp);
		ebwnd.AddGUI(new DebugGUIBeginHorizontal());
		ebwnd.AddGUI(new DebugGUIButton("上一个坐标点", () =>
		{
			if (DebugWindowManager.instance.TP.Count > 0)
			{
				curTPIndex--;
				if (curTPIndex == -1)
				{
					curTPIndex = DebugWindowManager.instance.TP.Count - 1;
				}
				DebugWindowManager.TPBehave(eb, DebugWindowManager.instance.TP[curTPIndex], _chunkId);
				TPTextChange();
			}
		}));
		ebwnd.AddGUI(new DebugGUIButton("确认传送", () =>
		{
			if (curTPIndex < DebugWindowManager.instance.TP.Count)
			{
				DebugWindowManager.TPBehave(eb, DebugWindowManager.instance.TP[curTPIndex], _chunkId);
				TPTextChange();
			}
		}));
		ebwnd.AddGUI(new DebugGUIButton("下一个坐标点", () =>
		{
			if (DebugWindowManager.instance.TP.Count > 0)
			{
				curTPIndex++;
				DebugWindowManager.TPBehave(eb, DebugWindowManager.instance.TP[curTPIndex %= DebugWindowManager.instance.TP.Count], _chunkId);
				TPTextChange();
			}
		}));
		ebwnd.AddGUI(new DebugGUIEndHorizontal());
		return true;
	}

	private void TPTextChange()
	{
		if (DebugWindowManager.instance.TP.Count != 0)
		{
			tp.text = $"[{curTPIndex}]{DebugWindowManager.instance.TP[curTPIndex].name}:{DebugWindowManager.instance.TP[curTPIndex].position}";
		}
	}
}
