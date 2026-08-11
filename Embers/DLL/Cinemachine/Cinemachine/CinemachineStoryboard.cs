using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Cinemachine;

[ExecuteAlways]
[DisallowMultipleComponent]
[AddComponentMenu("")]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineStoryboard.html")]
[SaveDuringPlay]
public class CinemachineStoryboard : CinemachineExtension
{
	public enum FillStrategy
	{
		BestFit,
		CropImageToFit,
		StretchToFit
	}

	private class CanvasInfo
	{
		public GameObject mCanvas;

		public Canvas mCanvasComponent;

		public CinemachineBrain mCanvasParent;

		public RectTransform mViewport;

		public RawImage mRawImage;
	}

	public enum StoryboardRenderMode
	{
		ScreenSpaceOverlay,
		ScreenSpaceCamera
	}

	[Tooltip("If checked, all storyboards are globally muted")]
	public static bool s_StoryboardGlobalMute;

	[Tooltip("If checked, the specified image will be displayed as an overlay over the virtual camera's output")]
	public bool m_ShowImage = true;

	[Tooltip("The image to display")]
	public Texture m_Image;

	[Tooltip("How to handle differences between image aspect and screen aspect")]
	public FillStrategy m_Aspect;

	[Range(0f, 1f)]
	[Tooltip("The opacity of the image.  0 is transparent, 1 is opaque")]
	public float m_Alpha = 1f;

	[Tooltip("The screen-space position at which to display the image.  Zero is center")]
	public Vector2 m_Center = Vector2.zero;

	[Tooltip("The screen-space rotation to apply to the image")]
	public Vector3 m_Rotation = Vector3.zero;

	[Tooltip("The screen-space scaling to apply to the image")]
	public Vector2 m_Scale = Vector3.one;

	[Tooltip("If checked, X and Y scale are synchronized")]
	public bool m_SyncScale = true;

	[Tooltip("If checked, Camera transform will not be controlled by this virtual camera")]
	public bool m_MuteCamera;

	[Range(-1f, 1f)]
	[Tooltip("Wipe the image on and off horizontally")]
	public float m_SplitView;

	[Tooltip("The render mode of the canvas on which the storyboard is drawn.")]
	public StoryboardRenderMode m_RenderMode;

	[Tooltip("Allows ordering canvases to render on top or below other canvases.")]
	public int m_SortingOrder;

	[Tooltip("How far away from the camera is the Canvas generated.")]
	public float m_PlaneDistance = 100f;

	private List<CanvasInfo> mCanvasInfo = new List<CanvasInfo>();

	private string CanvasName => "_CM_canvas" + base.gameObject.GetInstanceID();

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (!(vcam != base.VirtualCamera) && stage == CinemachineCore.Stage.Finalize)
		{
			UpdateRenderCanvas();
			if (m_ShowImage)
			{
				state.AddCustomBlendable(new CameraState.CustomBlendable(this, 1f));
			}
			if (m_MuteCamera)
			{
				state.BlendHint |= (CameraState.BlendHintValue)67;
			}
		}
	}

	private void UpdateRenderCanvas()
	{
		for (int i = 0; i < mCanvasInfo.Count; i++)
		{
			if (mCanvasInfo[i] == null || (Object)(object)mCanvasInfo[i].mCanvasComponent == null)
			{
				mCanvasInfo.RemoveAt(i--);
				continue;
			}
			mCanvasInfo[i].mCanvasComponent.renderMode = (RenderMode)m_RenderMode;
			mCanvasInfo[i].mCanvasComponent.planeDistance = m_PlaneDistance;
			mCanvasInfo[i].mCanvasComponent.sortingOrder = m_SortingOrder;
		}
	}

	protected override void ConnectToVcam(bool connect)
	{
		base.ConnectToVcam(connect);
		CinemachineCore.CameraUpdatedEvent.RemoveListener(CameraUpdatedCallback);
		if (connect)
		{
			CinemachineCore.CameraUpdatedEvent.AddListener(CameraUpdatedCallback);
		}
		else
		{
			DestroyCanvas();
		}
	}

	private void CameraUpdatedCallback(CinemachineBrain brain)
	{
		bool flag = base.enabled && m_ShowImage && CinemachineCore.Instance.IsLive(base.VirtualCamera);
		int num = 1 << base.gameObject.layer;
		if (brain.OutputCamera == null || (brain.OutputCamera.cullingMask & num) == 0)
		{
			flag = false;
		}
		if (s_StoryboardGlobalMute)
		{
			flag = false;
		}
		CanvasInfo canvasInfo = LocateMyCanvas(brain, flag);
		if (canvasInfo != null && canvasInfo.mCanvas != null)
		{
			canvasInfo.mCanvas.SetActive(flag);
		}
	}

	private CanvasInfo LocateMyCanvas(CinemachineBrain parent, bool createIfNotFound)
	{
		CanvasInfo canvasInfo = null;
		int num = 0;
		while (canvasInfo == null && num < mCanvasInfo.Count)
		{
			if (mCanvasInfo[num] != null && mCanvasInfo[num].mCanvasParent == parent)
			{
				canvasInfo = mCanvasInfo[num];
			}
			num++;
		}
		if (createIfNotFound)
		{
			if (canvasInfo == null)
			{
				canvasInfo = new CanvasInfo
				{
					mCanvasParent = parent
				};
				int childCount = parent.transform.childCount;
				int num2 = 0;
				while (canvasInfo.mCanvas == null && num2 < childCount)
				{
					RectTransform rectTransform = parent.transform.GetChild(num2) as RectTransform;
					if (rectTransform != null && rectTransform.name == CanvasName)
					{
						canvasInfo.mCanvas = rectTransform.gameObject;
						RectTransform[] componentsInChildren = canvasInfo.mCanvas.GetComponentsInChildren<RectTransform>();
						canvasInfo.mViewport = ((componentsInChildren.Length > 1) ? componentsInChildren[1] : null);
						canvasInfo.mRawImage = canvasInfo.mCanvas.GetComponentInChildren<RawImage>();
						canvasInfo.mCanvasComponent = canvasInfo.mCanvas.GetComponent<Canvas>();
					}
					num2++;
				}
				mCanvasInfo.Add(canvasInfo);
			}
			if (canvasInfo.mCanvas == null || canvasInfo.mViewport == null || canvasInfo.mRawImage == null || (Object)(object)canvasInfo.mCanvasComponent == null)
			{
				CreateCanvas(canvasInfo);
			}
		}
		return canvasInfo;
	}

	private void CreateCanvas(CanvasInfo ci)
	{
		ci.mCanvas = new GameObject(CanvasName, typeof(RectTransform));
		ci.mCanvas.layer = base.gameObject.layer;
		ci.mCanvas.hideFlags = HideFlags.HideAndDontSave;
		ci.mCanvas.transform.SetParent(ci.mCanvasParent.transform);
		Canvas obj = (ci.mCanvasComponent = ci.mCanvas.AddComponent<Canvas>());
		obj.renderMode = (RenderMode)m_RenderMode;
		obj.sortingOrder = m_SortingOrder;
		obj.planeDistance = m_PlaneDistance;
		obj.worldCamera = ci.mCanvasParent.OutputCamera;
		GameObject gameObject = new GameObject("Viewport", typeof(RectTransform));
		gameObject.transform.SetParent(ci.mCanvas.transform);
		ci.mViewport = (RectTransform)gameObject.transform;
		gameObject.AddComponent<RectMask2D>();
		gameObject = new GameObject("RawImage", typeof(RectTransform));
		gameObject.transform.SetParent(ci.mViewport.transform);
		ci.mRawImage = gameObject.AddComponent<RawImage>();
	}

	private void DestroyCanvas()
	{
		int brainCount = CinemachineCore.Instance.BrainCount;
		for (int i = 0; i < brainCount; i++)
		{
			CinemachineBrain activeBrain = CinemachineCore.Instance.GetActiveBrain(i);
			for (int num = activeBrain.transform.childCount - 1; num >= 0; num--)
			{
				RectTransform rectTransform = activeBrain.transform.GetChild(num) as RectTransform;
				if (rectTransform != null && rectTransform.name == CanvasName)
				{
					RuntimeUtility.DestroyObject(rectTransform.gameObject);
				}
			}
		}
		mCanvasInfo.Clear();
	}

	private void PlaceImage(CanvasInfo ci, float alpha)
	{
		if (!(ci.mRawImage != null) || !(ci.mViewport != null))
		{
			return;
		}
		Rect rect = new Rect(0f, 0f, Screen.width, Screen.height);
		if (ci.mCanvasParent.OutputCamera != null)
		{
			rect = ci.mCanvasParent.OutputCamera.pixelRect;
		}
		rect.x -= (float)Screen.width / 2f;
		rect.y -= (float)Screen.height / 2f;
		float num = (0f - Mathf.Clamp(m_SplitView, -1f, 1f)) * rect.width;
		Vector3 localPosition = rect.center;
		localPosition.x -= num / 2f;
		ci.mViewport.localPosition = localPosition;
		ci.mViewport.localRotation = Quaternion.identity;
		ci.mViewport.localScale = Vector3.one;
		ci.mViewport.ForceUpdateRectTransforms();
		ci.mViewport.sizeDelta = new Vector2(rect.width + 1f - Mathf.Abs(num), rect.height + 1f);
		Vector2 one = Vector2.one;
		if (m_Image != null && m_Image.width > 0 && m_Image.width > 0 && rect.width > 0f && rect.height > 0f)
		{
			float num2 = rect.height * (float)m_Image.width / (rect.width * (float)m_Image.height);
			switch (m_Aspect)
			{
			case FillStrategy.BestFit:
				if (num2 >= 1f)
				{
					one.y /= num2;
				}
				else
				{
					one.x *= num2;
				}
				break;
			case FillStrategy.CropImageToFit:
				if (num2 >= 1f)
				{
					one.x *= num2;
				}
				else
				{
					one.y /= num2;
				}
				break;
			}
		}
		one.x *= m_Scale.x;
		one.y *= (m_SyncScale ? m_Scale.x : m_Scale.y);
		ci.mRawImage.texture = m_Image;
		Color white = Color.white;
		white.a = m_Alpha * alpha;
		ci.mRawImage.color = white;
		localPosition = new Vector2(rect.width * m_Center.x, rect.height * m_Center.y);
		localPosition.x += num / 2f;
		ci.mRawImage.rectTransform.localPosition = localPosition;
		ci.mRawImage.rectTransform.localRotation = Quaternion.Euler(m_Rotation);
		ci.mRawImage.rectTransform.localScale = one;
		ci.mRawImage.rectTransform.ForceUpdateRectTransforms();
		ci.mRawImage.rectTransform.sizeDelta = rect.size;
	}

	private static void StaticBlendingHandler(CinemachineBrain brain)
	{
		CameraState currentCameraState = brain.CurrentCameraState;
		int numCustomBlendables = currentCameraState.NumCustomBlendables;
		for (int i = 0; i < numCustomBlendables; i++)
		{
			CameraState.CustomBlendable customBlendable = currentCameraState.GetCustomBlendable(i);
			CinemachineStoryboard cinemachineStoryboard = customBlendable.m_Custom as CinemachineStoryboard;
			if (!(cinemachineStoryboard == null))
			{
				bool createIfNotFound = true;
				int num = 1 << cinemachineStoryboard.gameObject.layer;
				if (brain.OutputCamera == null || (brain.OutputCamera.cullingMask & num) == 0)
				{
					createIfNotFound = false;
				}
				if (s_StoryboardGlobalMute)
				{
					createIfNotFound = false;
				}
				CanvasInfo canvasInfo = cinemachineStoryboard.LocateMyCanvas(brain, createIfNotFound);
				if (canvasInfo != null)
				{
					cinemachineStoryboard.PlaceImage(canvasInfo, customBlendable.m_Weight);
				}
			}
		}
	}

	[RuntimeInitializeOnLoadMethod]
	private static void InitializeModule()
	{
		CinemachineCore.CameraUpdatedEvent.RemoveListener(StaticBlendingHandler);
		CinemachineCore.CameraUpdatedEvent.AddListener(StaticBlendingHandler);
	}
}
