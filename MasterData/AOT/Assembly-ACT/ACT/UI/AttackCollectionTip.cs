using UnityEngine;

namespace ACT.UI;

public class AttackCollectionTip : MonoBehaviour
{
	[SerializeField]
	private CanvasGroup _canvasGroup;

	[SerializeField]
	private Animation _animation;

	private const string ShowAnim = "Show";

	private const string HideAnim = "Hide";

	public void Start()
	{
		_animation.Play("Hide");
	}

	internal void Init()
	{
		_canvasGroup.alpha = 1f;
		_animation.Play("Show");
	}

	internal void UnInit()
	{
		_animation.Play("Hide");
	}

	internal void ForceReset()
	{
		_animation.Stop();
		_canvasGroup.alpha = 0f;
	}
}
