using System;
using Ase.ECS;
using Unity.Mathematics;
using UnityEngine;

namespace Ase;

public class DropGood : MonoBehaviour
{
	private DropSystem.DropGoodEffectData effectData;

	private GameObject effectGameObject;

	private Transform targetTransform;

	private DRDropPerformance drDropPerformance;

	private float countDown;

	private float groudHeight;

	private bool countDownEnd;

	private bool dropOnGround;

	private EventHandler<DropSystem.DropGoodEffectData> callBack;

	private bool isNotify;

	private int idx;

	private float delta = 2f;

	private float ShotSpeed = 5f;

	private float time;

	private Vector3 endPoint;

	private float g = -9f;

	private float dTime;

	private Vector3 initSpeed;

	private Vector3 Gravity;

	private Vector3 angele;

	public bool IsEmpty => effectGameObject == null;

	public void Init(DropSystem.DropGoodEffectData effectData, Transform targetTransform, float groudHeight, EventHandler<DropSystem.DropGoodEffectData> callBack)
	{
		this.effectData = effectData;
		dropOnGround = false;
		countDownEnd = false;
		this.groudHeight = groudHeight;
		countDown = 0f;
		this.targetTransform = targetTransform;
		isNotify = false;
		this.callBack = callBack;
	}

	public async void LoadEffect()
	{
		if (effectData != null)
		{
			drDropPerformance = GameEntry.DataTable.GetDataRow<DRDropPerformance>(effectData.dropEffectId);
			if (drDropPerformance != null)
			{
				effectGameObject = UnityEngine.Object.Instantiate(await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset(drDropPerformance.ResourcePath)), base.transform, worldPositionStays: true);
				effectGameObject.transform.localPosition = Vector3.zero;
				effectGameObject.transform.rotation = quaternion.op_Implicit(quaternion.identity);
				StartDropMove();
			}
		}
	}

	private void Update()
	{
		if (!IsEmpty)
		{
			if (!dropOnGround)
			{
				DropMoveUpdate(Time.deltaTime);
			}
			else if (!countDownEnd)
			{
				StartCountDown(Time.deltaTime);
			}
			else
			{
				CollectByTarget(Time.deltaTime);
			}
		}
	}

	private void StartCountDown(float deltaTime)
	{
		countDown += deltaTime;
		if (countDown >= drDropPerformance.StayTime)
		{
			countDownEnd = true;
		}
	}

	private void CollectByTarget(float deltaTime)
	{
		idx++;
		if (targetTransform == null)
		{
			isNotify = true;
			if (callBack != null)
			{
				callBack(base.gameObject, effectData);
			}
			return;
		}
		Vector3 vector = (targetTransform.position - base.transform.position).normalized * delta * deltaTime * (drDropPerformance.DropSpeed + (float)idx * 0.2f);
		float magnitude = (targetTransform.position - base.transform.position).magnitude;
		if (vector.magnitude > magnitude)
		{
			base.transform.position = targetTransform.position;
		}
		else
		{
			base.transform.position += vector;
		}
		CheckDistance();
	}

	private void CheckDistance()
	{
		if (!isNotify && Vector2.Distance(targetTransform.position, base.transform.position) < 0.3f)
		{
			isNotify = true;
			if (callBack != null)
			{
				callBack(base.gameObject, effectData);
			}
		}
	}

	private void StartDropMove()
	{
		Vector2 vector = UnityEngine.Random.insideUnitCircle * 1.5f;
		Vector2 vector2 = vector.normalized * (3f + vector.magnitude);
		Vector3 vector3 = new Vector3(vector2.x, 1f, vector2.y);
		endPoint = vector3 + base.transform.position;
		time = Vector3.Distance(base.transform.position, endPoint) / ShotSpeed * 2f;
		initSpeed = new Vector3((endPoint.x - base.transform.position.x) / time, (endPoint.y - base.transform.position.y) / time - 0.5f * g * time, (endPoint.z - base.transform.position.z) / time);
		Gravity = Vector3.zero;
	}

	public void DropMoveUpdate(float deltaTime)
	{
		Gravity.y = g * (dTime += deltaTime * 3f);
		Vector3 position = base.transform.position + (initSpeed + Gravity) * deltaTime;
		angele.x = (0f - Mathf.Atan((initSpeed.y + Gravity.y) / initSpeed.z)) * 57.29578f;
		dropOnGround = position.y < groudHeight + 0.2f;
		if (!dropOnGround)
		{
			base.transform.rotation = Quaternion.Euler(angele);
			base.transform.position = position;
		}
	}

	public void DestroySelf()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}

	private void OnDestroy()
	{
		GameEntry.Resource.UnloadAsset(AssetUtility.GetEntityAsset(drDropPerformance.ResourcePath));
	}
}
