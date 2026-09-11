using System;
using System.Collections.Generic;
using Config;
using FlowCanvas;
using Packages.P08Base.Net;
using UnityEngine;
using UnityEngine.SceneManagement;

public class OutSourcingBattleScene : BattleScene
{
	public bool IsDrawOverlapRange = true;

	public float OverlapRangeKeepTime = 1f;

	public static Action<RunTimeTimelineAndHitCache> InsertPreviewRoleConfigDataFunc;

	public static string MapSceneName;

	public static string mCueSheet;

	public static string mCueName;

	public static string mCueAwb;

	public bool mute;

	public bool ignoreCD;

	public bool ignoreAI;

	public bool fullPower;

	public string lastID3;

	private bool m_showAddRole;

	protected List<int> _roleIDs = new List<int>();

	protected Vector2 scrollPosition;

	private Dictionary<int, bool> m_dictRoleLoaded = new Dictionary<int, bool>();

	private bool _configInited;

	private float _musicVolume;

	private CriAtomSource _player;

	private List<int> m_loadedRole = new List<int>();

	private GUIStyle labelStyle;

	private GUIStyle textfieldStyle;

	private GUIStyle scrollBarStyle;

	private GUIStyle scrollBarThumbStyle;

	private string _customEntityID;

	private int _abilityID;

	private int _thrownID;

	private ThrownState _thrownState;

	public override void OnSceneReady()
	{
		base.OnSceneReady();
		_player = AudioManager.Instance.GetPlayer("music");
		_musicVolume = _player.volume;
		if (!string.IsNullOrEmpty(mCueSheet))
		{
			AudioManager.Instance.Play("music", mCueSheet, mCueName, !string.IsNullOrEmpty(mCueAwb));
		}
	}

	public void LoadFlowScriptPrefab(int roleID)
	{
		if (ready.SceneDataForExcehange.RoleDataInLua.Count > 0 && !m_loadedRole.Contains(ready.SceneDataForExcehange.RoleDataInLua.get_Item(0).ID))
		{
			m_loadedRole.Add(ready.SceneDataForExcehange.RoleDataInLua.get_Item(0).ID);
		}
		if (m_loadedRole.Contains(roleID))
		{
			return;
		}
		GameObject gameObject = Asset.Instantiate($"FlowScript/Char/{roleID}_FlowscriptPrefab");
		if (gameObject != null)
		{
			FlowScriptController[] components = gameObject.GetComponents<FlowScriptController>();
			for (int i = 0; i < components.Length; i++)
			{
				components[i].graph.mSimContext = ClientSimulator.Instance.mSimContext;
				components[i].StartBehaviour();
			}
		}
		m_loadedRole.Add(roleID);
	}

	public void LoadTimelineSync(int roleID)
	{
		string text = $"combattle/timeline/{roleID}_timeline.ys";
		UnityEngine.Object[] array = Asset.LoadAllFromBundle<UnityEngine.Object>(text);
		if (array == null)
		{
			Debug.LogError("=====>>>>> 请导出角色Timeline数据,assetBundleName:" + text);
		}
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] is RoleRenderConfig)
			{
				RoleRenderConfig roleRenderConfig = array[i] as RoleRenderConfig;
				_timelineAndHitInfoCache.Add(roleRenderConfig.ID, roleRenderConfig);
				continue;
			}
			TimelineInfo timelineInfo = array[i] as TimelineInfo;
			if (null == timelineInfo)
			{
				Debug.LogError("无法加载Timeline数据 ");
				break;
			}
			_timelineAndHitInfoCache.Add(timelineInfo.ID, timelineInfo);
		}
	}

	private void OnGUI()
	{
		if (scrollBarStyle == null)
		{
			scrollBarStyle = new GUIStyle(GUI.skin.verticalScrollbar)
			{
				fixedWidth = 80f
			};
		}
		if (scrollBarThumbStyle == null)
		{
			scrollBarThumbStyle = new GUIStyle(GUI.skin.verticalScrollbarThumb)
			{
				fixedWidth = 80f,
				fixedHeight = 120f
			};
		}
		GUI.skin.verticalScrollbarThumb = scrollBarThumbStyle;
		if (labelStyle == null)
		{
			labelStyle = new GUIStyle(GUI.skin.label)
			{
				fontSize = 18
			};
		}
		if (textfieldStyle == null)
		{
			textfieldStyle = new GUIStyle(GUI.skin.textField)
			{
				fontSize = 38
			};
		}
		GUILayout.BeginArea(new Rect(0f, 0f, (float)Screen.width * 0.15f, 5000f));
		GUILayout.Label("特效品质:", labelStyle);
		GUILayout.Label("0(low) 1(Medium) 2(High) 3(Fantastic)", labelStyle);
		GUILayout.Label("玩家", labelStyle);
		int mainPlayerQuality = (int)BattleScene.MainPlayerQuality;
		string s = GUILayout.TextField(mainPlayerQuality.ToString(), textfieldStyle);
		int result = (int)BattleScene.MainPlayerQuality;
		if (int.TryParse(s, out result) && result != (int)BattleScene.MainPlayerQuality)
		{
			PlayerPrefs.SetInt("MainPlayerQuality", (int)(BattleScene.MainPlayerQuality = (EEffectQuality)Mathf.Clamp(result, 0, 3)));
		}
		GUILayout.Label("AI", labelStyle);
		mainPlayerQuality = (int)BattleScene.AIQuality;
		string s2 = GUILayout.TextField(mainPlayerQuality.ToString(), textfieldStyle);
		result = (int)BattleScene.AIQuality;
		if (int.TryParse(s2, out result) && result != (int)BattleScene.AIQuality)
		{
			PlayerPrefs.SetInt("AIQuality", (int)(BattleScene.AIQuality = (EEffectQuality)Mathf.Clamp(result, 0, 3)));
		}
		if (GUILayout.Button("<size=30>QTE</size>", GUILayout.Width(Mathf.Max((float)Screen.width * 0.1f, 300f)), GUILayout.Height(Mathf.Max((float)Screen.height * 0.05f, 80f))))
		{
			SimEntity entityWithEntityID = ClientSimulator.Instance.mSimContext.GetEntityWithEntityID(GetAgentManager().mPlayerAgentID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityUniqueSkillEnergy)
			{
				entityWithEntityID.entityUniqueSkillEnergy.mValue = entityWithEntityID.entityUniqueSkillEnergy.mMaxValue;
			}
		}
		if (GUILayout.Button("<size=30>1号队友QTE</size>", GUILayout.Width(Mathf.Max((float)Screen.width * 0.1f, 300f)), GUILayout.Height(Mathf.Max((float)Screen.height * 0.05f, 80f))))
		{
			SimEntity entityWithEntityID2 = ClientSimulator.Instance.mSimContext.GetEntityWithEntityID(GetAgentManager().mSecondAgentID);
			if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityUniqueSkillEnergy)
			{
				entityWithEntityID2.entityUniqueSkillEnergy.mValue = entityWithEntityID2.entityUniqueSkillEnergy.mMaxValue;
			}
		}
		if (GUILayout.Button("<size=30>2号队友QTE</size>", GUILayout.Width(Mathf.Max((float)Screen.width * 0.1f, 300f)), GUILayout.Height(Mathf.Max((float)Screen.height * 0.05f, 80f))))
		{
			SimEntity entityWithEntityID3 = ClientSimulator.Instance.mSimContext.GetEntityWithEntityID(GetAgentManager().mThirdAgentID);
			if (entityWithEntityID3 != null && entityWithEntityID3.hasEntityUniqueSkillEnergy)
			{
				entityWithEntityID3.entityUniqueSkillEnergy.mValue = entityWithEntityID3.entityUniqueSkillEnergy.mMaxValue;
			}
		}
		GUILayout.EndArea();
		using (new GUILayout.AreaScope(new Rect((float)Screen.width * 0.3f, 0f, Mathf.Max((float)Screen.width * 0.12f, 150f), Screen.height)))
		{
			GUIStyle slider = new GUIStyle(GUI.skin.verticalScrollbar)
			{
				fixedWidth = Mathf.Max((float)Screen.width * 0.1f, 150f),
				fixedHeight = 30f
			};
			GUIStyle thumb = new GUIStyle(GUI.skin.verticalScrollbarThumb)
			{
				fixedWidth = 30f,
				fixedHeight = 30f
			};
			GUILayout.Label("背景音");
			float volume = AudioManager.Instance.GetVolume("music");
			volume = GUILayout.HorizontalSlider(volume, 0f, 1f, slider, thumb, GUILayout.Height(35f));
			AudioManager.Instance.SetVolume("music", volume);
			GUILayout.Label("音效");
			float volume2 = AudioManager.Instance.GetVolume("effect");
			volume2 = GUILayout.HorizontalSlider(volume2, 0f, 1f, slider, thumb, GUILayout.Height(35f));
			AudioManager.Instance.SetVolume("effect", volume2);
			GUILayout.Label("语音");
			float volume3 = AudioManager.Instance.GetVolume("voice");
			volume3 = GUILayout.HorizontalSlider(volume3, 0f, 1f, slider, thumb, GUILayout.Height(35f));
			AudioManager.Instance.SetVolume("voice", volume3);
		}
		GUILayout.BeginArea(new Rect((float)Screen.width * 0.15f, 0f, Mathf.Max((float)Screen.width * 0.1f, 150f), 5000f));
		GUIStyle style = new GUIStyle(GUI.skin.toggle)
		{
			fontSize = 45
		};
		mute = GUILayout.Toggle(mute, "NOBGM", style, GUILayout.Width(Mathf.Max((float)Screen.width * 0.1f, 150f)), GUILayout.Height(Mathf.Max((float)Screen.height * 0.05f, 60f)));
		if (mute)
		{
			if ((bool)_player)
			{
				_player.volume = 0f;
			}
		}
		else if ((bool)_player)
		{
			_player.volume = _musicVolume;
		}
		ignoreCD = GUILayout.Toggle(ignoreCD, "无视CD", style, GUILayout.Width(Mathf.Max((float)Screen.width * 0.1f, 150f)), GUILayout.Height(Mathf.Max((float)Screen.height * 0.05f, 60f)));
		ignoreAI = GUILayout.Toggle(ignoreAI, "无视AI", style, GUILayout.Width(Mathf.Max((float)Screen.width * 0.1f, 150f)), GUILayout.Height(Mathf.Max((float)Screen.height * 0.05f, 60f)));
		fullPower = GUILayout.Toggle(fullPower, "满能量", style, GUILayout.Width(Mathf.Max((float)Screen.width * 0.1f, 150f)), GUILayout.Height(Mathf.Max((float)Screen.height * 0.05f, 60f)));
		GUILayout.Label("<size=20>指定实体ID(空0为主控)</size>");
		_customEntityID = GUILayout.TextField(_customEntityID, GUILayout.Width(Mathf.Max((float)Screen.width * 0.2f, 150f)), GUILayout.Height(Mathf.Max((float)Screen.height * 0.05f, 30f)));
		GUILayout.Label("<size=20>输入技能后3位动作</size>");
		GUIStyle style2 = new GUIStyle(GUI.skin.textField)
		{
			fontSize = 60
		};
		lastID3 = GUILayout.TextField(lastID3, style2, GUILayout.Width(Mathf.Max((float)Screen.width * 0.2f, 150f)), GUILayout.Height(Mathf.Max((float)Screen.height * 0.1f, 60f)));
		if ((GUILayout.Button("<size=30>播放(快捷键G)</size>", GUILayout.Height(80f)) || Input.GetKey(KeyCode.G)) && _abilityID == 0 && _thrownID == 0)
		{
			int result2 = 0;
			if (string.IsNullOrEmpty(_customEntityID) || !int.TryParse(_customEntityID, out result2) || result2 == 0)
			{
				int num = CommonProcessor.GetWorldState().mLocalPlayerID;
				if (num == 0)
				{
					Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
					RemoteMember value = null;
					if (mRoomMembers.TryGetValue(MemberPosition.First, out value))
					{
						num = value.mEntityID;
					}
				}
				result2 = num;
			}
			SimEntity entityWithEntityID4 = ClientSimulator.Instance.mSimContext.GetEntityWithEntityID(result2);
			if (entityWithEntityID4 != null)
			{
				_abilityID = entityWithEntityID4.entityConfig.mId * 1000 + int.Parse(lastID3);
				if (ConfigHelper.GetInstance().GetConfig<AbilityConfig>(_abilityID) != null)
				{
					if (int.TryParse(lastID3, out var result3) && result3 > 50 && result3 < 100)
					{
						int num2 = 0;
						if (entityWithEntityID4 != null && entityWithEntityID4.hasEntityBlackboard)
						{
							num2 = entityWithEntityID4.entityBlackboard.var.mAttributeID;
							Int3 mPosition = entityWithEntityID4.entityPositon.mPosition;
							Int3 mForward = entityWithEntityID4.entityPositon.mForward;
							mPosition += mForward.NormalizeTo(5000);
							_thrownID = ThrownProcessor.SpawnThrown(ClientSimulator.Instance.mSimContext, entityWithEntityID4.creationIndex, 0, 0, mPosition, entityWithEntityID4.entityPositon.mForward, _abilityID, useCommon: true, entityWithEntityID4.creationIndex, _abilityID, num2, out var _);
						}
					}
					else
					{
						AIProcessor.AIStartAttack(result2, entityWithEntityID4.entityPositon.mPosition, _abilityID, isForce: true);
					}
					GUILayout.Label("开始");
				}
			}
		}
		if (_abilityID != 0)
		{
			int result4 = 0;
			if (string.IsNullOrEmpty(_customEntityID) || !int.TryParse(_customEntityID, out result4))
			{
				int num3 = CommonProcessor.GetWorldState().mLocalPlayerID;
				if (num3 == 0)
				{
					Dictionary<MemberPosition, RemoteMember> mRoomMembers2 = CommonProcessor.GetWorldState().mRoomMembers;
					RemoteMember value2 = null;
					if (mRoomMembers2.TryGetValue(MemberPosition.First, out value2))
					{
						num3 = value2.mEntityID;
					}
				}
				result4 = num3;
			}
			SimEntity entityWithEntityID5 = ClientSimulator.Instance.mSimContext.GetEntityWithEntityID(result4);
			if (entityWithEntityID5 != null)
			{
				int num4 = (entityWithEntityID5.hasEntityActionAbility ? entityWithEntityID5.entityActionAbility.mAbilityID : 0);
				int num5 = (entityWithEntityID5.hasEntityActionAbilityLogicInput ? entityWithEntityID5.entityActionAbilityLogicInput.mBrokenAbilityID : 0);
				if (_abilityID != num4 && _abilityID != num5)
				{
					_abilityID = 0;
				}
				else if (_abilityID == num4)
				{
					Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(_abilityID);
					GUILayout.Label(entityWithEntityID5.entityActionAbility.mLogicTime + "/" + config.Duration);
				}
			}
		}
		if (_thrownID != 0)
		{
			if (!ThrownProcessor.TryGetThrown(ClientSimulator.Instance.mSimContext, _thrownID, out _thrownState))
			{
				_thrownID = 0;
				_thrownState = null;
			}
			if (_thrownID != 0)
			{
				Timeline config2 = ConfigHelper.GetInstance().GetConfig<Timeline>(_thrownState.mAbilityID);
				GUILayout.Label(_thrownState.mLogicTime + "/" + config2.Duration);
			}
		}
		GUILayout.EndArea();
		float width = Mathf.Max((float)Screen.width * 0.12f, 330f);
		int num6 = Screen.height - 50;
		GUILayout.Width(width);
		GUILayout.Height(num6);
		GUILayoutOption gUILayoutOption = GUILayout.Width(Mathf.Max((float)Screen.width * 0.1f, 300f));
		GUILayoutOption gUILayoutOption2 = GUILayout.Height(Mathf.Max((float)Screen.height * 0.05f, 80f));
		GUILayout.BeginArea(new Rect((float)Screen.width * 0.59f, 0f, width, num6));
		if (GUILayout.Button(TextFontSize("退出"), gUILayoutOption, gUILayoutOption2))
		{
			GameObject[] dontDestroyOnLoadGameObjects = getDontDestroyOnLoadGameObjects();
			foreach (GameObject gameObject in dontDestroyOnLoadGameObjects)
			{
				if (gameObject.name == "OutSourcingDontDestroy" || gameObject.name == "UICamera_DontDestroy" || gameObject.name == base.gameObject.name)
				{
					UnityEngine.Object.Destroy(gameObject);
				}
			}
			AudioManager.Instance.DestoryCriAtom();
			SceneManager.LoadScene("outsourcing");
		}
		GUILayout.EndArea();
		GUILayout.BeginArea(new Rect((float)Screen.width * 0.75f, 0f, width, num6));
		if (GUILayout.Button(TextFontSize(m_showAddRole ? "隐藏列表" : "添加敌人"), gUILayoutOption, gUILayoutOption2))
		{
			m_showAddRole = !m_showAddRole;
		}
		if (m_showAddRole)
		{
			if (_roleIDs.Count <= 0)
			{
				GetRoleIdConfig();
			}
			scrollPosition = GUILayout.BeginScrollView(scrollPosition, true, false, GUIStyle.none, scrollBarStyle);
			for (int j = 0; j < _roleIDs.Count; j++)
			{
				if (!GUILayout.Button(TextFontSize(_roleIDs[j].ToString()), gUILayoutOption, gUILayoutOption2))
				{
					continue;
				}
				if (!m_dictRoleLoaded.ContainsKey(_roleIDs[j]))
				{
					(NScene.GetCurrentScene() as OutSourcingBattleScene).LoadTimelineSync(_roleIDs[j]);
					(NScene.GetCurrentScene() as OutSourcingBattleScene).LoadFlowScriptPrefab(_roleIDs[j]);
					m_dictRoleLoaded.Add(_roleIDs[j], value: true);
					RoleConfig config3 = ConfigHelper.GetInstance().GetConfig<RoleConfig>(_roleIDs[j]);
					if (config3 == null)
					{
						Debug.Log("====>>>> 找不到 " + _roleIDs[j] + " 数据,自动添加配置数据");
					}
					else if (config3.AdditionalRoleIDs.Count > 0)
					{
						for (int k = 0; k < config3.AdditionalRoleIDs.Count; k++)
						{
							int num7 = config3.AdditionalRoleIDs.get_Item(k);
							if (num7 > 6000)
							{
								(NScene.GetCurrentScene() as OutSourcingBattleScene).LoadFlowScriptPrefab(num7);
							}
							Debug.Log("附加角色 = " + num7);
							(NScene.GetCurrentScene() as OutSourcingBattleScene).LoadTimelineSync(num7);
						}
					}
				}
				Int3 spawnPoint = Int3.zero;
				Int3 forward = Int3.forward;
				Int3 up = Int3.up;
				SimEntity entityWithEntityID6 = ClientSimulator.Instance.mSimContext.GetEntityWithEntityID(SpawnProcessor.GetLocalPlayerID());
				if (entityWithEntityID6 != null)
				{
					spawnPoint = entityWithEntityID6.entityPositon.mPosition + new Int3(0, 0, 1);
					forward = entityWithEntityID6.entityPositon.mForward;
				}
				int moveSpeed = 500;
				int num8 = 1000000;
				int hpStripCount = 8000;
				RoleConfig config4 = ConfigHelper.GetInstance().GetConfig<RoleConfig>(_roleIDs[j]);
				if (config4 != null)
				{
					num8 = 1000000;
					moveSpeed = config4.Radius.get_Item(0);
					Debug.LogError("半径 = " + moveSpeed);
					hpStripCount = config4.Speed;
				}
				SimEntity simEntity = SpawnProcessor.SpawnUnit(0L, spawnPoint, forward, up, RoleType.Enemy, 1011, isLocalPlayer: false, _roleIDs[j], 0, MemberPosition.None, num8, moveSpeed, hpStripCount);
				simEntity.entityBlackboard.var.mMaxHP = num8;
				simEntity.entityBlackboard.var.mHP = num8;
			}
			GUILayout.EndScrollView();
		}
		GUILayout.EndArea();
	}

	private string TextFontSize(string content)
	{
		return $"<size=30>{content}</size>";
	}

	private GameObject[] getDontDestroyOnLoadGameObjects()
	{
		List<GameObject> list = new List<GameObject>();
		list.AddRange(UnityEngine.Object.FindObjectsOfType<GameObject>());
		for (int i = 0; i < SceneManager.sceneCount; i++)
		{
			GameObject[] rootGameObjects = SceneManager.GetSceneAt(i).GetRootGameObjects();
			for (int j = 0; j < rootGameObjects.Length; j++)
			{
				list.Remove(rootGameObjects[j]);
			}
		}
		int num = list.Count;
		while (--num >= 0)
		{
			if (list[num].transform.parent != null)
			{
				list.RemoveAt(num);
			}
		}
		return list.ToArray();
	}

	private void GetRoleIdConfig()
	{
		if (!_configInited)
		{
			Dictionary<int, Google.Protobuf.IMessage>.Enumerator enumerator = ConfigHelper.GetInstance().GetAllConfig(typeof(Skin)).GetEnumerator();
			while (enumerator.MoveNext())
			{
				Skin skin = enumerator.Current.Value as Skin;
				_roleIDs.Add(skin.ID);
			}
			_configInited = true;
		}
	}

	private void OnDestroy()
	{
		CloseSimulator();
		if (mNetwork != null)
		{
			UnityEngine.Object.Destroy(mNetwork as ClientUDPNet);
			mNetwork = null;
		}
	}
}
