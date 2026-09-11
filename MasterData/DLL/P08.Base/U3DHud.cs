using System;
using UnityEngine;

[ExecuteInEditMode]
public class U3DHud : MonoBehaviour
{
	public float mOffset = 0.01f;

	public int mWidth = 1920;

	public int mHeight = 1080;

	public Transform mTest;

	public Transform mIndicator;

	private float mAspect;

	private float mScale = 1f;

	private float mDistance = 1f;

	private float mRealHeight = 1080f;

	private static U3DHud instance;

	public static U3DHud mInstance => instance;

	private void Awake()
	{
		instance = this;
		Rebuild(isForce: true);
	}

	private void Update()
	{
		Rebuild();
	}

	private void Rebuild(bool isForce = false)
	{
		float num = (mAspect = Camera.main.aspect);
		Resolution resolution = new Resolution
		{
			width = mWidth,
			height = mHeight
		};
		mRealHeight = resolution.height;
		if (num * (float)resolution.height < (float)resolution.width)
		{
			mRealHeight = (int)((float)resolution.width / num);
		}
		mDistance = Camera.main.nearClipPlane + mOffset;
		mScale = Mathf.Tan(0.5f * Camera.main.fieldOfView * (MathF.PI / 180f)) * mDistance * 2f / mRealHeight;
		base.transform.localPosition = new Vector3(base.transform.localPosition.x, base.transform.localPosition.y, mDistance);
		base.transform.localScale = new Vector3(mScale, mScale, mScale);
	}

	public Vector3 ConverHUDWorld(Vector3 position)
	{
		Vector3 result = Camera.main.transform.InverseTransformPoint(position);
		float y = result.y * mDistance / (result.z * mScale);
		float x = result.x * mDistance / (result.z * mScale);
		result.x = x;
		result.y = y;
		result.z = 0f;
		return result;
	}

	public void SetHUDPosition(Transform target, Vector3 position)
	{
		target.localPosition = ConverHUDWorld(position);
		target.localScale = Vector3.one;
		target.localRotation = Quaternion.identity;
	}

	public void AddChild(Transform child)
	{
		Vector3 position = child.position;
		child.parent = base.transform;
		SetHUDPosition(child, position);
		child.localScale = Vector3.one;
		child.localRotation = Quaternion.identity;
	}

	public void AddChild(Transform child, Vector3 position)
	{
		child.parent = base.transform;
		SetHUDPosition(child, position);
		child.localScale = Vector3.one;
		child.localRotation = Quaternion.identity;
	}

	public void RomoveChild(Transform child)
	{
		child.parent = null;
	}

	private void OnDrawGizmos()
	{
		if (mTest != null)
		{
			Rebuild();
			Vector3 localPosition = ConverHUDWorld(mTest.position + new Vector3(0f, 2.5f, 0f));
			localPosition.z = 0f;
			mIndicator.localPosition = localPosition;
		}
	}

	public void SetWidthAndHeight(int width, int height)
	{
		mWidth = width;
		mHeight = height;
		Rebuild(isForce: true);
	}
}
