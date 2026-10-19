using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Rendering;

namespace ACT.DebugGUI;

public class DebugWindowManager : LuminSerializedMonoBehaviour
{
	[Serializable]
	public class RenderPipelineAssetBar
	{
		public string name;

		public RenderPipelineAsset value;
	}

	private static DebugWindowManager s_Instance;

	public bool debugWindow;

	public Rect defaultSingleWindowRect = new Rect(30f, 50f, 280f, 600f);

	public Rect defaultWindowRect = new Rect(330f, 50f, 300f, 600f);

	public bool debugAttackBoxGizmos;

	public bool debugAbilityBoxGizmos;

	public bool debugCompensationTraceGizmos;

	public float hitBoxThickness = 0.5f;

	public float hitBoxA = 0.8f;

	public float hitBoxDuration = 1f;

	public float hitA = 0.5f;

	public float hitDuration = 0.2f;

	public float comA = 0.2f;

	public float comDuration = 0.2f;

	public bool debugGameInfo;

	public int historyCapacity = 18;

	public List<Transform> TP = new List<Transform>();

	public List<RenderPipelineAssetBar> pipeLines = new List<RenderPipelineAssetBar>();

	public RenderPipelineAsset curPipeline;

	[Tooltip("建立参考的分辨率")]
	public Vector2 referenceResolution = new Vector2(2560f, 1440f);

	[Tooltip("0为完全匹配宽度，1为完全匹配高度")]
	[Range(0f, 1f)]
	public float Match;

	private Vector2 m_Scale;

	private float m_SCaleFactor;

	public bool debugTrace = true;

	public Color traceColor;

	public float traceTime = 3f;

	public List<GameObject> TestGos;

	[NonSerialized]
	public DebugGUIField gitVersion = new DebugGUIField();

	public bool drawSafeArea;

	public Canvas FullMonitor;

	public GameObject fullMonitorRoot;

	private List<DebugGizmo> m_SingleDebugGizmos = new List<DebugGizmo>();

	private Dictionary<Entity, List<DebugGizmo>> m_EntityBehaveDebugGizmos = new Dictionary<Entity, List<DebugGizmo>>();

	private Dictionary<Entity, EntityHitAndAbilityBoxWindow> m_EntityHitBoxAbilityWindows = new Dictionary<Entity, EntityHitAndAbilityBoxWindow>();

	[NonSerialized]
	public SingleWindow singleWindow;

	[NonSerialized]
	private HashSet<DebugWindow> windows = new HashSet<DebugWindow>();

	[NonSerialized]
	private Queue<DebugWindow> windowsQueue = new Queue<DebugWindow>();

	public static float DT => GameManager.timeSystem.debugSpeed * Time.fixedDeltaTime;

	public static DebugWindowManager instance
	{
		get
		{
			if (!s_Instance)
			{
				s_Instance = UnityEngine.Object.FindObjectOfType<DebugWindowManager>(includeInactive: true);
			}
			return s_Instance;
		}
	}

	public void InitSingleWindow()
	{
		singleWindow = new SingleWindow
		{
			position = defaultSingleWindowRect
		};
		singleWindow.Open();
		transform.position = singleWindow.position.position;
	}

	private void Start()
	{
		InitSingleWindow();
	}

	private void FixedUpdate()
	{
		curPipeline = QualitySettings.renderPipeline;
		UpdateWindows();
	}

	private void DrawTopMenu()
	{
		GUILayout.BeginHorizontal();
		debugWindow = GUILayout.Toggle(debugWindow, "Debug Window");
		debugAttackBoxGizmos = GUILayout.Toggle(debugAttackBoxGizmos, "攻击Gizmos显示");
		debugAbilityBoxGizmos = GUILayout.Toggle(debugAbilityBoxGizmos, "攻击和技能索敌的Gizmos显示");
		debugCompensationTraceGizmos = GUILayout.Toggle(debugCompensationTraceGizmos, "补偿&吸附Gizmos显示");
		debugTrace = GUILayout.Toggle(debugTrace, "Debug Trace");
		debugGameInfo = GUILayout.Toggle(debugGameInfo, "Debug GameInfo");
		GUILayout.EndHorizontal();
	}

	private void DrawGitVersion()
	{
		GUILayout.BeginArea(new Rect(((float)Screen.width - transform.position.x - 180f * m_SCaleFactor * transform.lossyScale.x) / (m_SCaleFactor * transform.lossyScale.x), 0f, 180f, 100f));
		gitVersion.Draw();
		GUILayout.EndArea();
	}

	private void DrawSaveArea()
	{
		GUI.matrix = Matrix4x4.TRS(Vector3.zero, transform.rotation, Vector3.one);
		GUIStyle gUIStyle = new GUIStyle(GUI.skin.box);
		Texture2D texture2D = new Texture2D(1, 1);
		Color red = Color.red;
		red.a = 0.5f;
		texture2D.SetPixel(0, 0, red);
		texture2D.Apply();
		gUIStyle.normal.background = texture2D;
		gUIStyle.border = new RectOffset(0, 0, 0, 0);
		Rect safeArea = Singleton<NewUIManager>.instance.ConfigSafeArea.safeArea;
		Rect position = default;
		if (Singleton<NewUIManager>.instance.ConfigSafeArea.applyY)
		{
			position = safeArea;
		}
		else
		{
			position.xMin = safeArea.xMin;
			position.xMax = safeArea.xMax;
			position.yMin = 0f;
			position.yMax = Screen.height;
		}
		position.y = (float)Screen.height - position.height - position.y;
		GUI.Box(position, GUIContent.none, gUIStyle);
	}

	private void OnGUI()
	{
		m_Scale = new Vector2((float)Screen.width / referenceResolution.x, (float)Screen.height / referenceResolution.y);
		m_SCaleFactor = Match * m_Scale.y + (1f - Match) * m_Scale.x;
		GUI.matrix = Matrix4x4.TRS(transform.position, transform.rotation, m_SCaleFactor * transform.lossyScale);
		DrawTopMenu();
		DrawGitVersion();
		if (debugWindow)
		{
			DrawWindows();
		}
		if (drawSafeArea)
		{
			DrawSaveArea();
		}
	}

	public TDebugGizmo AddGizmo<TDebugGizmo>(TDebugGizmo debugGizmo) where TDebugGizmo : DebugGizmo
	{
		m_SingleDebugGizmos.Add(debugGizmo);
		return debugGizmo;
	}

	public void RemoveGizmo(DebugGizmo debugGizmo)
	{
		m_SingleDebugGizmos.Remove(debugGizmo);
	}

	public TDebugGizmo AddGizmo<TDebugGizmo>(Entity eb, TDebugGizmo debugGizmo) where TDebugGizmo : DebugGizmo
	{
		if (!m_EntityBehaveDebugGizmos.ContainsKey(eb))
		{
			m_EntityBehaveDebugGizmos.Add(eb, new List<DebugGizmo> { debugGizmo });
		}
		else if (!m_EntityBehaveDebugGizmos[eb].Contains(debugGizmo))
		{
			m_EntityBehaveDebugGizmos[eb].Add(debugGizmo);
		}
		return debugGizmo;
	}

	public void RemoveGizmo<TDebugGizmo>(Entity eb, TDebugGizmo debugGizmo) where TDebugGizmo : DebugGizmo
	{
		m_EntityBehaveDebugGizmos[eb].Remove(debugGizmo);
	}

	public void RemoveGizmos(Entity eb)
	{
		m_EntityBehaveDebugGizmos.Remove(eb);
	}

	public void ClearGizmos()
	{
		m_SingleDebugGizmos.Clear();
		m_EntityBehaveDebugGizmos.Clear();
	}

	private void OnDrawGizmos()
	{
		foreach (DebugGizmo singleDebugGizmo in m_SingleDebugGizmos)
		{
			singleDebugGizmo.Draw();
		}
		foreach (KeyValuePair<Entity, List<DebugGizmo>> entityBehaveDebugGizmo in m_EntityBehaveDebugGizmos)
		{
			foreach (DebugGizmo item in entityBehaveDebugGizmo.Value)
			{
				item.Draw();
			}
		}
		if (MonoECS.instance != null && GameManager.trajectorySystem != null)
		{
			foreach (Entity item2 in GameManager.trajectorySystem.MajorFilter)
			{
				CompTrajectory compTrajectory = item2.GetCompTrajectory();
				if (compTrajectory.lifeEnd || !((compTrajectory.trajectory as RuntimeGeneralTrajectory)?.movementRunner is AnimationClipMovementRunner animationClipMovementRunner))
				{
					continue;
				}
				foreach (AnimationClipMovementRunner.AttackBox attackBox in animationClipMovementRunner.AttackBoxes)
				{
					Gizmos.DrawWireSphere(attackBox.pos, attackBox.radius);
				}
			}
		}
		if (!(MonoECS.instance != null) || GameManager.entities == null)
		{
			return;
		}
		foreach (Entity allEntity in GameManager.entities.GetAllEntities())
		{
			if (!allEntity.IsLogicAvailable() || !allEntity.IsBattleBehaveNotCharacter())
			{
				continue;
			}
			CompPhysics compPhysics = allEntity.GetCompPhysics();
			Vector3 center = compPhysics.characterMovement.position + (compPhysics.characterMovement.height + 0.2f) * Vector3.up;
			if (allEntity.TryGetCompAI(out CompAI component))
			{
				if (component.HasAttackToken())
				{
					Gizmos.DrawIcon(center, "AttackToken", allowScaling: true);
				}
				else
				{
					Gizmos.DrawIcon(center, "NoAttackToken", allowScaling: true);
				}
			}
		}
	}

	public static void TPBehave(Entity eb, Transform transform, int chunkId)
	{
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = transform.position,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		TeleportUtility.TeleportWithNone(chunkId, teleportParams).Forget();
	}

	public void SetVisible(bool isVisible)
	{
		enabled = isVisible;
		FullMonitor.enabled = isVisible;
		fullMonitorRoot.gameObject.SetActive(isVisible);
	}

	public void RegisterWindow(DebugWindow window)
	{
		windows.Add(window);
	}

	public void UnregisterWindow(DebugWindow window)
	{
		windows.Remove(window);
	}

	public void UpdateWindows()
	{
		singleWindow.Update();
		foreach (DebugWindow window in windows)
		{
			windowsQueue.Enqueue(window);
		}
		while (windowsQueue.Count > 0)
		{
			DebugWindow debugWindow = windowsQueue.Dequeue();
			if (debugWindow.Active)
			{
				debugWindow.Update();
			}
		}
		Entity[] array = m_EntityHitBoxAbilityWindows.Keys.ToArray();
		foreach (Entity key in array)
		{
			if (m_EntityHitBoxAbilityWindows.TryGetValue(key, out var value))
			{
				value.Update();
			}
		}
	}

	public void DrawWindows()
	{
		singleWindow.Draw(-1);
		foreach (DebugWindow window in windows)
		{
			windowsQueue.Enqueue(window);
		}
		int num = 0;
		while (windowsQueue.Count > 0)
		{
			DebugWindow debugWindow = windowsQueue.Dequeue();
			if (debugWindow.Active)
			{
				debugWindow.Draw(num++);
			}
		}
	}

	public void RemoveEntityHitBoxAbWindow(Entity eb)
	{
		m_EntityHitBoxAbilityWindows[eb].RemoveMonitors();
		m_EntityHitBoxAbilityWindows.Remove(eb);
		RemoveGizmos(eb);
	}

	public void AddEntityHitBoxAbWindow(EntityHitAndAbilityBoxWindow ebwnd)
	{
		if (!m_EntityHitBoxAbilityWindows.TryAdd(ebwnd.eb, ebwnd))
		{
			RemoveEntityHitBoxAbWindow(ebwnd.eb);
			m_EntityHitBoxAbilityWindows[ebwnd.eb] = ebwnd;
		}
	}

	public static void DebugHitBox(Entity eb)
	{
		EntityHitAndAbilityBoxWindow entityHitAndAbilityBoxWindow = new EntityHitAndAbilityBoxWindow(eb);
		entityHitAndAbilityBoxWindow.AddMonitor(EntityBehaveHitBoxAbMonitor.Init<HitBoxMonitor>(entityHitAndAbilityBoxWindow));
		entityHitAndAbilityBoxWindow.AddMonitor(EntityBehaveHitBoxAbMonitor.Init<FindRangeAreaMonitor>(entityHitAndAbilityBoxWindow));
		instance.AddEntityHitBoxAbWindow(entityHitAndAbilityBoxWindow);
	}
}
