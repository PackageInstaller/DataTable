using System;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Conversation;

public abstract class ConversationSceneBg
{
	public abstract int BgId { get; }

	public abstract float OriginalZOffset { get; set; }

	protected abstract Vector3 OriginalSize { get; }

	protected abstract Vector3 OriginalScale { get; }

	public abstract bool IsShow { get; }

	public float BaseScaleFactor { get; private set; } = 1f;

	public float ScaleFactor { get; set; } = 1f;

	public Vector2 PivotOffset { get; set; } = Vector2.zero;

	public static float CalScaleFactor(Camera cam, float fov, float zOffset, Vector3 originalSize)
	{
		float num = Mathf.Abs(zOffset);
		float num2 = 2f * num * Mathf.Tan(fov * 0.5f * (MathF.PI / 180f));
		return Mathf.Max(num2 * cam.aspect / originalSize.x, num2 / originalSize.y) * 1f;
	}

	private Vector3 GetRealSize()
	{
		Vector3 result = OriginalSize * BaseScaleFactor * ScaleFactor;
		result.z = 1f;
		return result;
	}

	private Vector3 GetRealScale()
	{
		Vector3 result = OriginalScale * BaseScaleFactor * ScaleFactor;
		result.z = 1f;
		return result;
	}

	private Vector3 GetRealPosition()
	{
		Vector3 realSize = GetRealSize();
		return new Vector3(realSize.x * PivotOffset.x, realSize.y * PivotOffset.y, OriginalZOffset);
	}

	public void Update(Camera cam, float baseFov)
	{
		OnUpdate(cam);
		BaseScaleFactor = CalScaleFactor(cam, baseFov, OriginalZOffset, OriginalSize);
		SetScale(GetRealScale());
		SetPosition(GetRealPosition());
	}

	public abstract UniTask Show();

	public abstract void HideAndRelease();

	protected virtual void OnUpdate(Camera cam)
	{
	}

	protected abstract void SetScale(Vector3 scale);

	protected abstract void SetPosition(Vector3 position);

	public abstract void SetOrder(int sortingOrder);
}
