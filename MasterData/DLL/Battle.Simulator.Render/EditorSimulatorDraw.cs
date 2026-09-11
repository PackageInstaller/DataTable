using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using Config;
using Google.Protobuf;
using Google.Protobuf.Collections;
using NetProcol;
using Packages.P08Base.Net;
using UnityEngine;
using XServer;

public class EditorSimulatorDraw : MonoBehaviour
{
	private List<int> _roleIDs = new List<int>();

	private List<string> _roleNames = new List<string>();

	private Dictionary<int, string> _scenes = new Dictionary<int, string>();

	private int mSceneID;

	private Dictionary<int, RoleData> RoleDatas = new Dictionary<int, RoleData>();

	private int mCooperateUniqueSkillID;

	private const string COOPERATE_UNIQUE_SKILL_ID_KEY = "cooperateUniqueSkillID";

	private GameMode _gameMode;

	private long _battleID;

	private ulong _uuid;

	private string[] charactors = new string[8] { "1050", "1039", "1028", "1034", "1046", "1019", "1048", "1066" };

	private Vector2 scrollPosition = Vector2.zero;

	private string mTestAccount;

	private string mTestBattleID = "0";

	private string mTestIP;

	private string mTestPort;

	private string playBackFilePath = "";

	private bool isNone;

	public GameObject UIDontDesatroyCamera { get; private set; }

	private void Awake()
	{
		GamepadManager.Instance.UseController();
		TextAsset textAsset = Asset.Load<TextAsset>("Config");
		I18NConfigManager.Initialize();
		I18NRuntimeManager.Instance.Init();
		I18NRuntimeManager.Instance.LoadDefaultLanguage();
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
		if (PlayerPrefs.HasKey("cooperateUniqueSkillID"))
		{
			mCooperateUniqueSkillID = PlayerPrefs.GetInt("cooperateUniqueSkillID");
		}
		XLogger.Initialize(Application.streamingAssetsPath + "/NLog.config");
	}

	private void OnGUI()
	{
		GUILayout.BeginHorizontal();
		GUILayout.BeginVertical();
		scrollPosition = GUILayout.BeginScrollView(scrollPosition, true, false, GUIStyle.none, GUI.skin.verticalScrollbar);
		foreach (KeyValuePair<int, string> scene in _scenes)
		{
			if (GUILayout.Button(scene.Value, GUILayout.Height(100f)))
			{
				mSceneID = scene.Key;
			}
		}
		GUILayout.EndScrollView();
		GUILayout.EndVertical();
		GUILayout.EndHorizontal();
		GUILayout.BeginArea(new Rect(300f, Screen.height - 350, 1200f, 350f));
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
		GUILayout.Label("房间ID");
		mTestBattleID = GUILayout.TextField(mTestBattleID, GUILayout.Width(200f), GUILayout.Height(100f));
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
		if (GUILayout.Button("开始", GUILayout.Width(200f), GUILayout.Height(150f)))
		{
			StartFunc();
		}
		if (GUILayout.Button("创建房间", GUILayout.Width(200f), GUILayout.Height(150f)))
		{
			if (string.IsNullOrEmpty(mTestAccount))
			{
				Debug.LogError("账户ID 不可为空");
				return;
			}
			ConnectBattleServer();
		}
		GUILayout.EndVertical();
		GUILayout.EndHorizontal();
		GUILayout.EndArea();
	}

	private void ConnectBattleServer()
	{
		_gameMode = GameMode.EditorMultiPlayer;
		BattleScene.IP = mTestIP;
		BattleScene.Port = mTestPort;
		if (SceneDirector.Instance == null)
		{
			SceneDirector.Create();
		}
		ClientUDPNet component = SceneDirector.Instance.gameObject.GetComponent<ClientUDPNet>();
		if (component != null)
		{
			UnityEngine.Object.DestroyImmediate(component);
		}
		component = SceneDirector.Instance.gameObject.AddComponent<ClientUDPNet>();
		component.Connect(BattleScene.IP, int.Parse(BattleScene.Port), delegate
		{
			try
			{
				Debug.Log("连接战斗服务器成功" + BattleScene.IP + " : " + BattleScene.Port);
				CreateBattleTeam();
			}
			catch (Exception ex)
			{
				Debug.LogError(ex.Message);
				Debug.LogError(ex.StackTrace);
			}
		}, delegate(int errorCode)
		{
			Debug.Log($"连接战斗服务器失败{BattleScene.IP} : {BattleScene.Port}  error code: {errorCode}");
		});
	}

	public void CreateBattleTeam()
	{
		ClientUDPNet net = SceneDirector.Instance.gameObject.GetComponent<ClientUDPNet>();
		if (net == null)
		{
			Debug.LogError("请先连接网络！！");
			return;
		}
		if (!long.TryParse(mTestBattleID, out var result))
		{
			Debug.LogError("不是有效战斗ID, 请输入整型ID");
			return;
		}
		net.mUDPClientNet.SendLocalMsg(126, new Op_C2B_join_room
		{
			Account = mTestAccount,
			BattleId = result
		}, delegate(Packet pkg)
		{
			net.mUDPClientNet.ReadProtobuff(pkg, out var message);
			Op_B2C_ack_join_room op_B2C_ack_join_room = message as Op_B2C_ack_join_room;
			_battleID = op_B2C_ack_join_room.BattleId;
			int seatId = op_B2C_ack_join_room.SeatId;
			if (ulong.TryParse(mTestAccount, out var result2))
			{
				_uuid = result2;
			}
			else
			{
				Debug.LogError("不是有效ID!");
			}
			mTestBattleID = _battleID.ToString();
			Debug.Log($"获得服务器分配的站位:{seatId} 战斗ID: {mTestBattleID}");
		});
	}

	private void StartFunc()
	{
		if (UIDontDesatroyCamera == null)
		{
			UIDontDesatroyCamera = Asset.Instantiate("UI/UICamera_DontDestroy");
			UIDontDesatroyCamera.name = "UICamera_DontDestroy";
		}
		BattleScene s = null;
		if (!string.IsNullOrEmpty(mTestAccount))
		{
			_gameMode = GameMode.EditorMultiPlayer;
			BattleScene.IP = mTestIP;
			BattleScene.Port = mTestPort;
			if (SceneDirector.Instance == null)
			{
				SceneDirector.Create();
			}
			ClientUDPNet net = SceneDirector.Instance.gameObject.GetComponent<ClientUDPNet>();
			if (net == null)
			{
				Debug.LogError("请先加入房间，并检查网络！");
				return;
			}
			if (!long.TryParse(mTestBattleID, out var result))
			{
				Debug.LogError("不是有效战斗ID, 请输入整型ID");
				return;
			}
			net.mUDPClientNet.SendLocalMsg(128, new Op_C2B_fetch_team_info
			{
				BattleId = result
			}, delegate(Packet pkg)
			{
				net.mUDPClientNet.ReadProtobuff(pkg, out var message);
				MapField<ulong, MatchMember> team = (message as Op_B2C_ack_fetch_team_info).Team;
				RoleDatas.Clear();
				foreach (KeyValuePair<ulong, MatchMember> item in team)
				{
					int pos = item.Value.Pos;
					RoleData value = new RoleData
					{
						ID = 1084,
						level = 1,
						attribute = new Dictionary<int, long>
						{
							{ 3, 10000L },
							{ 1, 1L },
							{ 2, 10000L }
						},
						AI_ID = -1
					};
					RoleDatas.Add(pos, value);
				}
				s = NScene.Load<BattleScene>();
				s.SetNetwork(net);
				s.ready = GetReadyMessage();
				s.mGameMode = _gameMode;
			});
		}
		else
		{
			SetRoleData(RoleDatas[0].ID);
			_gameMode = GameMode.EditorSinglePlayer;
			s = NScene.Load<BattleScene>();
			s.ready = GetReadyMessage();
			s.mGameMode = _gameMode;
			PlayerPrefs.SetInt("roleData1", RoleDatas[0].ID);
			PlayerPrefs.SetInt("roleData2", RoleDatas[1].ID);
			PlayerPrefs.SetInt("roleData3", RoleDatas[2].ID);
		}
		PlayerPrefs.SetInt("sceneID", mSceneID);
		PlayerPrefs.SetInt("cooperateUniqueSkillID", mCooperateUniqueSkillID);
	}

	private Op_C2B_PlayerReady GetReadyMessage()
	{
		Op_C2B_PlayerReady op_C2B_PlayerReady = BattleSceneLoader.CreateDefaultReadyMessage();
		op_C2B_PlayerReady.SceneDataForExcehange.RoleDataInLua.Clear();
		op_C2B_PlayerReady.SceneDataForExcehange.MSceneID = mSceneID;
		op_C2B_PlayerReady.SceneDataForExcehange.CooperateUniqueSkillID = mCooperateUniqueSkillID;
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
			roleDataForExchangeInfo.AIChip.Add(1);
			op_C2B_PlayerReady.SceneDataForExcehange.RoleDataInLua.Add(roleDataForExchangeInfo);
		}
		op_C2B_PlayerReady.BattleID = _battleID;
		op_C2B_PlayerReady.Uuid = _uuid;
		return op_C2B_PlayerReady;
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

	public void ReadServerFrame(Packet pkg, int length, List<Command> cmdList)
	{
		long pos = pkg.Pos;
		int num = pkg.ReadInt32();
		while (pos + length > pkg.Pos)
		{
			int num2 = pkg.ReadInt32();
			int offset = (int)pkg.Pos;
			using (CodedInputStream codedInputStream = new CodedInputStream(pkg.Bytes, offset, num2))
			{
				int code = codedInputStream.ReadInt32();
				Command command = CommandFactory.Create((NetprotoOperationCode)code);
				if (command != null)
				{
					command.Read(codedInputStream);
					if (command.mFrameCount < num)
					{
						Debug.LogError("过期帧 " + num + " " + command.mFrameCount + " " + command.mOwner + " " + command.Opcode);
						command.mFrameCount = (uint)num;
					}
					if (cmdList.Count > 0)
					{
						Command command2 = cmdList[cmdList.Count - 1];
						if (command.mFrameCount < command2.mFrameCount)
						{
							command.mFrameCount = command2.mFrameCount;
							Debug.LogError("====乱序包 === " + command2.mFrameCount + " => " + command.mFrameCount);
						}
					}
					cmdList.Add(command);
				}
				else
				{
					Debug.LogError("opcode: 没有对应的命令处理 " + code);
				}
			}
			pkg.GetStream().Position += num2;
		}
	}

	public void ReadLocalFrame(Packet pkg, int length, List<Command> cmdList)
	{
		using (CodedInputStream codedInputStream = new CodedInputStream(pkg.Bytes, (int)pkg.Pos, length))
		{
			int code = codedInputStream.ReadInt32();
			Command command = CommandFactory.Create((NetprotoOperationCode)code);
			if (command != null)
			{
				command.Read(codedInputStream);
				cmdList.Add(command);
			}
			else
			{
				Debug.LogError("opcode: 没有对应的命令处理 " + code);
			}
		}
		pkg.GetStream().Position += length;
	}

	public BattleScene PlaybackFromPacket(Packet pkg)
	{
		byte[] array = new byte[4];
		long len = pkg.Len;
		array[3] = pkg.Bytes[len - 1];
		array[2] = pkg.Bytes[len - 2];
		array[1] = pkg.Bytes[len - 3];
		array[0] = pkg.Bytes[len - 4];
		int num = BitConverter.ToInt32(pkg.Bytes, (int)(len - 4));
		bool flag = num > 0;
		num = Math.Abs(num);
		if (isNone)
		{
			flag = false;
			num = 1;
		}
		List<Command> cmdList = new List<Command>();
		Op_C2B_PlayerReady op_C2B_PlayerReady = null;
		for (int i = 0; i < num; i++)
		{
			int num2 = pkg.ReadInt32();
			int offset = (int)pkg.Pos;
			op_C2B_PlayerReady = new Op_C2B_PlayerReady();
			using CodedInputStream input = new CodedInputStream(pkg.Bytes, offset, num2);
			op_C2B_PlayerReady.MergeFrom(input);
			pkg.GetStream().Position += num2;
		}
		if (pkg.Pos >= pkg.Len)
		{
			Debug.LogError(" 越界了 ");
		}
		while (pkg.Pos < pkg.Len)
		{
			_ = pkg.Pos;
			int num3 = pkg.ReadInt32();
			int offset = (int)pkg.Pos;
			if (num3 == -1)
			{
				break;
			}
			if (offset + num3 > pkg.Len || num3 <= 0)
			{
				Debug.LogError(num3 + ", " + offset + ", " + pkg.Len);
				break;
			}
			if (flag)
			{
				ReadServerFrame(pkg, num3, cmdList);
			}
			else
			{
				ReadLocalFrame(pkg, num3, cmdList);
			}
		}
		Op_C2B_BattleResult op_C2B_BattleResult = new Op_C2B_BattleResult();
		if (pkg.Pos < pkg.Len)
		{
			int num2 = pkg.ReadInt32();
			int offset = (int)pkg.Pos;
			using CodedInputStream input2 = new CodedInputStream(pkg.Bytes, offset, num2);
			op_C2B_BattleResult.MergeFrom(input2);
			pkg.GetStream().Position += num2;
		}
		Debug.Log(pkg.Pos + " === " + pkg.Len);
		if (UIDontDesatroyCamera == null)
		{
			UIDontDesatroyCamera = Asset.Instantiate("UI/UICamera_DontDestroy");
			UIDontDesatroyCamera.name = "UICamera_DontDestroy";
		}
		BattleScene.isPause = false;
		BattleScene battleScene = NScene.Load<BattleScene>();
		InitBattleScene(op_C2B_PlayerReady, battleScene);
		if (flag)
		{
			battleScene.mGameMode = GameMode.ReplayMultiPlayer;
		}
		else
		{
			battleScene.mGameMode = GameMode.EditorSinglePlayer;
		}
		ClientSimulator instance = ClientSimulator.Instance;
		FieldInfo field = instance.GetType().GetField("sInstance", BindingFlags.Static | BindingFlags.NonPublic);
		if (field == null)
		{
			Debug.LogError("找不到 sInstance");
		}
		field.SetValue(instance, new PlayBackClientSimulator
		{
			cmdList = cmdList
		});
		if (ClientSimulator.Instance == instance)
		{
			Debug.LogError("相同");
		}
		return battleScene;
	}

	private void StartFromFile(string path)
	{
	}

	private static void InitBattleScene(Op_C2B_PlayerReady ready, BattleScene s)
	{
		s.ready = ready;
	}
}
