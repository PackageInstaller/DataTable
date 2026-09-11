using System.Collections.Generic;
using System.IO;
using Config;
using Google.Protobuf;
using NetProcol;
using UnityEngine;

public class OutSourcingSimulatorDraw : MonoBehaviour
{
	private bool _joinRoom;

	private List<int> _roleIDs = new List<int>();

	private List<string> _roleNames = new List<string>();

	private Dictionary<int, string> _scenes = new Dictionary<int, string>();

	private int mSceneID;

	private int mStandardSceneID;

	private Dictionary<int, RoleData> RoleDatas = new Dictionary<int, RoleData>();

	private Dictionary<int, int> StandardRoleDatas = new Dictionary<int, int>();

	private Dictionary<int, string> StandardRoleDatas_ATK_attribute = new Dictionary<int, string>();

	private int mCooperateUniqueSkillID;

	private const string COOPERATE_UNIQUE_SKILL_ID_KEY = "cooperateUniqueSkillID";

	private string[] charactors = new string[8] { "1050", "1039", "1028", "1034", "1046", "1019", "1048", "1066" };

	private Vector2 scrollPosition = Vector2.zero;

	private Vector2 roleScrollPosition = Vector2.zero;

	private string mTestAccount;

	private string mTestIP;

	private string mTestPort;

	private GameMode gameMode;

	private GUIStyle btnStyle;

	private GUIStyle scrollBarStyle;

	private GUIStyle scrollBarThumbStyle;

	private GUIStyle labelStyle;

	private GUIStyle textfieldStyle;

	private string key = "effect";

	private string sheetName = "c_1011";

	private string cueName = "c_1011_win";

	private bool useStream;

	public GameObject UIDontDesatroyCamera { get; private set; }

	private void Awake()
	{
		GamepadManager.Instance.UseController();
		Application.targetFrameRate = 60;
		I18NConfigManager.Initialize();
		I18NRuntimeManager.Instance.Init();
		I18NRuntimeManager.Instance.LoadDefaultLanguage();
		TextAsset textAsset = Asset.Load<TextAsset>("Config");
		if (null == textAsset)
		{
			Debug.Log("Can't Load Config");
		}
		using (MemoryStream input = new MemoryStream(textAsset.bytes))
		{
			using BinaryReader binaryReader = new BinaryReader(input);
			ConfigHelper.GetInstance().Initialize(binaryReader);
		}
		Asset.Unload("Config");
		Dictionary<int, IMessage>.Enumerator enumerator = ConfigHelper.GetInstance().GetAllConfig(typeof(RoleConfig)).GetEnumerator();
		while (enumerator.MoveNext())
		{
			RoleConfig roleConfig = enumerator.Current.Value as RoleConfig;
			_roleIDs.Add(roleConfig.ID);
			_roleNames.Add(roleConfig.ID.ToString());
		}
		foreach (KeyValuePair<int, IMessage> item in ConfigHelper.GetInstance().GetAllConfig(typeof(SceneMap)))
		{
			SceneMap sceneMap = item.Value as SceneMap;
			_scenes[sceneMap.ID] = sceneMap.MapDataPath.Replace("Map/", "").Replace("_Trigger", "");
		}
		if (PlayerPrefs.HasKey("sceneID"))
		{
			mSceneID = PlayerPrefs.GetInt("sceneID");
		}
		if (PlayerPrefs.HasKey("standardSceneID"))
		{
			mStandardSceneID = PlayerPrefs.GetInt("standardSceneID");
		}
		RoleDatas.Add(0, new RoleData
		{
			ID = 1050
		});
		RoleDatas.Add(1, new RoleData
		{
			ID = 0
		});
		RoleDatas.Add(2, new RoleData
		{
			ID = 0
		});
		if (PlayerPrefs.HasKey("roleData1"))
		{
			RoleDatas[0] = new RoleData
			{
				ID = PlayerPrefs.GetInt("roleData1")
			};
		}
		if (RoleDatas[0].ID == 0)
		{
			RoleDatas[0] = new RoleData
			{
				ID = 1050
			};
		}
		if (PlayerPrefs.HasKey("roleData2"))
		{
			RoleDatas[1] = new RoleData
			{
				ID = PlayerPrefs.GetInt("roleData2")
			};
		}
		if (PlayerPrefs.HasKey("roleData3"))
		{
			RoleDatas[2] = new RoleData
			{
				ID = PlayerPrefs.GetInt("roleData3")
			};
		}
		for (int i = 0; i < 3; i++)
		{
			StandardRoleDatas.Add(i, 0);
			string text = "standardRoleData" + (i + 1);
			if (PlayerPrefs.HasKey(text))
			{
				StandardRoleDatas[i] = PlayerPrefs.GetInt(text);
			}
		}
		for (int j = 0; j < 3; j++)
		{
			StandardRoleDatas_ATK_attribute.Add(j, "");
			string text2 = "standardRoleDatas_ATK_attribute" + (j + 1);
			if (PlayerPrefs.HasKey(text2))
			{
				StandardRoleDatas_ATK_attribute[j] = PlayerPrefs.GetString(text2, "");
			}
		}
		if (PlayerPrefs.HasKey("cooperateUniqueSkillID"))
		{
			mCooperateUniqueSkillID = PlayerPrefs.GetInt("cooperateUniqueSkillID");
		}
	}

	private Op_C2B_PlayerReady GetReadyMessage(bool isUseStandard = false)
	{
		Op_C2B_PlayerReady op_C2B_PlayerReady = BattleSceneLoader.CreateDefaultReadyMessage();
		op_C2B_PlayerReady.SceneDataForExcehange.CooperateUniqueSkillID = mCooperateUniqueSkillID;
		op_C2B_PlayerReady.SceneDataForExcehange.RoleDataInLua.Clear();
		if (isUseStandard)
		{
			op_C2B_PlayerReady = GetStandardReadyMessage(op_C2B_PlayerReady);
		}
		else
		{
			op_C2B_PlayerReady.SceneDataForExcehange.MSceneID = mSceneID;
			foreach (KeyValuePair<int, RoleData> roleData in RoleDatas)
			{
				if (roleData.Value.ID == 0)
				{
					continue;
				}
				RoleDataForExchangeInfo roleDataForExchangeInfo = new RoleDataForExchangeInfo();
				roleDataForExchangeInfo.ID = roleData.Value.ID;
				roleDataForExchangeInfo.Level = roleData.Value.level;
				roleDataForExchangeInfo.PlayerLevel = roleData.Value.playerLevel;
				if (roleData.Value.attribute != null)
				{
					foreach (KeyValuePair<int, long> item in roleData.Value.attribute)
					{
						roleDataForExchangeInfo.AttributeID.Add(item.Key);
						roleDataForExchangeInfo.AttributeValue.Add(item.Value);
					}
				}
				op_C2B_PlayerReady.SceneDataForExcehange.RoleDataInLua.Add(roleDataForExchangeInfo);
			}
		}
		return op_C2B_PlayerReady;
	}

	public void launcher(bool isUseStandard = false)
	{
		OutSourcingBattleScene outSourcingBattleScene = NScene.Load<OutSourcingBattleScene>();
		outSourcingBattleScene.ready = GetReadyMessage(isUseStandard);
		outSourcingBattleScene.mGameMode = gameMode;
	}

	private void OnGUI()
	{
		if (labelStyle == null)
		{
			labelStyle = new GUIStyle(GUI.skin.label)
			{
				fontSize = 18
			};
			GUI.skin.label = labelStyle;
		}
		if (textfieldStyle == null)
		{
			textfieldStyle = new GUIStyle(GUI.skin.textField)
			{
				fontSize = 38
			};
			GUI.skin.textField = textfieldStyle;
		}
		if (btnStyle == null)
		{
			btnStyle = new GUIStyle(GUI.skin.button)
			{
				fontSize = 20
			};
		}
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
		GUILayout.Space(50f);
		GUILayout.BeginHorizontal();
		GUILayout.BeginVertical(GUILayout.Width(280f));
		scrollPosition = GUILayout.BeginScrollView(scrollPosition, true, true, GUIStyle.none, scrollBarStyle);
		foreach (KeyValuePair<int, string> scene in _scenes)
		{
			if (GUILayout.Button(scene.Value, btnStyle, GUILayout.Width(200f), GUILayout.Height(120f)))
			{
				mSceneID = scene.Key;
			}
		}
		GUILayout.EndScrollView();
		GUILayout.EndVertical();
		GUILayout.Space(100f);
		GUILayout.BeginVertical(GUILayout.Width(280f));
		roleScrollPosition = GUILayout.BeginScrollView(roleScrollPosition, true, false, GUIStyle.none, scrollBarStyle);
		int num = 0;
		while (!_joinRoom && num < _roleIDs.Count)
		{
			if (GUILayout.Button(_roleIDs[num].ToString(), btnStyle, GUILayout.Width(200f), GUILayout.Height(120f)))
			{
				if (UIDontDesatroyCamera == null)
				{
					UIDontDesatroyCamera = Asset.Instantiate("UI/UICamera_DontDestroy");
					UIDontDesatroyCamera.name = "UICamera_DontDestroy";
					_joinRoom = true;
				}
				SetRoleData(_roleIDs[num]);
				if (!string.IsNullOrEmpty(mTestAccount))
				{
					gameMode = GameMode.EditorMultiPlayer;
					BattleScene.IP = mTestIP;
					BattleScene.Port = mTestPort;
				}
				else
				{
					gameMode = GameMode.EditorSinglePlayer;
				}
				launcher();
			}
			num++;
		}
		GUILayout.EndScrollView();
		GUILayout.EndVertical();
		GUILayout.EndHorizontal();
		DrawStandardGUI();
		GUILayout.BeginArea(new Rect(700f, Screen.height - 400, 1000f, 400f));
		GUILayout.BeginHorizontal();
		GUILayout.BeginVertical();
		GUILayout.BeginHorizontal();
		GUILayout.Label("关卡ID", GUILayout.Height(100f));
		mSceneID = int.Parse(GUILayout.TextField(mSceneID.ToString(), GUILayout.Height(100f)));
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal();
		for (int i = 0; i < RoleDatas.Count; i++)
		{
			GUILayout.Label(i + "号位", GUILayout.Height(100f));
			int iD = int.Parse(GUILayout.TextField(RoleDatas[i].ID.ToString(), GUILayout.Height(100f)));
			RoleData value = RoleDatas[i];
			value.ID = iD;
			RoleDatas[i] = value;
		}
		GUILayout.Label("使用连携技ID", GUILayout.Height(100f));
		int.TryParse(GUILayout.TextField(mCooperateUniqueSkillID.ToString(), GUILayout.Height(100f)), out mCooperateUniqueSkillID);
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal();
		GUILayout.Label("联机账户");
		mTestAccount = GUILayout.TextField(mTestAccount, GUILayout.Width(200f), GUILayout.Height(100f));
		GUILayout.Label("IP");
		mTestIP = PlayerPrefs.GetString("BattleScene.mTestIP:");
		mTestIP = GUILayout.TextField(mTestIP, GUILayout.Width(200f), GUILayout.Height(100f));
		PlayerPrefs.SetString("BattleScene.mTestIP:", mTestIP);
		GUILayout.Label("端口号");
		mTestPort = PlayerPrefs.GetString("BattleScene.mTestPort:");
		mTestPort = GUILayout.TextField(mTestPort, GUILayout.Width(200f), GUILayout.Height(100f));
		PlayerPrefs.SetString("BattleScene.mTestPort:", mTestPort);
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal();
		GUILayout.EndHorizontal();
		GUILayout.EndVertical();
		GUILayout.BeginVertical();
		if (GUILayout.Button("开始", btnStyle, GUILayout.Width(200f), GUILayout.Height(150f)))
		{
			if (UIDontDesatroyCamera == null)
			{
				UIDontDesatroyCamera = Asset.Instantiate("UI/UICamera_DontDestroy");
				UIDontDesatroyCamera.name = "UICamera_DontDestroy";
				_joinRoom = true;
			}
			SetRoleData(RoleDatas[0].ID);
			if (!string.IsNullOrEmpty(mTestAccount))
			{
				gameMode = GameMode.EditorMultiPlayer;
				BattleScene.IP = mTestIP;
				BattleScene.Port = mTestPort;
			}
			else
			{
				gameMode = GameMode.EditorSinglePlayer;
			}
			launcher();
			PlayerPrefs.SetInt("sceneID", mSceneID);
			PlayerPrefs.SetInt("roleData1", RoleDatas[0].ID);
			PlayerPrefs.SetInt("roleData2", RoleDatas[1].ID);
			PlayerPrefs.SetInt("roleData3", RoleDatas[2].ID);
			PlayerPrefs.SetInt("cooperateUniqueSkillID", mCooperateUniqueSkillID);
		}
		GUILayout.EndVertical();
		GUILayout.EndHorizontal();
		GUILayout.EndArea();
		using (new GUILayout.AreaScope(new Rect((float)Screen.width * 0.75f, 0f, Mathf.Max((float)Screen.width * 0.12f, 330f), Screen.height - 50)))
		{
			GUIStyle slider = new GUIStyle(GUI.skin.verticalScrollbar)
			{
				fixedWidth = Mathf.Max((float)Screen.width * 0.12f, 330f),
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
			key = GUILayout.TextField(key);
			sheetName = GUILayout.TextField(sheetName);
			cueName = GUILayout.TextField(cueName);
			useStream = GUILayout.Toggle(useStream, "流");
			using (new GUILayout.HorizontalScope())
			{
				float height = Mathf.Clamp(Screen.height / 10, 100, 200);
				if (GUILayout.Button("播放", GUILayout.Height(height)))
				{
					AudioManager.Instance.Play(key, sheetName, cueName, useStream);
				}
				if (GUILayout.Button("移除", GUILayout.Height(height)))
				{
					AudioManager.Instance.RemoveCue(sheetName);
				}
			}
		}
	}

	private void SetRoleData(int id)
	{
		RoleDatas[0] = new RoleData
		{
			ID = id,
			attribute = new Dictionary<int, long>
			{
				{ 3, 1000L },
				{ 1, 50L },
				{ 2, 1000L }
			}
		};
		for (int i = 1; i < RoleDatas.Count; i++)
		{
			if (RoleDatas[i].ID != 0)
			{
				RoleDatas[i] = new RoleData
				{
					ID = RoleDatas[i].ID,
					attribute = new Dictionary<int, long>
					{
						{ 3, 10000L },
						{ 1, 50L },
						{ 2, 1000L }
					},
					AI_ID = -(i + 1)
				};
			}
		}
	}

	private void LoadStandardStageData()
	{
		int[] standardStageHeroList = OutSourcingSimulatorTools.GetStandardStageHeroList(mStandardSceneID);
		if (standardStageHeroList != null)
		{
			for (int i = 0; i < standardStageHeroList.Length; i++)
			{
				StandardRoleDatas[i] = standardStageHeroList[i];
			}
		}
	}

	private Op_C2B_PlayerReady GetStandardReadyMessage(Op_C2B_PlayerReady ready)
	{
		OutSourcingSimulatorTools.GetStandardStageMapData(mStandardSceneID, out var monster_attribute, out var mapID, out var monsterLevel);
		ready.SceneDataForExcehange.MSceneID = mapID;
		foreach (KeyValuePair<int, int> standardRoleData in StandardRoleDatas)
		{
			int value = standardRoleData.Value;
			string forceMainDamageTypeStr = StandardRoleDatas_ATK_attribute[standardRoleData.Key];
			if (value != 0)
			{
				ready.SceneDataForExcehange.RoleDataInLua.Add(OutSourcingSimulatorTools.GetNetRoleDataByStandardID(value, forceMainDamageTypeStr));
			}
		}
		Int3 @int = new Int3(1000, 1000, 1000);
		_ = monster_attribute[0];
		_ = monster_attribute[1];
		_ = monster_attribute[2];
		@int = new Int3(monster_attribute[0], monster_attribute[1], monster_attribute[2]);
		ready.SceneDataForExcehange.AttributeFactorX = @int.x;
		ready.SceneDataForExcehange.AttributeFactorY = @int.y;
		ready.SceneDataForExcehange.AttributeFactorZ = @int.z;
		ready.SceneDataForExcehange.AdaptiveEnemyLevel = monsterLevel;
		OutSourcingSimulatorTools.GetStandardStageAffix(mStandardSceneID, out var affixIDList, out var levelIDList, out var targetTypeList, out var affixCount);
		for (int i = 0; i < affixCount; i++)
		{
			ready.SceneDataForExcehange.TypeIDListAffix.Add(affixIDList[i]);
			ready.SceneDataForExcehange.LevelList.Add(levelIDList[i]);
			ready.SceneDataForExcehange.EnemyTypes.Add(targetTypeList[i]);
		}
		return ready;
	}

	private void DrawStandardGUI()
	{
		GUILayout.BeginArea(new Rect(700f, Screen.height - 800, 1000f, 400f));
		GUILayout.BeginHorizontal();
		GUILayout.BeginVertical();
		GUILayout.BeginHorizontal();
		GUILayout.Label("标准关卡ID", GUILayout.Height(100f), GUILayout.Width(100f));
		mStandardSceneID = int.Parse(GUILayout.TextField(mStandardSceneID.ToString(), GUILayout.Width(200f), GUILayout.Height(100f)));
		if (GUILayout.Button("加载关卡角色数据", btnStyle, GUILayout.Width(200f), GUILayout.Height(100f)))
		{
			LoadStandardStageData();
		}
		if (GUILayout.Button("开始", btnStyle, GUILayout.Width(150f), GUILayout.Height(100f)))
		{
			if (UIDontDesatroyCamera == null)
			{
				UIDontDesatroyCamera = Asset.Instantiate("UI/UICamera_DontDestroy");
				UIDontDesatroyCamera.name = "UICamera_DontDestroy";
				_joinRoom = true;
			}
			if (!string.IsNullOrEmpty(mTestAccount))
			{
				gameMode = GameMode.EditorMultiPlayer;
				BattleScene.IP = mTestIP;
				BattleScene.Port = mTestPort;
			}
			else
			{
				gameMode = GameMode.EditorSinglePlayer;
			}
			launcher(isUseStandard: true);
			PlayerPrefs.SetInt("standardSceneID", mStandardSceneID);
			PlayerPrefs.SetInt("standardRoleData1", StandardRoleDatas[0]);
			PlayerPrefs.SetInt("standardRoleData2", StandardRoleDatas[1]);
			PlayerPrefs.SetInt("standardRoleData3", StandardRoleDatas[2]);
			PlayerPrefs.SetString("standardRoleDatas_ATK_attribute1", StandardRoleDatas_ATK_attribute[0]);
			PlayerPrefs.SetString("standardRoleDatas_ATK_attribute2", StandardRoleDatas_ATK_attribute[1]);
			PlayerPrefs.SetString("standardRoleDatas_ATK_attribute3", StandardRoleDatas_ATK_attribute[2]);
			PlayerPrefs.SetInt("cooperateUniqueSkillID", mCooperateUniqueSkillID);
		}
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal();
		for (int i = 0; i < StandardRoleDatas.Count; i++)
		{
			GUILayout.Label("标准人：\n" + i + "号位", GUILayout.Width(80f), GUILayout.Height(80f));
			int value = int.Parse(GUILayout.TextField(StandardRoleDatas[i].ToString(), GUILayout.Width(200f), GUILayout.Height(80f)));
			StandardRoleDatas[i] = value;
		}
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal();
		for (int j = 0; j < StandardRoleDatas_ATK_attribute.Count; j++)
		{
			GUILayout.Label("攻击属性：\n" + j + "号位", GUILayout.Width(80f), GUILayout.Height(80f));
			string value2 = GUILayout.TextField(StandardRoleDatas_ATK_attribute[j].ToString(), GUILayout.Width(200f), GUILayout.Height(80f));
			StandardRoleDatas_ATK_attribute[j] = value2;
		}
		GUILayout.EndHorizontal();
		GUILayout.Label("攻击属性为空时使用默认的攻击属性", GUILayout.Height(100f));
		GUILayout.EndVertical();
		GUILayout.EndHorizontal();
		GUILayout.EndArea();
	}
}
