using TMPro;
using UnityEngine;

namespace Proxima;

[HelpURL("https://www.unityproxima.com/docs")]
public class ProximaStatusUI : MonoBehaviour
{
	[SerializeField]
	private ProximaInspector _proximaInspector;

	[SerializeField]
	private GameObject _uiRoot;

	[SerializeField]
	private TMP_InputField _connectInfoLabel;

	[SerializeField]
	private TMP_Text _statusLabel;

	private bool _isPortrait;

	public ProximaInspector ProximaInspector
	{
		get
		{
			return _proximaInspector;
		}
		set
		{
			_proximaInspector = value;
		}
	}

	public GameObject UIRoot
	{
		get
		{
			return _uiRoot;
		}
		set
		{
			_uiRoot = value;
		}
	}

	public TMP_InputField ConnectInfoLabel
	{
		get
		{
			return _connectInfoLabel;
		}
		set
		{
			_connectInfoLabel = value;
		}
	}

	public TMP_Text StatusLabel
	{
		get
		{
			return _statusLabel;
		}
		set
		{
			_statusLabel = value;
		}
	}

	private void Start()
	{
		_proximaInspector.Status.Changed += UpdateUI;
		UpdateUI();
	}

	private void OnDestroy()
	{
		if ((bool)_proximaInspector)
		{
			_proximaInspector.Status.Changed -= UpdateUI;
		}
	}

	private void UpdateUI()
	{
		if ((bool)_uiRoot)
		{
			_uiRoot.SetActive(_proximaInspector.Status.Listening);
		}
		if ((bool)_connectInfoLabel)
		{
			_connectInfoLabel.text = _proximaInspector.Status.ConnectInfo;
		}
		if (!_statusLabel)
		{
			return;
		}
		if (_proximaInspector.Status.Connections > 0)
		{
			if (_isPortrait)
			{
				_statusLabel.text = "Connected: " + _proximaInspector.Status.Connections;
			}
			else
			{
				_statusLabel.text = "Proxima connected to " + _proximaInspector.Status.Connections + ((_proximaInspector.Status.Connections > 1) ? " clients." : " client.");
			}
		}
		else if (_proximaInspector.Status.Error != null)
		{
			_statusLabel.text = _proximaInspector.Status.Error;
		}
		else if (_proximaInspector.Status.Listening)
		{
			_statusLabel.text = (_isPortrait ? "Listening" : "Proxima is listening for connections.");
		}
	}

	private void Update()
	{
		bool flag = (float)Screen.width / (float)Screen.height < 0.75f;
		if (_isPortrait != flag)
		{
			_isPortrait = flag;
			UpdateUI();
		}
	}
}
