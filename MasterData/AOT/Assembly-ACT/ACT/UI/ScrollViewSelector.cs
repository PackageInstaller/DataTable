using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class ScrollViewSelector : MonoBehaviour
{
	public LoopScrollRect loopScrollRect;

	public RectTransform selectArea;

	private Vector3[] m_Corners = new Vector3[4];

	private float m_Distance;

	private bool m_IsMoving;

	private bool m_Running;

	private CancellationTokenSource _cancellationTokenSource;

	private Vector3[] m_TempCorners = new Vector3[4];

	public AdventureLevelCell selected { get; private set; }

	public bool IsMoving
	{
		get
		{
			if (m_IsMoving)
			{
				return loopScrollRect.velocity.magnitude > 0f;
			}
			return false;
		}
	}

	public void Stop()
	{
		m_Running = false;
	}

	private void Start()
	{
	}

	public async void SelectAreaUpdate()
	{
		selectArea.GetWorldCorners(m_Corners);
		GetWidth();
		m_Running = true;
		float currentVelocity = 0f;
		while (gameObject.activeSelf && m_Running)
		{
			float a = currentVelocity;
			currentVelocity = loopScrollRect.velocity.x + loopScrollRect.ScrollToCellCoroutineSpeed.x;
			float num;
			float num2;
			if (currentVelocity > 0f)
			{
				num = -0.9f;
				num2 = 0f;
			}
			else
			{
				num = 0f;
				num2 = 0.9f;
			}
			for (int num3 = loopScrollRect.content.childCount - 1; num3 >= 0; num3--)
			{
				AdventureLevelCell component = loopScrollRect.content.GetChild(num3).GetComponent<AdventureLevelCell>();
				float num4 = InsideRect(component.transform as RectTransform);
				if ((!Mathf.Approximately(currentVelocity, 0f) || !Mathf.Approximately(a, 0f)) && num4 > num && num4 < num2)
				{
					selected = component;
					_ = LuminApplication.LogEnabled;
				}
				OnChangeFactor(component.wrap, num4);
			}
			await UniTask.Yield(PlayerLoopTiming.LastUpdate);
		}
	}

	private void GetWidth()
	{
		m_Distance = m_Corners[3].x - m_Corners[0].x;
	}

	private float InsideRect(RectTransform input)
	{
		input.GetWorldCorners(m_TempCorners);
		float num = (m_TempCorners[0].x + m_TempCorners[3].x) / 2f;
		float num2 = (m_Corners[0].x + m_Corners[3].x) / 2f;
		return (num - num2) / m_Distance;
	}

	private void OnChangeFactor(RectTransform rectTransform, float factor)
	{
		if (!((double)loopScrollRect.velocity.magnitude < 1E-05) || m_IsMoving)
		{
			float value = ((factor > 0f) ? (0f - factor + 1f) : (factor + 1f));
			value = Mathf.Clamp01(value);
			rectTransform.localScale = Vector3.one * Mathf.Lerp(1f, 1.4f, value);
		}
	}

	public async void ScrollToSelected(AdventureLevelCell btn)
	{
		_cancellationTokenSource?.Cancel(throwOnFirstException: false);
		_cancellationTokenSource?.Dispose();
		_cancellationTokenSource = new CancellationTokenSource();
		m_IsMoving = true;
		loopScrollRect.ScrollToCellWithinTime(btn.index, 0.1f);
		selected = btn;
		selected.RefreshReward();
		try
		{
			await UniTask.Delay(2000, ignoreTimeScale: false, PlayerLoopTiming.Update, _cancellationTokenSource.Token);
			m_IsMoving = false;
		}
		catch (OperationCanceledException)
		{
		}
	}

	public async void ScrollToSelected(int btnIndex)
	{
		_cancellationTokenSource?.Cancel(throwOnFirstException: false);
		_cancellationTokenSource?.Dispose();
		_cancellationTokenSource = new CancellationTokenSource();
		m_IsMoving = true;
		loopScrollRect.ScrollToCellWithinTime(btnIndex, 0.1f);
		try
		{
			await UniTask.Delay(2000, ignoreTimeScale: false, PlayerLoopTiming.Update, _cancellationTokenSource.Token);
			m_IsMoving = false;
		}
		catch (OperationCanceledException)
		{
		}
	}

	public void AutoScroll()
	{
		ScrollToSelected(selected);
	}
}
