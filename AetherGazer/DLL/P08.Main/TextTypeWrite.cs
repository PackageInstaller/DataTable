using System;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Text))]
[RequireComponent(typeof(UITypewriterEffect))]
public class TextTypeWrite : MonoBehaviour
{
	private enum TypeFlag
	{
		Null,
		Start,
		Typing,
		End
	}

	private float textP;

	private Text _showText;

	public float velocity = 2f;

	[NonSerialized]
	public string textToShow = string.Empty;

	[NonSerialized]
	public Action finishDelegate;

	private UITypewriterEffect _typewriterEffect;

	private float _velocity;

	private float _textLen;

	private TypeFlag flag;

	private void Awake()
	{
		_typewriterEffect = GetComponent<UITypewriterEffect>();
		_showText = GetComponent<Text>();
	}

	public void StartTyping(string text, Action callBack = null)
	{
		_showText.text = text;
		textP = 0f;
		_textLen = text.Length;
		_typewriterEffect.percent = 0f;
		flag = TypeFlag.Start;
		if (callBack != null)
		{
			finishDelegate = callBack;
		}
	}

	public void ClearLinePrefixSymbol()
	{
		LuaForUtil.ClearLinePrefixSymbol(_showText);
	}

	public bool isTypeing()
	{
		return flag == TypeFlag.Typing;
	}

	public void ShowAllText()
	{
		textP = _textLen;
		_typewriterEffect.percent = 1f;
		_typewriterEffect.SetDirty();
		flag = TypeFlag.Null;
		if (finishDelegate != null)
		{
			finishDelegate();
		}
	}

	private void LateUpdate()
	{
		if (flag == TypeFlag.Start)
		{
			flag = TypeFlag.Typing;
		}
		if (flag != TypeFlag.Typing)
		{
			return;
		}
		if (textP < _textLen)
		{
			float num = Time.deltaTime * velocity;
			textP += num;
			_typewriterEffect.percent = textP / _textLen;
			_typewriterEffect.SetDirty();
			return;
		}
		_typewriterEffect.percent = 1f;
		_typewriterEffect.SetDirty();
		flag = TypeFlag.Null;
		if (finishDelegate != null)
		{
			finishDelegate();
		}
	}
}
