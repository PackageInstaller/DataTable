using Cinemachine;
using UnityEngine;

public class QWFocusCamera : MonoBehaviour
{
	private const string cameraPath = "QWWorld/Camera/FocusCamera/FocusCamera";

	public GameObject root;

	public CinemachineVirtualCamera startCamera;

	public CinemachineVirtualCamera endCamera;

	public CinemachineVirtualCamera backCamera;

	[HideInInspector]
	public bool isInAct;

	private Collider[] collide = new Collider[8];

	public LayerMask detectMask;

	public CinemachineBlendDefinition secondStageDefine;

	public int delayFrame = 3;

	private bool isInEndStage;

	private bool isWaitNextFrame;

	private int nextFrame;

	public float detectionRange = 1f;

	public float detectionDistance = 0.3f;

	public bool IsInAct
	{
		get
		{
			if (!isInAct && !isInEndStage)
			{
				return isWaitNextFrame;
			}
			return true;
		}
	}

	public static QWFocusCamera Load()
	{
		GameObject obj = Object.Instantiate(Asset.Load("QWWorld/Camera/FocusCamera/FocusCamera") as GameObject, QWorldScene.Scene.Agent.transform);
		obj.transform.localPosition = Vector3.zero;
		obj.transform.localRotation = Quaternion.identity;
		QWFocusCamera component = obj.GetComponent<QWFocusCamera>();
		component.isInAct = false;
		return component;
	}

	public void FindSafeAreaAndEnable()
	{
		isInAct = true;
		isInEndStage = false;
		backCamera.SetActive(bActive: false);
		_ = QWorldCameraManager.Instance.mcCamera.FreeLook.transform.rotation;
		Vector3 position = QWorldCameraManager.Instance.mcCamera.FreeLook.transform.position;
		Vector3 vector = QWorldCameraManager.Instance.mcCamera.FreeLook.LookAt.position - position;
		position += vector * 0.1f;
		QWorldCameraManager.Instance.SetCameraBlend(0);
		QWCharacterBlackboard characterBlackboard = QWorldScene.Scene.Agent.CharacterBlackboard;
		Vector3 vector2 = characterBlackboard.head.right;
		Physics.OverlapSphereNonAlloc(characterBlackboard.head.transform.position + vector2 * detectionDistance, detectionRange, collide, detectMask);
		if (collide[0] != null)
		{
			vector2 = -characterBlackboard.head.right;
			Vector3 forward = Vector3.ProjectOnPlane(-vector2, characterBlackboard.GetAgent().Up);
			characterBlackboard.GetAgent().Rotation = Quaternion.LookRotation(forward);
		}
		for (int i = 0; i < 8; i++)
		{
			collide[i] = null;
		}
		root.transform.position = characterBlackboard.head.transform.position + vector2 * detectionDistance;
		root.transform.forward = characterBlackboard.head.right;
		startCamera.SetActive(bActive: true);
		backCamera.transform.position = position;
		backCamera.transform.forward = vector;
		nextFrame = delayFrame;
		isWaitNextFrame = true;
	}

	private void NextStage()
	{
		nextFrame = 0;
		isWaitNextFrame = false;
		QWorldCameraManager.Instance.SetCameraBlend((int)secondStageDefine.m_Style, secondStageDefine.m_Time);
		endCamera.SetActive(bActive: true);
	}

	public void Tick()
	{
		if (!IsInAct)
		{
			return;
		}
		if (isWaitNextFrame)
		{
			nextFrame--;
			if (nextFrame <= 0)
			{
				NextStage();
			}
		}
		if (isInEndStage)
		{
			nextFrame--;
			if (nextFrame <= 0)
			{
				FinalStage();
			}
		}
	}

	public void DisableCamera(bool force = false)
	{
		if (!force)
		{
			startCamera.SetActive(bActive: false);
			endCamera.SetActive(bActive: false);
			QWorldCameraManager.Instance.SetCameraBlend(0);
			backCamera.SetActive(bActive: true);
			nextFrame = 2;
			isInEndStage = true;
		}
		else
		{
			startCamera.SetActive(bActive: false);
			endCamera.SetActive(bActive: false);
			FinalStage();
		}
	}

	public void FinalStage()
	{
		isInAct = false;
		isInEndStage = false;
		isWaitNextFrame = false;
		nextFrame = 0;
		QWorldCameraManager.Instance.ResetCameraBlend();
		backCamera.SetActive(bActive: false);
	}
}
