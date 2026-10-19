using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

[RequireComponent(typeof(BetterAnimation))]
public class MonoConversationEmoji : MonoBehaviour
{
	public Transform m_BindTransform;

	public BetterAnimation betterAnimation;

	public string animationName = "Play";

	public Vector2 offset = new Vector3(-0.1f, 0.2f);

	public void BindTransform(Transform bindTransform)
	{
		m_BindTransform = bindTransform;
		UpdatePosition();
	}

	private void Update()
	{
		UpdatePosition();
	}

	private void UpdatePosition()
	{
		if (m_BindTransform == null || Camera.main == null || Singleton<NewUIManager>.instance == null)
		{
			return;
		}
		RectTransform rectTransform = transform.parent as RectTransform;
		RectTransform rectTransform2 = transform as RectTransform;
		if (!(rectTransform == null) && !(rectTransform2 == null))
		{
			Vector3 vector = Camera.main.WorldToScreenPoint(m_BindTransform.position + new Vector3(offset.x, offset.y, 0f));
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, vector, Singleton<NewUIManager>.instance.UICamera, out var localPoint))
			{
				rectTransform2.anchoredPosition = localPoint;
				float z = Camera.main.WorldToViewportPoint(m_BindTransform.position).z;
				float num = Mathf.Clamp(2.4f / z, 0.1f, 2f);
				rectTransform2.localScale = Vector3.one * num;
			}
		}
	}

	public async UniTask Play(CancellationToken token)
	{
		if (betterAnimation == null)
		{
			await UniTask.WaitForSeconds(1f, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			return;
		}
		betterAnimation.StopAnimation();
		AnimationBuilder sequence = betterAnimation.GetSequence(animationName);
		if (sequence == null)
		{
			await UniTask.WaitForSeconds(1f, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			return;
		}
		await sequence.Play().AwaitComplete().AttachExternalCancellation(token)
			.SuppressCancellationThrow();
		if (token.IsCancellationRequested && betterAnimation != null)
		{
			betterAnimation.StopAnimation();
		}
	}
}
