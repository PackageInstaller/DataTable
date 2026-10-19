using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

[CreateAssetMenu(menuName = "ACT/UI/Text Animator Tags/Wave")]
public sealed class WaveTextAnimatorTagParserRule : TextAnimatorTagParserRuleBase
{
	private sealed class WaveTextAnimatorTagParser : TextAnimatorRuntimeTagParser, ITextAnimatorEffectHandler
	{
		private struct OpenRange
		{
			public int StartIndex;

			public float Amplitude;

			public float Speed;

			public float Frequency;
		}

		private readonly List<OpenRange> m_openRanges = new List<OpenRange>();

		private readonly float m_defaultAmplitude;

		private readonly float m_defaultSpeed;

		private readonly float m_defaultFrequency;

		public WaveTextAnimatorTagParser(string tagName, float defaultAmplitude, float defaultSpeed, float defaultFrequency)
			: base(tagName)
		{
			m_defaultAmplitude = defaultAmplitude;
			m_defaultSpeed = defaultSpeed;
			m_defaultFrequency = defaultFrequency;
		}

		protected override void OnResetParser()
		{
			m_openRanges.Clear();
		}

		protected override void ProcessTag(ReadOnlySpan<char> textInsideBrackets, int attributesStart, bool isClosing, ref int realTextIndex)
		{
			if (isClosing)
			{
				CloseRange(realTextIndex);
				return;
			}
			m_openRanges.Add(new OpenRange
			{
				StartIndex = realTextIndex,
				Amplitude = TextAnimatorTagParserUtility.ReadFloat(textInsideBrackets, attributesStart, m_defaultAmplitude, "amp", "amplitude"),
				Speed = TextAnimatorTagParserUtility.ReadFloat(textInsideBrackets, attributesStart, m_defaultSpeed, "speed", "value"),
				Frequency = TextAnimatorTagParserUtility.ReadFloat(textInsideBrackets, attributesStart, m_defaultFrequency, "freq", "frequency")
			});
		}

		private void CloseRange(int realTextIndex)
		{
			int num = m_openRanges.Count - 1;
			if (num >= 0)
			{
				OpenRange openRange = m_openRanges[num];
				m_openRanges.RemoveAt(num);
				int num2 = realTextIndex - openRange.StartIndex;
				if (num2 > 0)
				{
					Context.AddEffectRange(new TextAnimatorEffectRange
					{
						Handler = this,
						StartIndex = openRange.StartIndex,
						Length = num2,
						Amplitude = openRange.Amplitude,
						Speed = openRange.Speed,
						Frequency = openRange.Frequency
					});
				}
			}
		}

		public Vector3 GetOffset(in TextAnimatorEffectRange range, int charIndex, float time)
		{
			float f = time * range.Speed + (float)charIndex * range.Frequency;
			return new Vector3(0f, Mathf.Sin(f) * range.Amplitude, 0f);
		}

		Vector3 ITextAnimatorEffectHandler.GetOffset(in TextAnimatorEffectRange range, int charIndex, float time)
		{
			return GetOffset(in range, charIndex, time);
		}
	}

	public float amplitude = 6f;

	public float speed = 6f;

	public float frequency = 0.8f;

	public override ITagParserBase CreateParser()
	{
		return new WaveTextAnimatorTagParser("wave", amplitude, speed, frequency);
	}
}
