using ACT.Battle;
using ACT.Core;
using Bamboo.AssetField;
using Cinemachine;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using RootMotion.FinalIK;
using UnityEngine;

namespace ACT.UI;

public class MonsterUISceneRender : BaseUIScene
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

	private LookIk lookIks;

	public GameObject modelRoot;

	public CinemachineVirtualCamera normalCamera;

	public CinemachineVirtualCamera nearCamera;

	public GameObject m_Model;

	public Vector3 assistPosition = new Vector3(0.15f, -4.14f, -10.59f);

	public Transform ModelsPos;

	public CinemachineVirtualCamera virtualCameras;

	public float characterHeightRatio;

	public float cameraMoveDuration;

	public int farCameraPriority;

	public int nearCameraPriority;

	private AssetLoadHandle m_Handles;

	private int m_Modelid;

	private UISceneModelType m_ModelType;

	private CinemachineVirtualCamera m_CurrentCamera;

	private static int assistId;

	private static MonsterUISceneRender s_Instance;

	private static int s_Ref;

	private Tween cameraMove;

	public static MonsterUISceneRender instance => s_Instance;

	protected void Awake()
	{
		s_Instance = this;
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		s_Instance = null;
		assistId = 0;
		s_Ref = 0;
	}

	private void Start()
	{
		m_CurrentCamera = normalCamera;
	}

	private void LateUpdate()
	{
		if (lookIks.eyesIk != null)
		{
			lookIks.neckIk.solver.IKUpdate();
			lookIks.eyesIk.solver.IKUpdate();
		}
	}

	public static void Push()
	{
		s_Ref++;
		MonoECS.instance.PushPause();
	}

	public static void Pop()
	{
		if (s_Ref > 0)
		{
			s_Ref--;
			MonoECS.instance.PopPause();
			if (s_Ref == 0 && s_Instance != null)
			{
				AssetStationManager.BattleStation.ReleaseInstance(s_Instance.gameObject);
			}
		}
	}

	public new void Open()
	{
		base.Open();
	}

	public void DoShowModels(int mostersId)
	{
		base.Open();
		m_Modelid = 0;
		if (AssetLoadHandleExtensions.IsValid(m_Handles))
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_Handles);
		}
		if (mostersId != 0)
		{
			DoShow(mostersId);
		}
	}

	private void DoShow(int id)
	{
		string showMonsterModel = RuntimeConfigs.data.entityEnemyDatas[id].showMonsterModel;
		if (!string.IsNullOrEmpty(showMonsterModel))
		{
			m_Handles = AssetStationManager.BattleStation.InstantiateAsync(showMonsterModel, ModelsPos, instantiateInWorldSpace: false, (AssetLoadHandle result) =>
			{
				GameObject gameObject = result.AsGameObject();
				gameObject.transform.localPosition = Vector3.zero;
				m_Modelid = id;
				LookAtIK[] components = gameObject.GetComponents<LookAtIK>();
				foreach (LookAtIK lookAtIK in components)
				{
					lookAtIK.enabled = false;
					if (lookAtIK.solver.eyes.Length != 0)
					{
						lookIks.eyesIk = lookAtIK;
						lookAtIK.solver.target = uiSceneCamera.transform;
					}
					else
					{
						lookIks.neckIk = lookAtIK;
						lookAtIK.solver.target = uiSceneCamera.transform;
					}
					lookAtIK.enabled = true;
				}
			});
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"角色ID{id}在entityCharacterDatas表中的showModel路径为空！");
		}
	}

	public void ReleaseModel(int index)
	{
		if (m_Handles.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_Handles);
			m_Modelid = 0;
		}
	}

	public void ReleaseAll()
	{
		if (m_Handles.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_Handles);
		}
		m_Modelid = 0;
	}

	public void ReplaceModel(int id)
	{
		m_CurrentCamera = virtualCameras;
		MoveCameraToPosByCharacter(id);
		if (m_Modelid == id)
		{
			if (m_Handles.IsValid)
			{
				AssetStationManager.BattleStation.ReleaseInstance(m_Handles);
				m_Modelid = 0;
			}
			if (id != 0)
			{
				DoShow(id);
			}
		}
		else if (id != 0)
		{
			DoShow(id);
		}
	}

	public void ResetModel(int id)
	{
		if (m_Modelid == id)
		{
			if (m_Handles.IsValid)
			{
				AssetStationManager.BattleStation.ReleaseInstance(m_Handles);
				m_Modelid = 0;
			}
			if (id != 0)
			{
				DoShow(id);
			}
		}
		else if (id != 0)
		{
			DoShow(id);
		}
	}

	private void MoveCameraToPosByCharacter(int characterId)
	{
		Vector3 cameraPosByCharacter = GetCameraPosByCharacter(characterId);
		if (cameraMove != null && cameraMove.IsActive())
		{
			cameraMove.Kill();
		}
		cameraMove = m_CurrentCamera.transform.DOMoveY(cameraPosByCharacter.y, cameraMoveDuration);
	}

	private Vector3 GetCameraPosByCharacter(int characterId)
	{
		if (!RuntimeConfigs.data.entityCharacterDatas.ContainsKey(characterId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"entityCharacterData表中没有 id 为 {characterId} 的角色");
			}
			return Vector3.zero;
		}
		Vector3 position = m_CurrentCamera.transform.position;
		return new Vector3(position.x, RuntimeConfigs.data.entityCharacterDatas[characterId].characterHeight * characterHeightRatio, position.z);
	}

	public void ChangeToCloseCamera(int index)
	{
		m_CurrentCamera.Priority = nearCameraPriority;
		if (AssetLoadHandleExtensions.IsValid(m_Handles))
		{
			m_Handles.AsGameObject().SetActive(value: false);
		}
	}

	public void ChangeToCloseCameraOnEmptySeat(int index)
	{
		m_CurrentCamera = virtualCameras;
		m_CurrentCamera.Priority = nearCameraPriority;
		if (AssetLoadHandleExtensions.IsValid(m_Handles))
		{
			m_Handles.AsGameObject().SetActive(value: false);
		}
	}

	public void ChangeCameraPosition(int index, int selectCharId)
	{
		m_CurrentCamera = virtualCameras;
		m_CurrentCamera.Priority = nearCameraPriority;
		if (AssetLoadHandleExtensions.IsValid(m_Handles))
		{
			m_Handles.AsGameObject().SetActive(value: false);
		}
	}

	public static async UniTask LoadPrefab()
	{
		if (s_Instance == null)
		{
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(GameLoader.meta.uiMosterSceneReferenceAssetID);
			await handle;
			s_Instance = handle.AsGameObject().GetComponent<MonsterUISceneRender>();
		}
	}

	public void ChooseAssist()
	{
		if (m_ModelType == UISceneModelType.Assist)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPASSISTCHOOSE, assistId);
		}
	}
}
