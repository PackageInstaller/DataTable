using System.Text;
using ACT.Event;
using ACT.Game;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class MonoUIDtxt : MonoBehaviour
{
	public TextMeshProUGUI FPSText;

	public TextMeshProUGUI UIDText;

	public float updateInterval = 0.5f;

	public bool showFps;

	private readonly StringBuilder _textBuilder = new StringBuilder(32);

	private int _frameCount;

	private float _accumulatedTime;

	private float _currentFPS;

	public void gainID()
	{
		long valueOrDefault = (G.detailUserInfo?.Brief?.AccountId).GetValueOrDefault();
		if (valueOrDefault <= 0)
		{
			gameObject.SetActive(value: false);
			return;
		}
		_textBuilder.Clear().Append(valueOrDefault);
		UIDText.SetText(_textBuilder);
		gameObject.SetActive(value: true);
	}

	private void Update()
	{
		if (!showFps)
		{
			return;
		}
		_frameCount++;
		_accumulatedTime += Time.unscaledDeltaTime;
		if (_accumulatedTime >= updateInterval)
		{
			_currentFPS = (float)_frameCount / _accumulatedTime;
			if (FPSText != null)
			{
				FPSText.SetText("FPS: {0}", (int)_currentFPS);
			}
			_frameCount = 0;
			_accumulatedTime = 0f;
		}
	}

	public void Start()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ShowFps, OnShowFPS);
		SettingBool settingBool = SettingsManager.Instance?.RuntimeSettings?.GetSettingBool("Other.ShowFrameRate");
		if (settingBool != null)
		{
			ApplyShowFPS(settingBool.GetValue());
		}
	}

	public void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ShowFps, OnShowFPS);
	}

	public void OnShowFPS(BaseEventContent obj)
	{
		if (obj is ShowFps showFps)
		{
			ApplyShowFPS(showFps.show);
		}
	}

	private void ApplyShowFPS(bool value)
	{
		showFps = value;
		FPSText.gameObject.SetActive(value);
	}
}
