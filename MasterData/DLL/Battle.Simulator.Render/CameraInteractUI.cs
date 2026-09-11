using System;
using System.Collections;
using Cinemachine;
using FlowCanvas;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class CameraInteractUI : MonoBehaviour
{
	public LayerMask layer;

	public float scanDistance;

	public P08JoystickController joystickController;

	public Button scanButton;

	public Button chooseButton;

	public Button exitButton;

	private P08StickControllerCameraInteractLogic p08StickControllerCameraInteractLogic;

	public RectTransform scanArea;

	public Animator animator;

	public string scanStateName;

	public string scanFinishedStateName;

	public float updateInterval = 0.5f;

	public int scaningBattips = 1;

	public int noItemBattips = 2;

	public string m_cueSheet;

	public string m_cueName;

	public string m_cueNameStop;

	public bool m_useStream;

	public int cameraPriority = 11;

	public GameObject infoGO;

	public Text textName;

	public Text textDesc;

	public Image image;

	private float updateTiming;

	private CameraInteractItem cur;

	private Flow f;

	private FlowOutput startScanOut;

	private FlowOutput finishScanOut;

	private Action<Flow, FlowOutput> startScan;

	private Action<Flow, FlowOutput> finishScan;

	private bool scaning;

	private Collider[] colliders = new Collider[100];

	public GameObject tipsGO;

	public Text textTips;

	public float tipsTime = 2f;

	private float tipsTimeCountDown;

	public CinemachinePOV Composer
	{
		get
		{
			return p08StickControllerCameraInteractLogic.composer;
		}
		set
		{
			p08StickControllerCameraInteractLogic.composer = value;
		}
	}

	private void Awake()
	{
		if (p08StickControllerCameraInteractLogic == null)
		{
			p08StickControllerCameraInteractLogic = new P08StickControllerCameraInteractLogic();
			p08StickControllerCameraInteractLogic.InitAudioInfo(m_cueSheet, m_cueName, m_cueNameStop, m_useStream);
		}
		joystickController.Init(Vector3.zero, 0f, p08StickControllerCameraInteractLogic);
		scanButton.onClick.RemoveAllListeners();
		scanButton.onClick.AddListener(Scan);
		chooseButton.onClick.RemoveAllListeners();
		chooseButton.onClick.AddListener(Choose);
	}

	public void OnEnable()
	{
		if (Composer != null)
		{
			Composer.VirtualCamera.Priority = cameraPriority;
		}
		scaning = false;
	}

	public void OnDisable()
	{
		if (Composer != null)
		{
			Composer.VirtualCamera.Priority = 0;
			Composer.m_HorizontalAxis.Value = 0f;
			Composer.m_VerticalAxis.Value = 0f;
		}
		scaning = false;
	}

	private void Update()
	{
		tipsTimeCountDown -= Time.deltaTime;
		if (tipsTimeCountDown < 0f && tipsGO != null && tipsGO.activeSelf)
		{
			tipsGO.SetActive(value: false);
		}
		updateTiming += Time.deltaTime;
		if (!(updateTiming > updateInterval))
		{
			return;
		}
		updateTiming = 0f;
		if (Physics.Raycast(RectTransformUtility.ScreenPointToRay(Camera.main, new Vector2(Screen.width / 2, Screen.height / 2)), out var hitInfo, scanDistance, layer))
		{
			CameraInteractItem cameraInteractItem = hitInfo.collider.transform.GetComponent(typeof(CameraInteractItem)) as CameraInteractItem;
			if (cameraInteractItem != null && cameraInteractItem.found)
			{
				if (cur != cameraInteractItem)
				{
					cur = cameraInteractItem;
					SetInfoPanel();
				}
				return;
			}
			if (cur != null)
			{
				cur.FoundedState();
			}
			cur = null;
			SetInfoPanel();
		}
		else
		{
			if (cur != null)
			{
				cur.FoundedState();
			}
			cur = null;
			SetInfoPanel();
		}
	}

	private void SetInfoPanel()
	{
		if (cur != null)
		{
			cur.ChosedState();
		}
		if (infoGO == null)
		{
			return;
		}
		if (cur == null && infoGO.activeSelf)
		{
			infoGO.SetActive(value: false);
		}
		else if (!infoGO.activeSelf && cur != null)
		{
			if (textName != null)
			{
				textName.text = WorldStateManager.GetTipsContent(cur.nameBattleTips);
			}
			if (textDesc != null)
			{
				textDesc.text = WorldStateManager.GetTipsContent(cur.desBattleTips);
			}
			if (image != null && cur.iconPath != null)
			{
				image.sprite = AtlasManager.GetSpriteWithoutAtlas(cur.iconPath);
			}
			infoGO.SetActive(value: true);
		}
	}

	public void SetScanAction(Flow f, FlowOutput startScanOut, FlowOutput finishScanOut, Action<Flow, FlowOutput> startScan, Action<Flow, FlowOutput> finishScan)
	{
		this.f = f;
		this.startScanOut = startScanOut;
		this.finishScanOut = finishScanOut;
		this.startScan = startScan;
		this.finishScan = finishScan;
	}

	public IEnumerator ScanCoroutine()
	{
		if (startScan != null)
		{
			startScan(f, startScanOut);
		}
		yield return null;
		if (animator != null && !string.IsNullOrEmpty(scanStateName))
		{
			animator.Play(scanStateName);
		}
		scaning = true;
		int num = Physics.OverlapSphereNonAlloc(Composer.transform.position, scanDistance, colliders, layer.value);
		yield return null;
		Camera camera = CanvasManager.Instance.uiCamera;
		yield return null;
		for (int i = 0; i < num; i++)
		{
			yield return null;
			Collider collider = colliders[i];
			CameraInteractItem item = collider.GetComponent(typeof(CameraInteractItem)) as CameraInteractItem;
			if (item == null)
			{
				continue;
			}
			Vector3 screenPoint = Camera.main.WorldToScreenPoint(item.transform.position);
			yield return null;
			if (screenPoint.z <= 0f)
			{
				continue;
			}
			bool flag = RectTransformUtility.RectangleContainsScreenPoint(scanArea, screenPoint, camera);
			yield return null;
			if (flag)
			{
				Vector3 diff = Composer.transform.position - item.transform.position;
				float mag = diff.magnitude;
				yield return null;
				bool hit = Physics.Raycast(item.transform.position, diff, out var _, mag);
				yield return null;
				if (!hit)
				{
					item.FoundedState();
				}
			}
		}
		yield return null;
		scaning = false;
		if (animator != null && !string.IsNullOrEmpty(scanFinishedStateName))
		{
			animator.Play(scanFinishedStateName);
		}
		yield return null;
		if (finishScan != null)
		{
			finishScan(f, finishScanOut);
		}
	}

	public void ChangeCamera(CameraInteractItem item)
	{
		CinemachineVirtualCamera virtualCamera = item.virtualCamera;
		if (Composer != null)
		{
			Composer.VirtualCamera.Priority = 0;
			Composer.m_HorizontalAxis.Value = 0f;
			Composer.m_VerticalAxis.Value = 0f;
		}
		Composer = virtualCamera.GetCinemachineComponent(CinemachineCore.Stage.Aim) as CinemachinePOV;
		if (Composer != null)
		{
			Composer.VirtualCamera.Priority = cameraPriority;
		}
	}

	public void Scan()
	{
		if (scaning)
		{
			ShowTips(scaningBattips);
		}
		else
		{
			StartCoroutine(ScanCoroutine());
		}
	}

	private void ShowTips(int id)
	{
		if (!(tipsGO == null))
		{
			if (textTips != null)
			{
				textTips.text = WorldStateManager.GetTipsContent(id);
			}
			tipsGO.SetActive(value: true);
			tipsTimeCountDown = tipsTime;
		}
	}

	public void Choose()
	{
		if (scaning)
		{
			ShowTips(scaningBattips);
			return;
		}
		if (cur == null)
		{
			ShowTips(noItemBattips);
			return;
		}
		cur.Interact();
		if (cur.virtualCamera != null)
		{
			ChangeCamera(cur);
		}
		cur = null;
	}
}
