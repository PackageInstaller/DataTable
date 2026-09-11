using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RollingNumberText : MonoBehaviour
{
	[Header("基础设置")]
	[SerializeField]
	private Text _numberPrefab;

	[SerializeField]
	private Transform _numbersParent;

	[SerializeField]
	private int _maxDigits = 8;

	[Header("动画参数")]
	[SerializeField]
	private float _duration = 1f;

	[SerializeField]
	private float _rollingDuration = 0.05f;

	[SerializeField]
	private float _delay = 0.008f;

	[Header("布局设置")]
	[SerializeField]
	private bool _useNumSpacing = true;

	[SerializeField]
	private float _spacing = 30f;

	[SerializeField]
	private bool _rightAligned = true;

	[SerializeField]
	private bool _hideLeadingZeros = true;

	private List<Text> _numbers = new List<Text>();

	private List<Text> _unactiveNumbers = new List<Text>();

	private Vector2 _numberSize;

	private int _curNumber;

	private int _fromNumber;

	private int _toNumber;

	private List<LTDescr> _tweener = new List<LTDescr>();

	private bool _isJumping;

	private int _speed;

	private float _different;

	public Action OnComplete;

	private bool NotuseNumSpacing => !_useNumSpacing;

	public int number
	{
		get
		{
			return _toNumber;
		}
		set
		{
			if (_toNumber != value)
			{
				Change(_curNumber, value);
			}
		}
	}

	private void Awake()
	{
		if (_numberPrefab == null)
		{
			Debug.LogError("[RollingNumberText] 需要设置数字预制体!");
			return;
		}
		_numberSize = _numberPrefab.rectTransform.sizeDelta;
		InitializeDigits();
	}

	private void InitializeDigits()
	{
		ClearDigits();
		for (int i = 0; i < _maxDigits; i++)
		{
			Text text = UnityEngine.Object.Instantiate(_numberPrefab, _numbersParent);
			text.text = "0";
			text.gameObject.name = $"Number_{i}";
			_numbers.Add(text);
			Text text2 = UnityEngine.Object.Instantiate(_numberPrefab, _numbersParent);
			text2.text = "0";
			text2.gameObject.name = $"UnactiveNumber_{i}";
			_unactiveNumbers.Add(text2);
			text2.rectTransform.anchoredPosition = new Vector2(0f, 0f - _numberSize.y);
		}
		UpdateLayout();
	}

	private void ClearDigits()
	{
		foreach (Text number in _numbers)
		{
			if (number != null)
			{
				UnityEngine.Object.Destroy(number.gameObject);
			}
		}
		foreach (Text unactiveNumber in _unactiveNumbers)
		{
			if (unactiveNumber != null)
			{
				UnityEngine.Object.Destroy(unactiveNumber.gameObject);
			}
		}
		_numbers.Clear();
		_unactiveNumbers.Clear();
	}

	private void UpdateLayout()
	{
		float num = (_useNumSpacing ? _numberPrefab.GetRectWidth() : _spacing);
		if (_rightAligned)
		{
			for (int i = 0; i < _maxDigits; i++)
			{
				float x = (float)(-i) * num;
				Vector2 vector = new Vector2(x, 0f);
				if (i < _numbers.Count)
				{
					_numbers[i].rectTransform.anchoredPosition = vector;
					_unactiveNumbers[i].rectTransform.anchoredPosition = vector + new Vector2(0f, 0f - _numberSize.y);
				}
			}
			return;
		}
		int digitCount = GetDigitCount(number);
		_numbersParent.GetRectWidth();
		if (digitCount % 2 == 0)
		{
			int num2 = digitCount / 2 - 1;
			for (int j = 0; j < digitCount; j++)
			{
				float x2 = (float)(num2 - j) * num + num / 2f;
				Vector2 vector2 = new Vector2(x2, 0f);
				if (j < _numbers.Count)
				{
					_numbers[j].rectTransform.anchoredPosition = vector2;
					_unactiveNumbers[j].rectTransform.anchoredPosition = vector2 + new Vector2(0f, 0f - _numberSize.y);
				}
			}
			return;
		}
		int num3 = (digitCount + 1) / 2;
		for (int k = 0; k < _maxDigits; k++)
		{
			float x3 = (float)(num3 - k - 1) * num;
			Vector2 vector3 = new Vector2(x3, 0f);
			if (k < _numbers.Count)
			{
				_numbers[k].rectTransform.anchoredPosition = vector3;
				_unactiveNumbers[k].rectTransform.anchoredPosition = vector3 + new Vector2(0f, 0f - _numberSize.y);
			}
		}
	}

	private void UpdateNumberVisibility(int number)
	{
		if (!_hideLeadingZeros)
		{
			for (int i = 0; i < _maxDigits; i++)
			{
				_numbers[i].gameObject.SetActive(value: true);
				_unactiveNumbers[i].gameObject.SetActive(value: true);
			}
			return;
		}
		int digitCount = GetDigitCount(number);
		bool flag = false;
		for (int j = 0; j <= _maxDigits - 1; j++)
		{
			if (j < digitCount || (number == 0 && j == _maxDigits - 1))
			{
				_numbers[j].gameObject.SetActive(value: true);
				_unactiveNumbers[j].gameObject.SetActive(value: true);
				flag = true;
			}
			else
			{
				_numbers[j].gameObject.SetActive(value: false);
				_unactiveNumbers[j].gameObject.SetActive(value: false);
			}
		}
		if (!flag && _maxDigits > 0)
		{
			_numbers[_maxDigits - 1].gameObject.SetActive(value: true);
			_unactiveNumbers[_maxDigits - 1].gameObject.SetActive(value: true);
		}
	}

	public void SetMaxDigits(int maxDigits)
	{
		if (maxDigits > 0)
		{
			_maxDigits = maxDigits;
			InitializeDigits();
		}
	}

	private void AdjustDigits(int targetNumber)
	{
		int digitCount = GetDigitCount(targetNumber);
		if (digitCount > _maxDigits)
		{
			SetMaxDigits(digitCount);
		}
	}

	private int GetDigitCount(int number)
	{
		if (number == 0)
		{
			return 1;
		}
		return (int)Math.Floor(Math.Log10(Math.Abs(number))) + 1;
	}

	public void Change(int from, int to)
	{
		AdjustDigits(Math.Max(Math.Abs(from), Math.Abs(to)));
		if (!_isJumping || _fromNumber != from || _toNumber != to)
		{
			bool flag = _toNumber == from && ((to - from > 0 && _different > 0f) || (to - from < 0 && _different < 0f));
			if (!(_isJumping & flag))
			{
				_fromNumber = from;
				_curNumber = _fromNumber;
			}
			_toNumber = to;
			UpdateLayout();
			_different = _toNumber - _fromNumber;
			_speed = (int)Math.Ceiling(_different / (_duration * (1f / _rollingDuration)));
			_speed = ((_speed != 0) ? _speed : ((_different > 0f) ? 1 : (-1)));
			SetNumber(_curNumber, isTween: false);
			_isJumping = true;
			StopCoroutine("DoJumpNumber");
			StartCoroutine("DoJumpNumber");
		}
	}

	private IEnumerator DoJumpNumber()
	{
		while (true)
		{
			if (_speed > 0)
			{
				_curNumber = Math.Min(_curNumber + _speed, _toNumber);
			}
			else if (_speed < 0)
			{
				_curNumber = Math.Max(_curNumber + _speed, _toNumber);
			}
			SetNumber(_curNumber, isTween: true);
			if (_curNumber == _toNumber)
			{
				StopCoroutine("DoJumpNumber");
				_isJumping = false;
				OnComplete?.Invoke();
				yield return null;
			}
			yield return new WaitForSeconds(_rollingDuration);
		}
	}

	public void SetNumber(int v, bool isTween)
	{
		int num = Math.Max(0, v);
		UpdateNumberVisibility(num);
		char[] array = num.ToString().ToCharArray();
		Array.Reverse(array);
		string text = new string(array);
		if (!isTween)
		{
			for (int i = 0; i < _numbers.Count; i++)
			{
				if (i < text.Length && _numbers[i].gameObject.activeSelf)
				{
					_numbers[i].text = text[i].ToString();
				}
				else if (_numbers[i].gameObject.activeSelf)
				{
					_numbers[i].text = "0";
				}
			}
			return;
		}
		while (_tweener.Count > 0)
		{
			_tweener[0].setTime(_rollingDuration - _delay * (float)(_tweener.Count - 1));
			_tweener.RemoveAt(0);
		}
		for (int j = 0; j < _numbers.Count; j++)
		{
			if (_numbers[j].gameObject.activeSelf)
			{
				string text2 = ((j < text.Length) ? text[j].ToString() : "0");
				_unactiveNumbers[j].text = text2;
				_unactiveNumbers[j].rectTransform.anchoredPosition = new Vector2(_unactiveNumbers[j].rectTransform.anchoredPosition.x, (float)((_speed <= 0) ? 1 : (-1)) * _numberSize.y);
				_numbers[j].rectTransform.anchoredPosition = new Vector2(_numbers[j].rectTransform.anchoredPosition.x, 0f);
				if (_unactiveNumbers[j].text != _numbers[j].text)
				{
					DoTween(_numbers[j], (float)((_speed > 0) ? 1 : (-1)) * _numberSize.y, _delay * (float)j);
					DoTween(_unactiveNumbers[j], 0f, _delay * (float)j);
					Text value = _numbers[j];
					_numbers[j] = _unactiveNumbers[j];
					_unactiveNumbers[j] = value;
				}
			}
		}
	}

	public void DoTween(Text text, float endValue, float delay)
	{
		LTDescr item = LeanTween.move(to: new Vector2(text.rectTransform.anchoredPosition.x, endValue), rectTrans: text.rectTransform, time: _rollingDuration - delay).setDelay(delay).setEase(LeanTweenType.easeInOutQuart);
		_tweener.Add(item);
	}

	[ContextMenu("测试数字变化-六位偶数")]
	public void TestChange()
	{
		number = 654532;
	}

	[ContextMenu("测试数字变化-七位偶数")]
	public void TestChange2()
	{
		number = 6545321;
	}

	public void SetNumberImmediate(int number)
	{
		AdjustDigits(number);
		_curNumber = number;
		_toNumber = number;
		SetNumber(number, isTween: false);
	}
}
