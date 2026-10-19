using System;
using TMPro;
using UnityEngine;

namespace ACT.UI;

[RequireComponent(typeof(TextMeshProUGUI))]
public class MonoTypeWriterEffect : MonoBehaviour
{
	private byte[] m_charAlphas;

	private TextMeshProUGUI m_TextMeshPro;

	public int TimeSpace = 1;

	public bool EnableFadeIn;

	public int FadeInDuration = 200;

	public TypeWriterDriveMode driveMode;

	private float m_elapsedTime;

	private bool m_isActive;

	private bool m_isPaused;

	private bool m_skipNextTimeAdvance;

	public TextMeshProUGUI TMP
	{
		get
		{
			if (!m_TextMeshPro)
			{
				m_TextMeshPro = GetComponent<TextMeshProUGUI>();
			}
			return m_TextMeshPro;
		}
	}

	public bool IsFinished => GetProgress() >= 1f;

	public bool isPaused => m_isPaused;

	public float progress => GetProgress();

	public float totalDuration => GetTotalDuration();

	[Tooltip("要显示的句子")]
	public string text
	{
		get
		{
			return TMP.text;
		}
		set
		{
			StopTweenString();
			if (string.IsNullOrEmpty(value))
			{
				TMP.text = value;
				TMP.ForceMeshUpdate(ignoreActiveState: true);
				m_elapsedTime = 0f;
				m_isActive = false;
				m_skipNextTimeAdvance = false;
			}
			else
			{
				m_elapsedTime = 0f;
				m_isActive = true;
				TMP.text = value;
				TMP.ForceMeshUpdate();
				SetProgressInternal(0f);
			}
		}
	}

	private float GetTotalDuration()
	{
		int num = 0;
		num = ((TMP.textInfo != null) ? TMP.textInfo.characterCount : 0);
		if (num == 0)
		{
			return 0f;
		}
		return num * TimeSpace + (EnableFadeIn ? FadeInDuration : 0);
	}

	private float GetProgress()
	{
		float num = GetTotalDuration();
		if (num <= 0f)
		{
			return 1f;
		}
		return Mathf.Clamp01(m_elapsedTime / num);
	}

	private void InitializeTypewriterEffect()
	{
		int characterCount = TMP.textInfo.characterCount;
		if (m_charAlphas == null || m_charAlphas.Length < characterCount)
		{
			m_charAlphas = new byte[Mathf.Max(characterCount, 128)];
		}
		else
		{
			Array.Clear(m_charAlphas, 0, m_charAlphas.Length);
		}
		for (int i = 0; i < characterCount; i++)
		{
			TMP_CharacterInfo charInfo = TMP.textInfo.characterInfo[i];
			if (charInfo.isVisible)
			{
				SetCharAlpha(charInfo, 0);
			}
		}
		TMP.UpdateVertexData(TMP_VertexDataUpdateFlags.Colors32);
	}

	private void Awake()
	{
		TMP.ForceMeshUpdate();
	}

	private void OnEnable()
	{
		TMP.OnPreRenderText += OnPreRenderText;
		_ = IsFinished;
	}

	private void OnDisable()
	{
		TMP.OnPreRenderText -= OnPreRenderText;
	}

	private void OnPreRenderText(TMP_TextInfo textInfo)
	{
		if (m_isActive && textInfo.characterCount != 0)
		{
			SetProgressInternal(GetProgress(), updateVertexData: false);
		}
	}

	private void LateUpdate()
	{
		if (driveMode != TypeWriterDriveMode.Manual && !m_isPaused && m_isActive)
		{
			ManualUpdate(Time.deltaTime);
		}
	}

	public void ManualUpdate(float deltaTime)
	{
		TextMeshProUGUI tMP = TMP;
		if (tMP.textInfo != null && tMP.textInfo.characterCount != 0)
		{
			if (m_skipNextTimeAdvance)
			{
				m_skipNextTimeAdvance = false;
				SetProgressInternal(GetProgress());
			}
			else
			{
				m_elapsedTime += deltaTime * 1000f;
				float num = GetProgress();
				SetProgressInternal(num);
			}
		}
	}

	public void Complete()
	{
		m_skipNextTimeAdvance = false;
		SetProgress(1f);
	}

	public void Reset()
	{
		SetProgress(0f);
		m_skipNextTimeAdvance = !EnableFadeIn;
	}

	public void SetProgress(float progress)
	{
		progress = Mathf.Clamp01(progress);
		TextMeshProUGUI tMP = TMP;
		if (tMP.textInfo != null && tMP.textInfo.characterCount != 0)
		{
			float num = GetTotalDuration();
			if (!(num <= 0f))
			{
				float elapsedTime = progress * num;
				m_elapsedTime = elapsedTime;
				m_isPaused = false;
				SetProgressInternal(progress);
			}
		}
	}

	private void SetProgressInternal(float progress, bool updateVertexData = true)
	{
		TextMeshProUGUI tMP = TMP;
		int characterCount = tMP.textInfo.characterCount;
		float alpha = tMP.alpha;
		float num = GetTotalDuration();
		if (num <= 0f)
		{
			return;
		}
		float num2 = progress * num;
		if (m_charAlphas == null || m_charAlphas.Length < characterCount)
		{
			m_charAlphas = new byte[characterCount];
		}
		for (int i = 0; i < characterCount; i++)
		{
			TMP_CharacterInfo charInfo = tMP.textInfo.characterInfo[i];
			if (!charInfo.isVisible)
			{
				continue;
			}
			float num3 = i * TimeSpace;
			float num4 = num3 + (EnableFadeIn ? ((float)FadeInDuration) : 0f);
			if (num2 >= num4)
			{
				m_charAlphas[i] = byte.MaxValue;
				SetCharAlpha(charInfo, byte.MaxValue, alpha);
			}
			else if (num2 > num3)
			{
				if (EnableFadeIn)
				{
					float num5 = (num2 - num3) / (float)FadeInDuration;
					m_charAlphas[i] = (byte)(num5 * 255f);
					SetCharAlpha(charInfo, m_charAlphas[i], alpha);
				}
				else
				{
					m_charAlphas[i] = byte.MaxValue;
					SetCharAlpha(charInfo, byte.MaxValue, alpha);
				}
			}
			else
			{
				m_charAlphas[i] = 0;
				SetCharAlpha(charInfo, 0, alpha);
			}
		}
		if (updateVertexData)
		{
			tMP.UpdateVertexData(TMP_VertexDataUpdateFlags.Colors32);
		}
	}

	public void StopTweenString()
	{
		m_isActive = false;
		Complete();
	}

	public void Pause()
	{
		m_isPaused = true;
	}

	public void Resume()
	{
		m_isPaused = false;
	}

	public void TogglePause()
	{
		m_isPaused = !m_isPaused;
	}

	private void SetCharAlpha(TMP_CharacterInfo charInfo, byte alpha, float textAlpha = 1f)
	{
		int materialReferenceIndex = charInfo.materialReferenceIndex;
		if (materialReferenceIndex >= 0 && materialReferenceIndex < TMP.textInfo.meshInfo.Length)
		{
			int vertexIndex = charInfo.vertexIndex;
			Color32[] colors = TMP.textInfo.meshInfo[materialReferenceIndex].colors32;
			byte a = (byte)((float)(int)alpha * textAlpha);
			for (int i = 0; i < 4; i++)
			{
				colors[vertexIndex + i].a = a;
			}
		}
	}
}
