using UnityEngine;

public class GridCell : MonoBehaviour
{
	[HideInInspector]
	public RectTransform rectTransform;

	public Vector2 Size { get; private set; }

	public virtual void Initialize()
	{
		rectTransform = GetComponent<RectTransform>();
		Size = new Vector2(rectTransform.rect.width, rectTransform.rect.height);
	}
}
