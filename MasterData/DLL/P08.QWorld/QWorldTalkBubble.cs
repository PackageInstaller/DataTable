using Sirenix.OdinInspector;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

[ExecuteInEditMode]
public class QWorldTalkBubble : SerializedMonoBehaviour
{
	public enum ResizeBgFunc
	{
		ByBounds,
		ByTextBounds,
		ByRectTrsSize
	}

	public TMP_Text textCom;

	public SpriteRenderer bg;

	public RectTransform bgReferanceRectTrs;

	[SerializeField]
	private RectTransform layoutRoot;

	public ResizeBgFunc bgResizeFunc;

	public float sizeFactor = 1f;

	public RectTransform LayoutRoot
	{
		get
		{
			if (!layoutRoot)
			{
				return bgReferanceRectTrs;
			}
			return layoutRoot;
		}
	}

	public string text
	{
		get
		{
			if (!textCom)
			{
				return null;
			}
			return textCom.text;
		}
		set
		{
			if ((bool)textCom)
			{
				textCom.text = value;
			}
			ResizeBg();
		}
	}

	private Bounds GetBgSpriteSize(ResizeBgFunc resizeFunc)
	{
		switch (resizeFunc)
		{
		case ResizeBgFunc.ByBounds:
			return textCom.bounds;
		case ResizeBgFunc.ByTextBounds:
			return textCom.textBounds;
		case ResizeBgFunc.ByRectTrsSize:
			if ((bool)bgReferanceRectTrs)
			{
				return new Bounds(Vector3.zero, new Vector3(bgReferanceRectTrs.rect.width, bgReferanceRectTrs.rect.height, 0f));
			}
			break;
		}
		return default(Bounds);
	}

	public void ResizeBg()
	{
		if ((bool)textCom && (bool)bg)
		{
			textCom.ForceMeshUpdate(ignoreActiveState: true);
			if (bgResizeFunc == ResizeBgFunc.ByRectTrsSize && (bool)LayoutRoot)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(LayoutRoot);
			}
			Bounds bgSpriteSize = GetBgSpriteSize(bgResizeFunc);
			bg.size = bgSpriteSize.size;
			RectTransform obj = (RectTransform)bg.transform;
			obj.localScale = Vector3.one;
			obj.SetSizeDelta(bg.size);
			obj.localPosition = bgSpriteSize.center;
		}
	}

	private void OnResizeBg(TMP_TextInfo info)
	{
		ResizeBg();
	}

	private void OnEnable()
	{
		_ = (bool)textCom;
	}

	private void OnDisable()
	{
		_ = (bool)textCom;
	}

	private void LateUpdate()
	{
		if (Application.IsPlaying(this))
		{
			base.transform.rotation = QWorldCameraManager.Instance.MainCamera.transform.rotation;
			float num = Mathf.Max(0f, QWorldCameraManager.Instance.MainCamera.transform.InverseTransformPoint(base.transform.position).z) * sizeFactor;
			base.transform.localScale = 0.1f * num * Vector3.one;
		}
	}
}
