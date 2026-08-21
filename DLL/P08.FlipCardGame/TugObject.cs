using UnityEngine;

public class TugObject : MonoBehaviour
{
	private float speedChange;

	[Tooltip("敌人基础速度")]
	[Header("敌人基础速度")]
	public float constSpeed = 1f;

	public float[] skillSpeed1 = new float[1];

	[Tooltip("能量")]
	[Header("能量")]
	public float anger;

	[Tooltip("能量上限值")]
	[Header("能量上限值")]
	public float angerMax;

	private float speed;

	private float rage;

	private float Speed
	{
		get
		{
			return speed;
		}
		set
		{
			speed = value;
		}
	}

	public float Rage
	{
		get
		{
			return rage;
		}
		set
		{
			rage = value;
		}
	}

	private void Start()
	{
	}

	public void SetSpeed(float value)
	{
		Debug.Log(" moomao速度 " + speed + " " + value + " " + (speed + value));
		speed += value;
	}

	private void Update()
	{
	}

	public float GetEnemySpeed()
	{
		float num = constSpeed;
		for (int i = 0; i < skillSpeed1.Length; i++)
		{
			num += skillSpeed1[i];
		}
		return num;
	}
}
