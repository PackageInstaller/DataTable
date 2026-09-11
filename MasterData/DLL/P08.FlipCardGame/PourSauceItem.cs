using UnityEngine;
using UnityEngine.EventSystems;

public class PourSauceItem : MonoBehaviour
{
	private PourSauceGameManager gameManager;

	public EventTriggerListener eventTriggerListener;

	public Animator animator;

	private void Start()
	{
		eventTriggerListener.AddListenerType1(EventTriggerType.PointerClick, OnClick);
	}

	public void Init(PourSauceGameManager gameManager)
	{
		this.gameManager = gameManager;
		animator.enabled = false;
	}

	private void OnClick(GameObject go, PointerEventData e)
	{
		gameManager.OnSauceClick();
	}

	public void PlayPourAnim()
	{
		animator.enabled = true;
		animator.Play("bowl", 0, 0f);
		animator.Update(0f);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_sprinkle02", useStream: false);
	}

	public void PlayRecoverAnim()
	{
		animator.enabled = true;
		animator.Play("bowl02", 0, 0f);
		animator.Update(0f);
	}

	public void SetLocalPosition(Vector3 position)
	{
		base.transform.localPosition = position;
	}

	public void SetLocalPositionByTween(Vector3 position)
	{
		LeanTween.moveLocal(base.gameObject, position, 0.5f).setEase(LeanTweenType.easeOutCubic);
	}

	public void SetDeltaLocalPosition(Vector3 deltaPosition)
	{
		Vector3 localPosition = base.transform.localPosition;
		localPosition.x += deltaPosition.x;
		localPosition.z = 0f;
		base.transform.localPosition = localPosition;
	}
}
