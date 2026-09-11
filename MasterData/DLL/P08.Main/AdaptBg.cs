using UnityEngine;

public class AdaptBg : MonoBehaviour
{
	public enum ADAPT_TYPE
	{
		NONE,
		ALL,
		DIR_X_ONLY,
		DIR_Y_ONLY
	}

	public bool isTreasure;

	public ADAPT_TYPE adaptType = ADAPT_TYPE.ALL;

	private void Start()
	{
		if (isTreasure)
		{
			adaptType = ADAPT_TYPE.DIR_Y_ONLY;
		}
		Adapt();
	}

	public void OnEnable()
	{
		Adapt();
	}

	private void Adapt()
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas");
		if (gameObject == null)
		{
			return;
		}
		Vector2 sizeDelta = gameObject.GetComponent<RectTransform>().sizeDelta;
		RectTransform component = base.gameObject.GetComponent<RectTransform>();
		Vector2 size = component.rect.size;
		float num = size.x / sizeDelta.x;
		float num2 = size.y / sizeDelta.y;
		if (!(num < 1f) && !(num2 < 1f))
		{
			return;
		}
		float num3 = 1f;
		switch (adaptType)
		{
		case ADAPT_TYPE.ALL:
		{
			float num4 = ((num < num2) ? num : num2);
			num3 = 1f / num4;
			break;
		}
		case ADAPT_TYPE.DIR_X_ONLY:
			if (num < 1f)
			{
				num3 = 1f / num;
			}
			break;
		case ADAPT_TYPE.DIR_Y_ONLY:
			if (num2 < 1f)
			{
				num3 = 1f / num2;
			}
			break;
		}
		component.sizeDelta = new Vector2(component.sizeDelta.x * num3, component.sizeDelta.y * num3);
	}
}
