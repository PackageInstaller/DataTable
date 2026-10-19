using System;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class FrameworkBlackFade : MonoBehaviour
{
	[SerializeField]
	private Image _blackImage;

	private Action _onFadeComplete;

	private float _targetAlpha;

	private float _fadeDir;

	private float _fadeSecondStep;

	private bool _needProcess;

	private float _currentAlpha;

	internal void Fade(float targetAlpha, float duration, Action fadeCompleteCallback)
	{
		gameObject.SetActive(value: true);
		_onFadeComplete = (Action)Delegate.Combine(_onFadeComplete, fadeCompleteCallback);
		_currentAlpha = _blackImage.color.a;
		_targetAlpha = targetAlpha;
		_fadeDir = (int)Mathf.Sign(targetAlpha - _currentAlpha);
		_fadeSecondStep = _fadeDir * (1f / duration);
		_needProcess = true;
		Update();
	}

	private void Update()
	{
		if (!_needProcess)
		{
			return;
		}
		float a = _blackImage.color.a;
		float deltaTime = Time.deltaTime;
		float num = _fadeSecondStep * deltaTime;
		float num2 = a + num;
		int num3;
		float num4;
		if (!(_fadeDir < 0f) || !(num2 <= _targetAlpha))
		{
			if (_fadeDir > 0f)
			{
				num3 = ((num2 >= _targetAlpha) ? 1 : 0);
				if (num3 != 0)
				{
					goto IL_0066;
				}
			}
			else
			{
				num3 = 0;
			}
			num4 = num2;
			goto IL_006c;
		}
		num3 = 1;
		goto IL_0066;
		IL_0066:
		num4 = _targetAlpha;
		goto IL_006c;
		IL_006c:
		float a2 = num4;
		Color color = _blackImage.color;
		color.a = a2;
		_blackImage.color = color;
		_blackImage.enabled = !Mathf.Approximately(a2, 0f);
		if (num3 != 0)
		{
			_needProcess = false;
			_onFadeComplete?.Invoke();
			_onFadeComplete = null;
			gameObject.SetActive(!Mathf.Approximately(a2, 0f));
		}
	}
}
