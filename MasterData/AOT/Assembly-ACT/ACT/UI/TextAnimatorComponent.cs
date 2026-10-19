using System;
using System.Collections.Generic;
using System.Text;
using TMPro;
using UnityEngine;

namespace ACT.UI;

[RequireComponent(typeof(TextMeshProUGUI))]
public class TextAnimatorComponent : MonoBehaviour
{
	private static readonly Comparison<TextAnimatorInstantRange> InstantRangeComparison = CompareInstantRange;

	private static readonly Comparison<TextAnimatorAction> ActionComparison = CompareAction;

	[SerializeField]
	private TextAnimatorTagConfig tagConfig;

	[SerializeField]
	private string rawText;

	[SerializeField]
	private bool enableTypewriter = true;

	[SerializeField]
	private int typewriterTimeSpace = 33;

	[SerializeField]
	private bool enableFadeIn;

	[SerializeField]
	private int fadeInDuration = 200;

	[SerializeField]
	private Transform effectRoot;

	private readonly StringBuilder m_parseBuffer = new StringBuilder();

	private readonly List<ITagParserBase> m_parserCache = new List<ITagParserBase>(1);

	private readonly List<TextAnimatorTagParserRuleBase> m_cachedRules = new List<TextAnimatorTagParserRuleBase>(1);

	private readonly List<TextAnimatorAction> m_actions = new List<TextAnimatorAction>();

	private readonly List<TextAnimatorEffectRange> m_effectRanges = new List<TextAnimatorEffectRange>();

	private readonly List<TextAnimatorInstantRange> m_instantRanges = new List<TextAnimatorInstantRange>();

	private readonly TextAnimatorParseContext m_parseContext = new TextAnimatorParseContext();

	private TextAnimatorTagConfig m_cachedConfig;

	private TextMeshProUGUI m_text;

	private byte[] m_charAlphas;

	private float[] m_charStartMilliseconds;

	private bool[] m_actionTriggered;

	private Vector3[][] m_originalVertices;

	private int m_characterCount;

	private int m_visibleCharacterCount;

	private int m_nextActionIndex;

	private int m_nextInstantRangeIndex;

	private float m_typewriterElapsedMilliseconds;

	private float m_nextCharacterDelayMilliseconds;

	private float m_waitRemainingMilliseconds;

	private float m_timeSpaceMilliseconds;

	private float m_animationTime;

	private bool m_isPlaying;

	private bool m_isPaused;

	private bool m_hasAnimatedVertices;

	private bool m_geometryDirty;

	public bool IsPlaying => m_isPlaying;

	public bool IsPaused => m_isPaused;

	public bool IsFinished
	{
		get
		{
			if (!m_isPlaying)
			{
				return m_visibleCharacterCount >= m_characterCount;
			}
			return false;
		}
	}

	internal Transform EffectRoot
	{
		get
		{
			if (!effectRoot)
			{
				return transform;
			}
			return effectRoot;
		}
	}

	public TextMeshProUGUI TMP
	{
		get
		{
			if (!m_text)
			{
				m_text = GetComponent<TextMeshProUGUI>();
			}
			return m_text;
		}
	}

	public string Text
	{
		get
		{
			return rawText;
		}
		set
		{
			SetText(value, playImmediately: true);
		}
	}

	private void OnEnable()
	{
		string text = rawText;
		if (string.IsNullOrEmpty(text))
		{
			text = TMP.text;
		}
		if (!string.IsNullOrEmpty(text))
		{
			SetText(text, playImmediately: true);
		}
	}

	private void OnDisable()
	{
		if (m_hasAnimatedVertices && (bool)m_text)
		{
			RestoreOriginalVertices();
		}
	}

	private void OnRectTransformDimensionsChange()
	{
		m_geometryDirty = true;
	}

	private void Update()
	{
		RefreshGeometryIfNeeded();
		float unscaledDeltaTime = Time.unscaledDeltaTime;
		if (!m_isPaused)
		{
			m_animationTime += unscaledDeltaTime;
		}
		if (m_isPlaying && !m_isPaused)
		{
			if (enableTypewriter)
			{
				UpdateTypewriter(unscaledDeltaTime);
			}
			else
			{
				Play();
			}
		}
		UpdateVertexAnimations();
	}

	public void SetText(string text)
	{
		SetText(text, playImmediately: true);
	}

	public void SetText(string text, bool playImmediately)
	{
		rawText = text ?? string.Empty;
		ParseRawText();
		ResetPlaybackState();
		if (playImmediately)
		{
			Play();
		}
	}

	public void Play()
	{
		if (m_characterCount == 0)
		{
			m_isPlaying = false;
			m_isPaused = false;
		}
		else if (!enableTypewriter)
		{
			for (int i = m_visibleCharacterCount; i < m_characterCount; i++)
			{
				SetCharStartMilliseconds(i, -1f);
				SetCharAlpha(i, byte.MaxValue);
			}
			TMP.UpdateVertexData(TMP_VertexDataUpdateFlags.Colors32);
			m_visibleCharacterCount = m_characterCount;
			TriggerActionsUpTo(m_characterCount);
			m_isPlaying = false;
			m_isPaused = false;
		}
		else
		{
			m_isPlaying = true;
			m_isPaused = false;
		}
	}

	public void Pause()
	{
		m_isPaused = true;
	}

	public void Resume()
	{
		m_isPaused = false;
	}

	public void Complete()
	{
		TriggerActionsUpTo(m_characterCount);
		m_visibleCharacterCount = m_characterCount;
		m_isPlaying = false;
		m_isPaused = false;
		for (int i = 0; i < m_characterCount; i++)
		{
			SetCharStartMilliseconds(i, -1f);
			SetCharAlpha(i, byte.MaxValue);
		}
		TMP.UpdateVertexData(TMP_VertexDataUpdateFlags.Colors32);
		UpdateVertexAnimations();
	}

	public void Restart()
	{
		ResetPlaybackState();
		Play();
	}

	private void ParseRawText()
	{
		if (m_hasAnimatedVertices)
		{
			RestoreOriginalVertices();
		}
		m_actions.Clear();
		m_effectRanges.Clear();
		m_instantRanges.Clear();
		m_parseContext.Reset(m_actions, m_effectRanges, m_instantRanges);
		EnsureParserCache();
		ResetParserCache();
		string text = TextParser.ParseText(rawText, m_parseBuffer, m_parserCache);
		if (m_actions.Count > 1)
		{
			m_actions.Sort(ActionComparison);
		}
		if (m_instantRanges.Count > 1)
		{
			m_instantRanges.Sort(InstantRangeComparison);
		}
		TMP.text = text;
		TMP.ForceMeshUpdate(ignoreActiveState: true);
		TMP.havePropertiesChanged = false;
		m_geometryDirty = false;
		m_characterCount = TMP.textInfo.characterCount;
		if (m_characterCount == 0)
		{
			TMP.ClearMesh(uploadGeometry: true);
			m_originalVertices = null;
			m_hasAnimatedVertices = false;
		}
		else
		{
			EnsureCharacterBuffers();
			CacheOriginalVertices();
		}
	}

	private static int CompareInstantRange(TextAnimatorInstantRange left, TextAnimatorInstantRange right)
	{
		return left.StartIndex.CompareTo(right.StartIndex);
	}

	private static int CompareAction(TextAnimatorAction left, TextAnimatorAction right)
	{
		return left.Index.CompareTo(right.Index);
	}

	private void EnsureParserCache()
	{
		if (!tagConfig)
		{
			m_cachedConfig = null;
			m_parserCache.Clear();
			m_cachedRules.Clear();
		}
		else if (!(m_cachedConfig == tagConfig) || !tagConfig.HasSameRules(m_cachedRules))
		{
			m_cachedConfig = tagConfig;
			tagConfig.BuildParserCache(m_parserCache, m_cachedRules);
		}
	}

	private void ResetParserCache()
	{
		for (int i = 0; i < m_parserCache.Count; i++)
		{
			if (m_parserCache[i] is ITextAnimatorRuntimeTagParser textAnimatorRuntimeTagParser)
			{
				textAnimatorRuntimeTagParser.ResetParser(m_parseContext);
			}
		}
	}

	private void ResetPlaybackState()
	{
		m_visibleCharacterCount = ((!enableTypewriter) ? m_characterCount : 0);
		m_nextActionIndex = 0;
		m_nextInstantRangeIndex = 0;
		m_typewriterElapsedMilliseconds = 0f;
		m_nextCharacterDelayMilliseconds = 0f;
		m_waitRemainingMilliseconds = 0f;
		m_timeSpaceMilliseconds = Mathf.Max(0f, typewriterTimeSpace);
		m_animationTime = 0f;
		m_isPlaying = false;
		m_isPaused = false;
		m_hasAnimatedVertices = false;
		if (m_actionTriggered != null)
		{
			Array.Clear(m_actionTriggered, 0, m_actionTriggered.Length);
		}
		for (int i = 0; i < m_characterCount; i++)
		{
			SetCharAlpha(i, (byte)((!enableTypewriter) ? byte.MaxValue : 0));
			SetCharStartMilliseconds(i, enableTypewriter ? 0f : (-1f));
		}
		TMP.UpdateVertexData(TMP_VertexDataUpdateFlags.Colors32);
		RestoreOriginalVertices();
	}

	private void RefreshGeometryIfNeeded()
	{
		TextMeshProUGUI tMP = TMP;
		if (m_geometryDirty || tMP.havePropertiesChanged)
		{
			if (m_hasAnimatedVertices)
			{
				RestoreOriginalVertices();
			}
			tMP.ForceMeshUpdate(ignoreActiveState: true);
			tMP.havePropertiesChanged = false;
			m_geometryDirty = false;
			m_characterCount = tMP.textInfo.characterCount;
			if (m_visibleCharacterCount > m_characterCount)
			{
				m_visibleCharacterCount = m_characterCount;
			}
			EnsureCharacterBuffers(clearBuffers: false);
			CacheOriginalVertices();
			ReapplyCurrentAlphas();
		}
	}

	private void UpdateTypewriter(float deltaTime)
	{
		if (m_characterCount == 0)
		{
			m_isPlaying = false;
			return;
		}
		float num = deltaTime * 1000f;
		bool colorChanged = false;
		while (num > 0f && m_visibleCharacterCount <= m_characterCount)
		{
			TriggerActionsUpTo(m_visibleCharacterCount);
			if (m_waitRemainingMilliseconds > 0f)
			{
				float num2 = Mathf.Min(num, m_waitRemainingMilliseconds);
				AdvanceTypewriterTime(num2, ref colorChanged);
				m_waitRemainingMilliseconds -= num2;
				num -= num2;
				if (m_waitRemainingMilliseconds > 0f)
				{
					if (colorChanged)
					{
						TMP.UpdateVertexData(TMP_VertexDataUpdateFlags.Colors32);
					}
					return;
				}
				m_waitRemainingMilliseconds = 0f;
				continue;
			}
			if (m_visibleCharacterCount >= m_characterCount)
			{
				if (HasActiveFadeIn())
				{
					AdvanceTypewriterTime(num, ref colorChanged);
					num = 0f;
					if (HasActiveFadeIn())
					{
						break;
					}
				}
				m_isPlaying = false;
				break;
			}
			if (RevealInstantRangesAtCurrentIndex(ref colorChanged))
			{
				TriggerActionsUpTo(m_visibleCharacterCount);
				if (m_visibleCharacterCount < m_characterCount && m_nextCharacterDelayMilliseconds <= 0f)
				{
					m_nextCharacterDelayMilliseconds = m_timeSpaceMilliseconds;
				}
			}
			else if (m_nextCharacterDelayMilliseconds <= 0f)
			{
				StartNextTypewriterCharacter(ref colorChanged);
				if (m_visibleCharacterCount < m_characterCount)
				{
					m_nextCharacterDelayMilliseconds = m_timeSpaceMilliseconds;
				}
			}
			else
			{
				float num3 = Mathf.Min(num, m_nextCharacterDelayMilliseconds);
				AdvanceTypewriterTime(num3, ref colorChanged);
				m_nextCharacterDelayMilliseconds -= num3;
				num -= num3;
			}
		}
		if (colorChanged)
		{
			TMP.UpdateVertexData(TMP_VertexDataUpdateFlags.Colors32);
		}
	}

	private void StartNextTypewriterCharacter(ref bool colorChanged)
	{
		if (m_visibleCharacterCount < m_characterCount)
		{
			SetCharStartMilliseconds(m_visibleCharacterCount, m_typewriterElapsedMilliseconds);
			byte typewriterAlpha = GetTypewriterAlpha(m_typewriterElapsedMilliseconds, m_typewriterElapsedMilliseconds);
			SetCharAlpha(m_visibleCharacterCount, typewriterAlpha);
			m_visibleCharacterCount++;
			colorChanged = true;
		}
	}

	private void AdvanceTypewriterTime(float milliseconds, ref bool colorChanged)
	{
		if (!(milliseconds <= 0f))
		{
			m_typewriterElapsedMilliseconds += milliseconds;
			UpdateStartedCharacterAlphas(ref colorChanged);
		}
	}

	private void UpdateStartedCharacterAlphas(ref bool colorChanged)
	{
		if (!enableFadeIn || fadeInDuration <= 0 || m_charStartMilliseconds == null)
		{
			return;
		}
		for (int i = 0; i < m_visibleCharacterCount; i++)
		{
			float num = m_charStartMilliseconds[i];
			if (!(num < 0f))
			{
				byte typewriterAlpha = GetTypewriterAlpha(m_typewriterElapsedMilliseconds, num);
				if (m_charAlphas[i] != typewriterAlpha)
				{
					SetCharAlpha(i, typewriterAlpha);
					colorChanged = true;
				}
			}
		}
	}

	private byte GetTypewriterAlpha(float currentMilliseconds, float startMilliseconds)
	{
		if (!enableFadeIn || fadeInDuration <= 0)
		{
			return byte.MaxValue;
		}
		return (byte)(Mathf.Clamp01((currentMilliseconds - startMilliseconds) / (float)fadeInDuration) * 255f);
	}

	private bool HasActiveFadeIn()
	{
		if (!enableFadeIn || fadeInDuration <= 0 || m_charAlphas == null)
		{
			return false;
		}
		for (int i = 0; i < m_visibleCharacterCount; i++)
		{
			if (m_charAlphas[i] < byte.MaxValue)
			{
				return true;
			}
		}
		return false;
	}

	private bool RevealInstantRangesAtCurrentIndex(ref bool colorChanged)
	{
		bool result = false;
		while (m_nextInstantRangeIndex < m_instantRanges.Count)
		{
			TextAnimatorInstantRange textAnimatorInstantRange = m_instantRanges[m_nextInstantRangeIndex];
			int num = Mathf.Clamp(textAnimatorInstantRange.StartIndex, 0, m_characterCount);
			int num2 = Mathf.Clamp(textAnimatorInstantRange.StartIndex + textAnimatorInstantRange.Length, 0, m_characterCount);
			if (num2 <= m_visibleCharacterCount)
			{
				m_nextInstantRangeIndex++;
				continue;
			}
			if (num > m_visibleCharacterCount)
			{
				break;
			}
			for (int i = m_visibleCharacterCount; i < num2; i++)
			{
				SetCharStartMilliseconds(i, -1f);
				SetCharAlpha(i, byte.MaxValue);
			}
			m_visibleCharacterCount = num2;
			m_nextInstantRangeIndex++;
			colorChanged = true;
			result = true;
		}
		return result;
	}

	private void TriggerActionsUpTo(int characterIndex)
	{
		while (m_nextActionIndex < m_actions.Count && m_actions[m_nextActionIndex].Index <= characterIndex)
		{
			if (m_actionTriggered == null || m_nextActionIndex >= m_actionTriggered.Length || m_actionTriggered[m_nextActionIndex])
			{
				m_nextActionIndex++;
				continue;
			}
			TextAnimatorAction action = m_actions[m_nextActionIndex];
			m_actionTriggered[m_nextActionIndex] = true;
			m_nextActionIndex++;
			action.Handler?.Execute(this, in action);
		}
	}

	internal void Wait(float milliseconds)
	{
		m_waitRemainingMilliseconds = Mathf.Max(m_waitRemainingMilliseconds, Mathf.Max(0f, milliseconds));
	}

	internal void SetTypewriterTimeSpace(float milliseconds)
	{
		m_timeSpaceMilliseconds = Mathf.Max(0f, milliseconds);
	}

	internal Vector3 GetCharacterLocalPosition(int characterIndex)
	{
		if (characterIndex < 0 || characterIndex >= m_characterCount)
		{
			return Vector3.zero;
		}
		TMP_CharacterInfo tMP_CharacterInfo = TMP.textInfo.characterInfo[characterIndex];
		if (!tMP_CharacterInfo.isVisible)
		{
			return Vector3.zero;
		}
		return (tMP_CharacterInfo.bottomLeft + tMP_CharacterInfo.topRight) * 0.5f;
	}

	private void UpdateVertexAnimations()
	{
		if (m_effectRanges.Count == 0)
		{
			if (m_hasAnimatedVertices)
			{
				RestoreOriginalVertices();
			}
			return;
		}
		RestoreOriginalVertices(uploadGeometry: false);
		TMP_TextInfo textInfo = TMP.textInfo;
		float animationTime = m_animationTime;
		for (int i = 0; i < m_effectRanges.Count; i++)
		{
			TextAnimatorEffectRange range = m_effectRanges[i];
			int num = Mathf.Min(range.StartIndex + range.Length, Mathf.Min(m_visibleCharacterCount, m_characterCount));
			for (int j = range.StartIndex; j < num; j++)
			{
				TMP_CharacterInfo tMP_CharacterInfo = textInfo.characterInfo[j];
				if (tMP_CharacterInfo.isVisible && range.Handler != null)
				{
					Vector3 offset = range.Handler.GetOffset(in range, j, animationTime);
					int materialReferenceIndex = tMP_CharacterInfo.materialReferenceIndex;
					int vertexIndex = tMP_CharacterInfo.vertexIndex;
					Vector3[] vertices = textInfo.meshInfo[materialReferenceIndex].vertices;
					vertices[vertexIndex] += offset;
					vertices[vertexIndex + 1] += offset;
					vertices[vertexIndex + 2] += offset;
					vertices[vertexIndex + 3] += offset;
				}
			}
		}
		for (int k = 0; k < textInfo.meshInfo.Length; k++)
		{
			textInfo.meshInfo[k].mesh.vertices = textInfo.meshInfo[k].vertices;
			TMP.UpdateGeometry(textInfo.meshInfo[k].mesh, k);
		}
		m_hasAnimatedVertices = true;
	}

	private void EnsureCharacterBuffers()
	{
		EnsureCharacterBuffers(clearBuffers: true);
	}

	private void EnsureCharacterBuffers(bool clearBuffers)
	{
		if (m_charAlphas == null || m_charAlphas.Length < m_characterCount)
		{
			m_charAlphas = new byte[Mathf.Max(32, m_characterCount)];
		}
		else if (clearBuffers)
		{
			Array.Clear(m_charAlphas, 0, m_charAlphas.Length);
		}
		if (m_charStartMilliseconds == null || m_charStartMilliseconds.Length < m_characterCount)
		{
			float[] charStartMilliseconds = m_charStartMilliseconds;
			m_charStartMilliseconds = new float[Mathf.Max(32, m_characterCount)];
			if (!clearBuffers && charStartMilliseconds != null)
			{
				Array.Copy(charStartMilliseconds, m_charStartMilliseconds, Math.Min(charStartMilliseconds.Length, m_charStartMilliseconds.Length));
			}
		}
		else if (clearBuffers)
		{
			Array.Clear(m_charStartMilliseconds, 0, m_charStartMilliseconds.Length);
		}
		if (m_actionTriggered == null || m_actionTriggered.Length < m_actions.Count)
		{
			bool[] actionTriggered = m_actionTriggered;
			m_actionTriggered = new bool[Mathf.Max(8, m_actions.Count)];
			if (!clearBuffers && actionTriggered != null)
			{
				Array.Copy(actionTriggered, m_actionTriggered, Math.Min(actionTriggered.Length, m_actionTriggered.Length));
			}
		}
		else if (clearBuffers)
		{
			Array.Clear(m_actionTriggered, 0, m_actionTriggered.Length);
		}
	}

	private void ReapplyCurrentAlphas()
	{
		for (int i = 0; i < m_characterCount; i++)
		{
			byte alpha = ((m_charAlphas != null && i < m_charAlphas.Length) ? m_charAlphas[i] : ((byte)((i < m_visibleCharacterCount) ? 255u : 0u)));
			SetCharAlpha(i, alpha);
		}
		TMP.UpdateVertexData(TMP_VertexDataUpdateFlags.Colors32);
	}

	private void SetCharStartMilliseconds(int characterIndex, float milliseconds)
	{
		if (m_charStartMilliseconds != null && characterIndex >= 0 && characterIndex < m_charStartMilliseconds.Length)
		{
			m_charStartMilliseconds[characterIndex] = milliseconds;
		}
	}

	private void SetCharAlpha(int characterIndex, byte alpha)
	{
		if (characterIndex < 0 || characterIndex >= m_characterCount)
		{
			return;
		}
		m_charAlphas[characterIndex] = alpha;
		TMP_CharacterInfo tMP_CharacterInfo = TMP.textInfo.characterInfo[characterIndex];
		if (tMP_CharacterInfo.isVisible)
		{
			int materialReferenceIndex = tMP_CharacterInfo.materialReferenceIndex;
			if (materialReferenceIndex >= 0 && materialReferenceIndex < TMP.textInfo.meshInfo.Length)
			{
				int vertexIndex = tMP_CharacterInfo.vertexIndex;
				Color32[] colors = TMP.textInfo.meshInfo[materialReferenceIndex].colors32;
				colors[vertexIndex].a = alpha;
				colors[vertexIndex + 1].a = alpha;
				colors[vertexIndex + 2].a = alpha;
				colors[vertexIndex + 3].a = alpha;
			}
		}
	}

	private void CacheOriginalVertices()
	{
		TMP_MeshInfo[] meshInfo = TMP.textInfo.meshInfo;
		if (m_originalVertices == null || m_originalVertices.Length != meshInfo.Length)
		{
			m_originalVertices = new Vector3[meshInfo.Length][];
		}
		for (int i = 0; i < meshInfo.Length; i++)
		{
			Vector3[] vertices = meshInfo[i].vertices;
			if (m_originalVertices[i] == null || m_originalVertices[i].Length != vertices.Length)
			{
				m_originalVertices[i] = new Vector3[vertices.Length];
			}
			Array.Copy(vertices, m_originalVertices[i], vertices.Length);
		}
	}

	private void RestoreOriginalVertices()
	{
		RestoreOriginalVertices(uploadGeometry: true);
	}

	private void RestoreOriginalVertices(bool uploadGeometry)
	{
		if (m_originalVertices == null)
		{
			return;
		}
		TMP_MeshInfo[] meshInfo = TMP.textInfo.meshInfo;
		int num = Mathf.Min(meshInfo.Length, m_originalVertices.Length);
		for (int i = 0; i < num; i++)
		{
			if (m_originalVertices[i] != null)
			{
				Vector3[] vertices = meshInfo[i].vertices;
				int length = Mathf.Min(vertices.Length, m_originalVertices[i].Length);
				Array.Copy(m_originalVertices[i], vertices, length);
				if (uploadGeometry)
				{
					meshInfo[i].mesh.vertices = vertices;
					TMP.UpdateGeometry(meshInfo[i].mesh, i);
				}
			}
		}
		m_hasAnimatedVertices = false;
	}
}
