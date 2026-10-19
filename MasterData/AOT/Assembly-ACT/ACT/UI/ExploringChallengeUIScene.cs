using System.Collections;
using Bamboo.AssetField;
using Cinemachine;
using UnityEngine;

namespace ACT.UI;

public class ExploringChallengeUIScene : BaseUIScene
{
	private static ExploringChallengeUIScene _default;

	public CinemachineVirtualCamera vCamera;

	public Transform modelsPos;

	private Animator animator;

	private Vector3 vCameraOldPos;

	private string curEmotion;

	private int lastWidth;

	private int lastHeight;

	public static ExploringChallengeUIScene Default => _default;

	public static IEnumerator LoadScene()
	{
		if (!(_default != null))
		{
			AssetStationManager.BattleStation.InstantiateAsync(GameLoader.meta.uiExploringChallengeSceneReferenceAssetID, (AssetLoadHandle result) =>
			{
				_default = result.AsGameObject().GetComponent<ExploringChallengeUIScene>();
				_default.uiSceneCamera.gameObject.SetActive(value: false);
			});
			yield return new WaitUntil(() => _default != null);
		}
	}

	public static void Unload()
	{
		if (_default != null)
		{
			AssetStationManager.BattleStation.ReleaseInstance(_default.gameObject);
			_default = null;
		}
	}

	private void Awake()
	{
		vCameraOldPos = vCamera.transform.position;
	}

	public void LoadModel()
	{
		AssetStationManager.BattleStation.InstantiateAsync("Npc/Npc_48_DialogueShow", modelsPos, instantiateInWorldSpace: false, (AssetLoadHandle result) =>
		{
			ModelCompleted(result.AsGameObject());
		});
	}

	private void ModelCompleted(GameObject obj)
	{
		obj.transform.localPosition = Vector3.zero;
		animator = obj.GetComponent<Animator>();
	}

	public void PlayAnim(string anim)
	{
		animator.CrossFade(anim, 0.1f);
	}

	public void PlayEmotion(string emotion)
	{
		animator.SetBool("face_" + curEmotion, value: false);
		curEmotion = emotion;
		animator.SetBool("face_" + emotion, value: true);
	}

	public void ResumeEmotion()
	{
		animator.SetBool("face_" + curEmotion, value: false);
	}

	public new void Open()
	{
		base.Open();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		_default = null;
	}

	public void Update()
	{
		if (Screen.width != lastWidth || Screen.height != lastHeight)
		{
			lastWidth = Screen.width;
			lastHeight = Screen.height;
			AdjustCameras(lastWidth, lastHeight);
		}
	}

	private void AdjustCameras(int newWidth, int newHeight)
	{
		float num = (float)newWidth / (float)newHeight;
		float num2 = 2f - num;
		if (num2 > 0f)
		{
			Vector3 position = vCameraOldPos;
			position.x += num2 / 3f;
			vCamera.transform.position = position;
		}
		else
		{
			vCamera.transform.position = vCameraOldPos;
		}
	}
}
