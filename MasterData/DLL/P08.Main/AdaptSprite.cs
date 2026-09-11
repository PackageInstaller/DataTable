using UnityEngine;

public class AdaptSprite : MonoBehaviour
{
	public SpriteRenderer adaptTarget;

	private float radio = 1f;

	private void Awake()
	{
		if (adaptTarget != null)
		{
			RectTransform component = base.gameObject.transform.parent.gameObject.transform.GetComponent<RectTransform>();
			float num = component.rect.width / (float)adaptTarget.sprite.texture.width;
			float num2 = component.rect.height / (float)adaptTarget.sprite.texture.height;
			if (num >= num2)
			{
				radio = num;
			}
			else
			{
				radio = num2;
			}
		}
		Transform[] componentsInChildren = base.transform.GetComponentsInChildren<Transform>(includeInactive: true);
		foreach (Transform transform in componentsInChildren)
		{
			SpriteRenderer component2 = transform.GetComponent<SpriteRenderer>();
			if (component2 != null)
			{
				float num3 = component2.sprite.texture.width;
				float num4 = component2.sprite.texture.height;
				component2.size = new Vector2(num3 * radio, num4 * radio);
				transform.GetComponent<RectTransform>().sizeDelta = new Vector2(num3 * radio, num4 * radio);
			}
		}
	}
}
