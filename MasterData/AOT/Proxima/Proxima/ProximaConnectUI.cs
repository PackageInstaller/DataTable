using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.UI;

namespace Proxima;

[HelpURL("https://www.unityproxima.com/docs")]
public class ProximaConnectUI : MonoBehaviour
{
	[SerializeField]
	private ProximaInspector _proximaInspector;

	[SerializeField]
	private TMP_InputField _displayNameInputField;

	[SerializeField]
	private TMP_InputField _passwordInputField;

	[SerializeField]
	private TMP_Text _errorLabel;

	[SerializeField]
	private Button _startButton;

	[SerializeField]
	private Button _openButton;

	[SerializeField]
	private Button _stopButton;

	[SerializeField]
	private GameObject _connectUIRoot;

	[SerializeField]
	private GameObject _startedUIRoot;

	[SerializeField]
	private Button _showHideButton;

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

	public TMP_InputField DisplayNameInputField
	{
		get
		{
			return _displayNameInputField;
		}
		set
		{
			_displayNameInputField = value;
		}
	}

	public TMP_InputField PasswordInputField
	{
		get
		{
			return _passwordInputField;
		}
		set
		{
			_passwordInputField = value;
		}
	}

	public TMP_Text ErrorLabel
	{
		get
		{
			return _errorLabel;
		}
		set
		{
			_errorLabel = value;
		}
	}

	public Button StartButton
	{
		get
		{
			return _startButton;
		}
		set
		{
			_startButton = value;
		}
	}

	public Button OpenButton
	{
		get
		{
			return _openButton;
		}
		set
		{
			_openButton = value;
		}
	}

	public Button StopButton
	{
		get
		{
			return _stopButton;
		}
		set
		{
			_stopButton = value;
		}
	}

	public GameObject ConnectUIRoot
	{
		get
		{
			return _connectUIRoot;
		}
		set
		{
			_connectUIRoot = value;
		}
	}

	public GameObject StartedUIRoot
	{
		get
		{
			return _startedUIRoot;
		}
		set
		{
			_startedUIRoot = value;
		}
	}

	public Button ShowHideButton
	{
		get
		{
			return _showHideButton;
		}
		set
		{
			_showHideButton = value;
		}
	}

	private void Start()
	{
		if (EventSystem.current == null)
		{
			gameObject.AddComponent<EventSystem>();
			gameObject.AddComponent<StandaloneInputModule>();
		}
		_proximaInspector.Status.Changed += OnStatusChanged;
		_displayNameInputField.text = _proximaInspector.DisplayName;
		_displayNameInputField.onSubmit.AddListener((string s) =>
		{
			_passwordInputField.Select();
		});
		_startButton.onClick.AddListener(OnStartButtonClicked);
		if ((bool)_openButton)
		{
			_openButton.onClick.AddListener(() =>
			{
				Application.OpenURL(_proximaInspector.Status.ConnectInfo);
			});
		}
		_stopButton.onClick.AddListener(OnStopButtonClicked);
		_showHideButton.onClick.AddListener(TogglePanel);
		_passwordInputField.onSubmit.AddListener((string s) =>
		{
			OnStartButtonClicked();
		});
		OnStatusChanged();
	}

	private void OnDestroy()
	{
		if ((bool)_proximaInspector)
		{
			_proximaInspector.Status.Changed -= OnStatusChanged;
		}
	}

	private void OnStatusChanged()
	{
		_startButton.interactable = !_proximaInspector.Status.IsRunning;
		if (_proximaInspector.Status.Listening)
		{
			_startedUIRoot.SetActive(value: true);
			_connectUIRoot.SetActive(value: false);
		}
		else
		{
			_startedUIRoot.SetActive(value: false);
			_connectUIRoot.SetActive(value: true);
		}
		if (_errorLabel != null)
		{
			_errorLabel.text = _proximaInspector.Status.Error;
			_errorLabel.gameObject.SetActive(!string.IsNullOrWhiteSpace(_proximaInspector.Status.Error));
		}
	}

	private void OnStartButtonClicked()
	{
		if (_proximaInspector != null && _passwordInputField != null && _displayNameInputField != null && !_proximaInspector.Status.IsRunning)
		{
			_proximaInspector.Password = _passwordInputField.text;
			_proximaInspector.DisplayName = _displayNameInputField.text;
			_proximaInspector.Run();
		}
	}

	private void OnStopButtonClicked()
	{
		if (_proximaInspector != null)
		{
			_proximaInspector.Stop();
		}
	}

	private void Update()
	{
		if (Keyboard.current.escapeKey.isPressed)
		{
			HidePanel();
		}
	}

	public void ShowPanel()
	{
		transform.GetChild(0).gameObject.SetActive(value: true);
	}

	public void HidePanel()
	{
		transform.GetChild(0).gameObject.SetActive(value: false);
	}

	public void TogglePanel()
	{
		GameObject gameObject = transform.GetChild(0).gameObject;
		gameObject.SetActive(!gameObject.activeSelf);
	}
}
