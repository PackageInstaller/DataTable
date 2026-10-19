using System.Collections.Generic;
using System.Text;
using Sirenix.Serialization;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class CommonNumberComponent : MonoBehaviour, IUIFrameElement
{
	public TMP_Text numberText;

	public TMP_Text slashText;

	public TMP_Text totalText;

	[Header("小于")]
	[OdinSerialize]
	public NumberConfig lessConfig;

	[Header("等于")]
	[OdinSerialize]
	public NumberConfig equalConfig;

	[Header("大于")]
	[OdinSerialize]
	public NumberConfig greaterConfig;

	public UnityAction<List<RichTagConfig>> frontPostProcessor;

	public UnityAction<List<RichTagConfig>> slashPostProcessor;

	public UnityAction<List<RichTagConfig>> behindPostProcessor;

	public UnityAction<StringBuilder> frontTextPostProcessor;

	public UnityAction<StringBuilder> slashTextPostProcessor;

	public UnityAction<StringBuilder> behindTextPostProcessor;

	private long m_CachedLeft;

	private long m_RightRight;

	private StringBuilder _frontText = new StringBuilder();

	private StringBuilder _slashCharacter = new StringBuilder();

	private StringBuilder _behindText = new StringBuilder();

	public long LeftCount => m_CachedLeft;

	public long RightCount => m_RightRight;

	public void UpdateNumber(long left, long right)
	{
		m_CachedLeft = left;
		m_RightRight = right;
		UpdateColor();
	}

	public void UpdateNumber(long left)
	{
		m_CachedLeft = left;
		UpdateColor();
	}

	public void UpdateNumberWithRandom(long left, long right, bool needRandom)
	{
		m_CachedLeft = left;
		m_RightRight = right;
		UpdateRandomText(needRandom);
	}

	private void UpdateRandomText(bool needRandom)
	{
		if (!needRandom)
		{
			_frontText.Clear().Append(m_CachedLeft);
			numberText?.SetText(_frontText);
			numberText?.gameObject.SetActive(value: true);
			slashText?.gameObject.SetActive(value: false);
			totalText?.gameObject.SetActive(value: false);
			return;
		}
		if (m_RightRight <= 0 || m_CachedLeft == m_RightRight)
		{
			_frontText.Clear().Append("?");
		}
		else
		{
			_frontText.Clear().Append(m_CachedLeft).Append("~")
				.Append(m_RightRight);
		}
		numberText?.SetText(_frontText);
		numberText?.gameObject.SetActive(value: true);
		slashText?.gameObject.SetActive(value: true);
		totalText?.gameObject.SetActive(value: true);
	}

	private void UpdateColor()
	{
		long num = m_CachedLeft - m_RightRight;
		List<RichTagConfig> frontFontConfig;
		List<RichTagConfig> slashFontConfig;
		List<RichTagConfig> backFontConfig;
		if (num <= 0)
		{
			if (num < 0)
			{
				frontFontConfig = lessConfig.frontFontConfig;
				slashFontConfig = lessConfig.slashFontConfig;
				backFontConfig = lessConfig.backFontConfig;
			}
			else
			{
				frontFontConfig = equalConfig.frontFontConfig;
				slashFontConfig = equalConfig.slashFontConfig;
				backFontConfig = equalConfig.backFontConfig;
			}
		}
		else
		{
			frontFontConfig = greaterConfig.frontFontConfig;
			slashFontConfig = greaterConfig.slashFontConfig;
			backFontConfig = greaterConfig.backFontConfig;
		}
		PostProcess(frontFontConfig, slashFontConfig, backFontConfig);
		_frontText.Clear().Append(m_CachedLeft);
		_slashCharacter.Clear().Append("/");
		_behindText.Clear().Append(m_RightRight);
		PostProcessText();
		ApplyRichText(frontFontConfig, numberText);
		ApplyRichText(slashFontConfig, slashText);
		ApplyRichText(backFontConfig, totalText);
		numberText?.SetText(_frontText);
		slashText?.SetText(_slashCharacter);
		totalText?.SetText(_behindText);
	}

	private void PostProcess(List<RichTagConfig> frontConfigs, List<RichTagConfig> slashConfigs, List<RichTagConfig> backConfigs)
	{
		frontPostProcessor?.Invoke(frontConfigs);
		slashPostProcessor?.Invoke(slashConfigs);
		behindPostProcessor?.Invoke(backConfigs);
	}

	private void PostProcessText()
	{
		frontTextPostProcessor?.Invoke(_frontText);
		slashTextPostProcessor?.Invoke(_slashCharacter);
		behindTextPostProcessor?.Invoke(_behindText);
	}

	private void ApplyRichText(List<RichTagConfig> richTagConfigs, TMP_Text text)
	{
		for (int i = 0; i < richTagConfigs.Count; i++)
		{
			RichTagConfig richTagConfig = richTagConfigs[i];
			if (!RichTextTag.tags.TryGetValue(richTagConfig.tag, out var _))
			{
				break;
			}
			switch (richTagConfig.tag)
			{
			case RichTextTag.TagType.Color:
				text.color = richTagConfig.ColorValue;
				break;
			case RichTextTag.TagType.Size:
				text.fontSize = richTagConfig.FloatValue;
				break;
			}
		}
	}
}
