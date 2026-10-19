using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Rendering;
using ACT.Utility;
using Bamboo.AssetField;
using Cinemachine;
using DG.Tweening;
using Fundamental;
using RootMotion.FinalIK;
using UnityEngine;

namespace ACT.UI;

public class UISceneRender : BaseUIScene
{
	public struct LookIk
	{
		public LookAtIK neckIk;

		public LookAtIK eyesIk;
	}

	public enum UISceneModelType
	{
		None,
		Character,
		Weapon,
		Chip,
		Assist,
		Team
	}

	private LookIk[] lookIks = new LookIk[3];

	public GameObject modelRoot;

	public CinemachineVirtualCamera normalCamera;

	[SerializeField]
	private CinemachineVirtualCamera _teamBagCamera;

	private GameObject m_Model;

	private Vector3 assistPosition = new Vector3(0.15f, -4.14f, -10.59f);

	public Transform[] teamModelsPos;

	public CinemachineVirtualCamera[] virtualCameras;

	[SerializeField]
	private float _vcamYOffset;

	public int farCameraPriority;

	public int nearCameraPriority;

	[SerializeField]
	private int _teamBagCameraPriority;

	[SerializeField]
	private GameObject[] _indexHighlightedEffect;

	private Dictionary<int, int> m_ModelDic = new Dictionary<int, int>();

	private const string Spine2 = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2";

	private readonly AssetLoadHandle[] _loadModelHandles = new AssetLoadHandle[3];

	private readonly AssetLoadHandle[] _animationHandles = new AssetLoadHandle[3];

	private UISceneModelType m_ModelType;

	private int m_Id;

	private bool m_InCoroutine;

	private CinemachineVirtualCamera m_CurrentCamera;

	private static int assistId;

	private static int s_Ref;

	private Tween cameraMove;

	public static UISceneRender instance => Singleton<UISceneManager>.instance.GetScene<UISceneRender>();

	protected void Awake()
	{
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		assistId = 0;
		s_Ref = 0;
	}

	private void Start()
	{
		m_CurrentCamera = normalCamera;
	}

	private void LateUpdate()
	{
		for (int i = 0; i < lookIks.Length; i++)
		{
			if (lookIks[i].eyesIk != null)
			{
				lookIks[i].neckIk.solver.IKUpdate();
				lookIks[i].eyesIk.solver.IKUpdate();
			}
		}
	}

	public override void OnRelease()
	{
		cameraMove?.Kill();
		cameraMove = null;
		instance.ReleaseAll();
		base.OnRelease();
	}

	public override void Open()
	{
		GameRenderScene.Set(GameRenderScene.Scene.CharacterTeam);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Close_MainLight, null);
		base.Open();
	}

	public override void Close()
	{
		GameRenderScene.Set(GameRenderScene.Scene.MainBattle);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Open_MainLight, null);
		base.Close();
	}

	public void DoShowTeamModels(int[] charactersId)
	{
		m_ModelDic.Clear();
		for (int i = 0; i < charactersId.Length; i++)
		{
			ReleaseModel(i);
			if (charactersId[i] != 0)
			{
				DoShow(i, charactersId[i]);
			}
		}
	}

	private void DoShow(int index, int id)
	{
		int skinId = CharacterSkinRuntimeUtility.ResolveSkinId(id);
		m_ModelDic[index] = id;
		LoadTeamModel(index, id, skinId);
	}

	private void LoadTeamModel(int index, int characterId, int skinId)
	{
		string modelPath = CharacterSkinRuntimeUtility.GetModelPath(characterId, skinId, CharacterModelUsage.Team);
		if (string.IsNullOrEmpty(modelPath))
		{
			return;
		}
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.InstantiateAsync(modelPath, teamModelsPos[index]);
		if (!AssetLoadHandleExtensions.IsValid(assetLoadHandle))
		{
			if (m_ModelDic.GetValueOrDefault(index) == characterId && LuminApplication.LogEnabled)
			{
				Debug.LogError($"角色ID{characterId}在队伍场景中没有可用模型资源");
			}
			return;
		}
		_loadModelHandles[index] = assetLoadHandle;
		assetLoadHandle.Completed += (AssetLoadHandle loadHandle) =>
		{
			string animatorAssetId = CharacterSkinRuntimeUtility.GetAnimatorAssetId(skinId, CharacterModelUsage.Team);
			if (!string.IsNullOrEmpty(animatorAssetId))
			{
				AssetLoadHandle assetLoadHandle2 = AssetStationManager.BattleStation.Load<RuntimeAnimatorController>(animatorAssetId);
				CharacterSkinRuntimeUtility.ApplyAnimatorOverride(loadHandle.AsGameObject(), assetLoadHandle2.As<RuntimeAnimatorController>());
				_animationHandles[index] = assetLoadHandle2;
			}
			ModelCompleted(loadHandle.AsGameObject(), index);
		};
	}

	private void ModelCompleted(GameObject obj, int index)
	{
		if (m_ModelDic.TryGetValue(index, out var value))
		{
			CharacterDataHelper.TryGetBagCharacterById(value, out var character);
			obj.GetComponent<MonoDestinyEffect>()?.Binding(character);
		}
		obj.transform.localPosition = Vector3.zero;
		Transform transform = obj.transform.Find("Bip001/charLight");
		if (transform != null)
		{
			transform.gameObject.SetActive(value: false);
		}
		LookAtIK[] components = obj.GetComponents<LookAtIK>();
		foreach (LookAtIK lookAtIK in components)
		{
			lookAtIK.enabled = false;
			if (lookAtIK.solver.eyes.Length != 0)
			{
				lookIks[index].eyesIk = lookAtIK;
				lookAtIK.solver.target = uiSceneCamera.transform;
			}
			else
			{
				lookIks[index].neckIk = lookAtIK;
				lookAtIK.solver.target = uiSceneCamera.transform;
			}
			lookAtIK.enabled = true;
		}
		Transform transform2 = virtualCameras[index].transform;
		Transform transform3 = obj.transform.Find("Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2");
		if (!transform3)
		{
			transform3 = obj.transform.GetChild(0).transform.Find("Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2");
		}
		transform2.position = new Vector3(transform2.position.x, transform3.position.y + _vcamYOffset, transform2.position.z);
		obj.GetComponent<AniPartControl>()?.PlayVisible(AniPartControl.PartType.SystemDither, 0.1f, default, null, reset: true);
		obj.GetComponent<MonoEntityConfig>()?.SetRenderLayerToCharacterUIScene();
	}

	public void ReleaseModel(int index)
	{
		if (AssetLoadHandleExtensions.IsValid(_loadModelHandles[index]))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_loadModelHandles[index]);
		}
		_loadModelHandles[index] = default;
		if (AssetLoadHandleExtensions.IsValid(_animationHandles[index]))
		{
			AssetStationManager.BattleStation.Release(_animationHandles[index]);
			_animationHandles[index] = default;
		}
		m_ModelDic.Remove(index);
	}

	public void ReleaseAll()
	{
		for (int i = 0; i < 3; i++)
		{
			ReleaseModel(i);
		}
		m_ModelDic.Clear();
	}

	public void ReplaceModel(int index, int id)
	{
		m_CurrentCamera = virtualCameras[index];
		ResetModel(index, id);
	}

	public void ResetModel(int index, int id)
	{
		if (m_ModelDic.TryGetValue(index, out var value))
		{
			if (value != id)
			{
				ReleaseModel(index);
				if (id != 0)
				{
					DoShow(index, id);
				}
			}
		}
		else if (id != 0)
		{
			DoShow(index, id);
		}
	}

	public void UpdateSkinModel(int index, int id)
	{
		ReleaseModel(index);
		DoShow(index, id);
	}

	public void ChangeToCloseCamera(int index)
	{
		m_CurrentCamera = virtualCameras[index];
		m_CurrentCamera.Priority = nearCameraPriority;
		for (int i = 0; i < teamModelsPos.Length; i++)
		{
			GameObject gameObject = _loadModelHandles[i].AsGameObject();
			if (i != index && gameObject != null)
			{
				gameObject.SetActive(value: false);
			}
		}
	}

	public void ChangeToCloseCameraOnEmptySeat(int index)
	{
		m_CurrentCamera = virtualCameras[index];
		m_CurrentCamera.Priority = nearCameraPriority;
		for (int i = 0; i < teamModelsPos.Length; i++)
		{
			GameObject gameObject = _loadModelHandles[i].AsGameObject();
			if (i != index && gameObject != null)
			{
				gameObject.SetActive(value: false);
			}
		}
	}

	public void ChangeCameraPosition(int index, int selectCharId)
	{
		m_CurrentCamera = virtualCameras[index];
		m_CurrentCamera.Priority = nearCameraPriority;
		for (int i = 0; i < teamModelsPos.Length; i++)
		{
			GameObject gameObject = _loadModelHandles[i].AsGameObject();
			if (i != index && gameObject != null)
			{
				gameObject.SetActive(value: false);
			}
		}
	}

	public void ChangeToTeamBagCam()
	{
		m_CurrentCamera = _teamBagCamera;
		m_CurrentCamera.Priority = _teamBagCameraPriority;
	}

	public void ChangeToFarCam()
	{
		m_CurrentCamera.Priority = farCameraPriority;
	}

	public void ResetCameraPosition(int[] characters)
	{
		m_CurrentCamera.Priority = farCameraPriority;
		for (int i = 0; i < teamModelsPos.Length; i++)
		{
			GameObject gameObject = _loadModelHandles[i].AsGameObject();
			if (characters[i] != 0 && !m_ModelDic.ContainsKey(i) && gameObject == null)
			{
				DoShow(i, characters[i]);
			}
			else if (gameObject != null && !gameObject.activeInHierarchy)
			{
				gameObject.SetActive(value: true);
			}
		}
	}

	public void ChooseAssist()
	{
		if (m_ModelType == UISceneModelType.Assist)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPASSISTCHOOSE, assistId);
		}
	}

	internal void SetIndexHighlightedActive(int index, bool active)
	{
		_indexHighlightedEffect[index].SetActive(active);
	}
}
