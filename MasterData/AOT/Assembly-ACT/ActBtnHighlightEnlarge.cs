using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;

public class ActBtnHighlightEnlarge : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	[SerializeField]
	private float hoverScale = 1.05f;

	[SerializeField]
	private float duration = 0.12f;

	private Vector3 _normalScale;

	private Coroutine _coroutine;

	private void Awake()
	{
		_normalScale = transform.localScale;
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		Play(_normalScale * hoverScale);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		Play(_normalScale);
	}

	private void Play(Vector3 targetScale)
	{
		if (_coroutine != null)
		{
			StopCoroutine(_coroutine);
		}
		_coroutine = StartCoroutine(Animate(targetScale));
	}

	private IEnumerator Animate(Vector3 targetScale)
	{
		Vector3 startScale = transform.localScale;
		float t = 0f;
		while (t < duration)
		{
			t += Time.unscaledDeltaTime;
			float num = Mathf.Clamp01(t / duration);
			num = 1f - Mathf.Pow(1f - num, 3f);
			transform.localScale = Vector3.LerpUnclamped(startScale, targetScale, num);
			yield return null;
		}
		transform.localScale = targetScale;
	}
}
