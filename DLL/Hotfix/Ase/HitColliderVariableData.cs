using GameFramework;
using UnityEngine;

namespace Ase;

public class HitColliderVariableData : IReference
{
	[Tooltip("从1开始且默认值为1。0认为无效")]
	[SerializeField]
	private int weight = 1;

	[SerializeField]
	private float damageMagnification = 1f;

	[SerializeField]
	private float tenacityMagnification = 1f;

	[SerializeField]
	private int siteLevel;

	[SerializeField]
	private float damageCumulativeThreshold;

	private float currentDamageCumulative;

	private int hitEffectIndex;

	public Vector2 hitAngles = Vector2.zero;

	public string partName;

	private float _normalTouch;

	public float currentDamageCumulativeProcess
	{
		get
		{
			if (damageCumulativeThreshold != 0f)
			{
				return currentDamageCumulative / damageCumulativeThreshold;
			}
			return 0f;
		}
	}

	public int Weight => weight;

	public float DamageMagnification
	{
		get
		{
			if (!(damageMagnification <= 0f))
			{
				return damageMagnification;
			}
			return 0f;
		}
	}

	public float TenacityMagnification
	{
		get
		{
			if (!(tenacityMagnification <= 0f))
			{
				return tenacityMagnification;
			}
			return 0f;
		}
	}

	public int SiteLevel => siteLevel;

	public float NormalTouch => _normalTouch;

	public float DamageCumulativeThreshold => damageCumulativeThreshold;

	public int HitEffectIndex => hitEffectIndex;

	public bool IsHbPart => SiteLevel == 3;

	public HitColliderVariableData()
	{
		Clear();
	}

	public static HitColliderVariableData Create(string partName, int weight = 1, float damageMagnification = 1f, float tenacityMagnification = 1f, int siteLevel = 0, float normalTouch = 0f, float damageCumulativeThreshold = 0f, float currentDamageCumulative = 0f, Vector2 hitAngles = default(Vector2), int hitEffectIndex = 0)
	{
		HitColliderVariableData hitColliderVariableData = ReferencePool.Acquire<HitColliderVariableData>();
		hitColliderVariableData.partName = partName;
		hitColliderVariableData.weight = weight;
		hitColliderVariableData.damageMagnification = damageMagnification;
		hitColliderVariableData.tenacityMagnification = tenacityMagnification;
		hitColliderVariableData.siteLevel = siteLevel;
		hitColliderVariableData._normalTouch = normalTouch;
		hitColliderVariableData.damageCumulativeThreshold = damageCumulativeThreshold;
		hitColliderVariableData.currentDamageCumulative = currentDamageCumulative;
		hitColliderVariableData.hitAngles = hitAngles;
		hitColliderVariableData.hitEffectIndex = hitEffectIndex;
		return hitColliderVariableData;
	}

	public void SetCurrentDamageCumulative(float value)
	{
		currentDamageCumulative = value;
	}

	public override string ToString()
	{
		return "受击盒名： " + partName + "\n" + $"受击盒计算参数:权重 {weight}\n" + $"伤害倍率 {DamageMagnification}\n" + $"削韧倍率 {TenacityMagnification}\n" + $"受击盒部位等级 {siteLevel}\n" + $"部位累计伤害阈值 {damageCumulativeThreshold}\n" + $"当前部位累计伤害 {currentDamageCumulative}\n" + $"受击角度: {hitAngles}\n";
	}

	public void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		partName = "";
		weight = 1;
		damageMagnification = 1f;
		tenacityMagnification = 1f;
		siteLevel = 0;
		damageCumulativeThreshold = 0f;
		currentDamageCumulative = 0f;
		hitAngles = Vector2.zero;
	}
}
