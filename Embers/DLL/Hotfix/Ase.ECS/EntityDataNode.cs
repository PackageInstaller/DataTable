using GameFramework;

namespace Ase.ECS;

public class EntityDataNode : IReference
{
	public string configId;

	public string markType;

	public float maxTime;

	public float curTime;

	public int curLayer;

	public bool isActive;

	public int type;

	public MarkTimeType markTimeType;

	public BaseEntity entity;

	private DataNodeBase data;

	public DataNodeBase GetData => data;

	public void ResetData<T>(IDataNodeValue<T> value)
	{
		if (value != null)
		{
			value.SetValue(value);
			data = (DataNodeBase)value;
		}
	}

	public void OnUpdate(float deltaTime)
	{
		if (!isActive || markTimeType == MarkTimeType.None || curTime == -1f)
		{
			return;
		}
		curTime += deltaTime;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"EntityDataNode configId {configId} curTime {curTime}", entity);
		}
		if (!(curTime >= maxTime))
		{
			return;
		}
		curTime -= maxTime;
		if (markTimeType == MarkTimeType.TimerIsLayerTimer)
		{
			curLayer--;
			if (curLayer <= 0)
			{
				isActive = false;
			}
		}
		else
		{
			isActive = false;
		}
	}

	public void Clear()
	{
		configId = string.Empty;
		markType = string.Empty;
		maxTime = 0f;
		curTime = 0f;
		curLayer = 0;
		isActive = false;
		markTimeType = MarkTimeType.None;
		data = null;
		entity = null;
	}
}
