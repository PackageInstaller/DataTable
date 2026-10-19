using System;
using System.Collections.Generic;
using System.Net;
using System.Text.RegularExpressions;
using ACT.Game;
using ACT.Game.Data;
using ACT.Local;
using ACT.Net;
using Fundamental;
using Pb;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoNetLoginView : BaseUIView
{
	[SerializeField]
	private List<ServerConfig> m_ServerConfigs = new List<ServerConfig>
	{
		new ServerConfig
		{
			name = "test",
			ip = "10.17.12.29",
			port = 7001
		},
		new ServerConfig
		{
			name = "dispatch",
			ip = "10.17.10.45",
			port = 7001
		}
	};

	public Dropdown serverConfigSelect;

	public InputField openId;

	public Button newId;

	public Button loginBtn;

	private LoginAck m_La;

	private (string ip, int port) GameServiceAddr;

	private Regex nameRex = new Regex("(.*)\\(([0-9]*)\\)");

	private Regex gateAddrReg = new Regex("(.*):(.*)");

	[NonSerialized]
	public bool enterGame;

	private ServerConfig ServerConfigSelected => m_ServerConfigs[serverConfigSelect.value];

	protected override void Init()
	{
		List<Dropdown.OptionData> list = new List<Dropdown.OptionData>();
		for (int i = 0; i < m_ServerConfigs.Count; i++)
		{
			list.Add(new Dropdown.OptionData
			{
				text = m_ServerConfigs[i].name
			});
		}
		serverConfigSelect.options = list;
		serverConfigSelect.value = PlayerPrefs.GetInt("serverConfigSelected");
		serverConfigSelect.onValueChanged.AddListener((int v) =>
		{
			PlayerPrefs.SetInt("serverConfigSelected", v);
		});
		openId.text = PlayerPrefs.GetString("openId");
		openId.onValueChanged.AddListener((string v) =>
		{
			PlayerPrefs.SetString("openId", v);
		});
		newId.onClick.AddListener(NewId);
		loginBtn.onClick.AddListener(Login);
		Singleton<NetManager>.CreateInstance();
	}

	private void NewId()
	{
		string text = openId.text;
		Match match = nameRex.Match(text);
		if (match.Success)
		{
			openId.text = $"{match.Groups[1].Value}({int.Parse(match.Groups[2].Value) + 1})";
		}
		else
		{
			openId.text += " (1)";
		}
	}

	private (string ip, int port) GetGameServiceIPAndPort(string gateAddr)
	{
		Match match = gateAddrReg.Match(gateAddr);
		string item = ((!IPAddress.TryParse(match.Groups[1].Value, out var _)) ? Dns.GetHostEntry(match.Groups[1].Value).AddressList[0].ToString() : match.Groups[1].Value);
		int item2 = int.Parse(match.Groups[2].Value);
		return (ip: item, port: item2);
	}

	public async void Login()
	{
		ServerConfig serverConfigSelected = ServerConfigSelected;
		if (!(await Singleton<NetManager>.instance.ConnectAsync(serverConfigSelected.ip, serverConfigSelected.port)))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("cannot connect LoginService");
			}
			return;
		}
		LoginReq loginReq = new LoginReq();
		loginReq.OpenId = openId.text;
		if (await Singleton<NetManager>.instance.RequestAsync(loginReq) is LoginAck la)
		{
			m_La = la;
		}
		Singleton<NetManager>.instance.Disconnect();
		GameServiceAddr = GetGameServiceIPAndPort(m_La.GateAddr);
		if (!(await Singleton<NetManager>.instance.ConnectAsync(GameServiceAddr.ip, GameServiceAddr.port)))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("cannot connect GameService");
			}
			return;
		}
		if (G.localPlayer == null)
		{
			G.localPlayer = new Player();
		}
		G.localPlayer.Inventory = new Inventory();
		EnterGameReq enterGameReq = new EnterGameReq();
		enterGameReq.OpenId = m_La.OpenId;
		enterGameReq.LoginKey = m_La.LoginKey;
		enterGameReq.AccountId = m_La.AccountId;
		if (await Singleton<NetManager>.instance.RequestAsync(enterGameReq) is EnterGameAck enterGameAck)
		{
			G.detailUserInfo = enterGameAck.Info;
			G.localPlayer.Profile = enterGameAck.Info.Profile;
			TimeManager.StartGame(enterGameAck.Ts);
			EnterGame();
		}
	}

	public void EnterGame()
	{
		enterGame = true;
		Close();
	}

	protected override void AddEventListener()
	{
	}

	protected override void RemoveEventListener()
	{
	}
}
