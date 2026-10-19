using System.Collections;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TouchUITip : MonoBehaviour
{
	public Text text;

	[HideInInspector]
	public bool isBeneficial;

	public Rect startPos;

	public AnimationCurve scaleCurve;

	public float scaleDuration;

	public float normalScale = 1f;

	public AnimationCurve alphaCurve;

	public AnimationCurve yCurve;

	public float yMin;

	public float yMax;

	private float y;

	public float xMin;

	public float xMax;

	private float x;

	public float displacementDuration;

	private Vector3 m_OriginScale;

	private Coroutine m_PlayCoroutine;

	public Vector3 worldPos { get; internal set; }

	private void Awake()
	{
		m_OriginScale = transform.localScale;
	}

	private IEnumerator _Play(bool faceLeft)
	{
		WaitForEndOfFrame dt = new WaitForEndOfFrame();
		float startTime = Time.time;
		float t = Time.time - startTime;
		worldPos += VectorUtility.HorizontalDirection(faceLeft, startPos.position + new Vector2(Random.Range(0f, startPos.width), Random.Range(0f, startPos.height)));
		x = Random.Range(xMin, xMax);
		y = Random.Range(yMin, yMax);
		Vector3 vector = Camera.main.WorldToScreenPoint(worldPos);
		transform.position = Singleton<NewUIManager>.instance.ScreenPosToWorld(vector);
		if (isBeneficial)
		{
			while (t < scaleDuration)
			{
				float time = t / scaleDuration;
				transform.localScale = m_OriginScale * scaleCurve.Evaluate(time);
				vector = Camera.main.WorldToScreenPoint(worldPos);
				transform.position = Singleton<NewUIManager>.instance.ScreenPosToWorld(vector);
				t = Time.time - startTime;
				yield return dt;
			}
		}
		startTime = Time.time;
		t = Time.time - startTime;
		if (isBeneficial)
		{
			transform.localScale = m_OriginScale * scaleCurve.Evaluate(1f);
		}
		else
		{
			transform.localScale = m_OriginScale * normalScale;
		}
		while (t < displacementDuration)
		{
			float num = t / displacementDuration;
			Vector3 position = worldPos + VectorUtility.HorizontalDirection(faceLeft, new Vector2(x * num, y * yCurve.Evaluate(num)));
			vector = Camera.main.WorldToScreenPoint(position);
			transform.position = Singleton<NewUIManager>.instance.ScreenPosToWorld(vector);
			Color color = text.color;
			color.a = alphaCurve.Evaluate(num);
			text.color = color;
			t = Time.time - startTime;
			yield return dt;
		}
		gameObject.SetActive(value: false);
		m_PlayCoroutine = null;
	}

	public void Play(int msg, bool faceLeft)
	{
		text.text = msg.ToString();
		if (m_PlayCoroutine != null)
		{
			StopCoroutine(m_PlayCoroutine);
		}
		m_PlayCoroutine = StartCoroutine(_Play(faceLeft));
	}
}
