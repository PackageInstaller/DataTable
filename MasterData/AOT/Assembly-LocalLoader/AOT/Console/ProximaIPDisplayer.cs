using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using UnityEngine;

namespace AOT.Console;

public class ProximaIPDisplayer : MonoBehaviour
{
	private int _curIpIndex;

	private List<string> _ip = new List<string>();

	private readonly Rect _location = new Rect(100f, 25f, 100f, 20f);

	public bool _hideIp;

	private void GetIP()
	{
		IPAddress[] addressList = Dns.GetHostEntry(Dns.GetHostName()).AddressList;
		foreach (IPAddress iPAddress in addressList)
		{
			if (iPAddress.AddressFamily == AddressFamily.InterNetwork)
			{
				_ip.Add(iPAddress.ToString());
			}
		}
	}

	private void Start()
	{
		GetIP();
	}

	public void OnGUI()
	{
		DrawIp();
	}

	private void DrawIp()
	{
		if (_hideIp)
		{
			return;
		}
		if (_ip.Count > 1)
		{
			if (GUI.Button(_location, _ip[_curIpIndex]))
			{
				_curIpIndex++;
				if (_curIpIndex >= _ip.Count)
				{
					_curIpIndex = 0;
				}
			}
		}
		else
		{
			GUI.Box(_location, _ip.FirstOrDefault() ?? "127.0.0.1");
		}
	}
}
