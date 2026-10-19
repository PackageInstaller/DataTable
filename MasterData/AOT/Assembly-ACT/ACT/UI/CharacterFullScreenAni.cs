using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CharacterFullScreenAni : UIBehaviour
{
	public BetterAnimation Ani;

	public RectTransform Transform;

	public void Open()
	{
		gameObject.SetActive(value: true);
		Ani.GetSequence("Transition").OnComplete((AnimationBuilder _) =>
		{
			Close();
		}).Play();
	}

	public void Close()
	{
		gameObject.SetActive(value: false);
	}
}
