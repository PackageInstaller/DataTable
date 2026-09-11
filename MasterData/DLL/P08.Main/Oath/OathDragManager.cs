using System.Collections.Generic;
using Sirenix.OdinInspector;

namespace Oath;

public class OathDragManager : SerializedMonoBehaviour
{
	public Dictionary<string, OathInteractionDrag> runDragEventDic;

	public void Init()
	{
		runDragEventDic = new Dictionary<string, OathInteractionDrag>();
	}

	public void AddRunDragEvent(string key, OathInteractionDrag dragEvent)
	{
		if (!runDragEventDic.ContainsKey(key))
		{
			runDragEventDic.Add(key, dragEvent);
		}
	}

	public void OnDragValueChange(string key, float value)
	{
		runDragEventDic[key]?.OnDragValueChange(value);
	}

	public void OnDragFinish(string key)
	{
		runDragEventDic[key]?.OnDragFinish();
	}

	public void OnDragEnd(string key)
	{
		runDragEventDic[key]?.OnDragEnd();
	}

	public void Dispose()
	{
		if (runDragEventDic != null)
		{
			runDragEventDic.Clear();
			runDragEventDic = null;
		}
	}
}
