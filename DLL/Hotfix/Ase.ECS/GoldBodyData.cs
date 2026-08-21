using GameFramework;

namespace Ase.ECS;

public class GoldBodyData : IReference
{
	private float _Time;

	private float _timer;

	private int attackPower;

	public int AttackPower => attackPower;

	public bool IsEnd => _timer >= _Time;

	public float GoldTime { get; private set; }

	public float GoldBodySize { get; private set; }

	public float GoldBodyOriData { get; private set; }

	public float GoldBodyDelta { get; private set; }

	public float GoldDisappearTime { get; private set; }

	public static GoldBodyData Create(int power, BaseEntity entity)
	{
		GoldBodyData goldBodyData = ReferencePool.Acquire<GoldBodyData>();
		goldBodyData._Time = entity.GetWorld().GoldBodySettings.GoldTime;
		goldBodyData._timer = 0f;
		goldBodyData.attackPower = power;
		goldBodyData.GoldTime = entity.GetWorld().GoldBodySettings.GoldTime;
		goldBodyData.GoldBodySize = entity.GetWorld().GoldBodySettings.GoldBodySize;
		goldBodyData.GoldBodyOriData = entity.GetWorld().GoldBodySettings.GoldBodyOriData;
		goldBodyData.GoldBodyDelta = entity.GetWorld().GoldBodySettings.GoldBodyDelta;
		goldBodyData.GoldDisappearTime = entity.GetWorld().GoldBodySettings.GoldDisappearTime;
		return goldBodyData;
	}

	public void OnUpdate(float deltaTime)
	{
		if (!(_timer >= _Time))
		{
			_timer += deltaTime;
		}
	}

	public void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		_Time = 0f;
		_timer = 0f;
		attackPower = -1;
	}
}
