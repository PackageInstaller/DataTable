using System.Collections.Generic;

namespace T0World;

public class T0WorldDataBaseContext
{
	private Dictionary<string, int> recordCountData;

	private Dictionary<string, T0InterationDragBase> runDragEventData;

	private T0InterationBaseData exitRegisteEvent;

	public T0InterationBaseData ExitRegisteEvent
	{
		get
		{
			return exitRegisteEvent;
		}
		set
		{
			exitRegisteEvent = value;
		}
	}

	public void RecordCount(string key, int count = 1)
	{
		if (recordCountData == null)
		{
			recordCountData = new Dictionary<string, int>();
		}
		if (recordCountData.ContainsKey(key))
		{
			recordCountData[key] += count;
		}
		else
		{
			recordCountData[key] = count;
		}
	}

	public void RecordCountToData(string key, int count)
	{
		int recordCount = GetRecordCount(key);
		RecordCount(key, count - recordCount);
	}

	public int GetRecordCount(string key)
	{
		if (recordCountData != null && recordCountData.ContainsKey(key))
		{
			return recordCountData[key];
		}
		return 0;
	}

	public bool CheckIsHaveKey(string key)
	{
		return GetRecordCount(key) > 0;
	}

	public void AddRunDragEvent(string key, T0InterationDragBase dragEvent)
	{
		if (!runDragEventData.ContainsKey(key))
		{
			runDragEventData.Add(key, dragEvent);
		}
	}

	public void RemoveRunDragEvent(string key)
	{
		if (runDragEventData.ContainsKey(key))
		{
			runDragEventData.Remove(key);
		}
	}

	public void OnDragValueChange(string key, float value)
	{
		if (runDragEventData.ContainsKey(key))
		{
			runDragEventData[key]?.OnDragValueChange(value);
		}
	}

	public void OnDragValueAddChange(string key, float addValue)
	{
		if (runDragEventData.ContainsKey(key))
		{
			runDragEventData[key]?.OnDragValueAddChange(addValue);
		}
	}

	public void OnDragFinish(string key)
	{
		if (runDragEventData.ContainsKey(key))
		{
			runDragEventData[key]?.OnDragFinish();
		}
	}

	public void OnDragEnd(string key)
	{
		if (runDragEventData.ContainsKey(key))
		{
			runDragEventData[key]?.OnDragEnd();
		}
	}

	public virtual void Init()
	{
		recordCountData = new Dictionary<string, int>();
		runDragEventData = new Dictionary<string, T0InterationDragBase>();
	}

	public virtual void Dispose()
	{
		if (recordCountData != null)
		{
			recordCountData.Clear();
			recordCountData = null;
		}
		if (runDragEventData != null)
		{
			runDragEventData.Clear();
			runDragEventData = null;
		}
	}
}
