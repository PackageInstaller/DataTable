using System;
using UnityEngine;

[Serializable]
public class SpriteRendererController2DValue
{
	[SerializeField]
	public Sprite sprite;

	[SerializeField]
	public Color color;

	[SerializeField]
	public bool flipX;

	[SerializeField]
	public bool flipY;

	[SerializeField]
	public Material material;

	public bool CopyFromComponent(Component target)
	{
		SpriteRenderer spriteRenderer = target as SpriteRenderer;
		sprite = spriteRenderer.sprite;
		color = spriteRenderer.color;
		flipX = spriteRenderer.flipX;
		flipY = spriteRenderer.flipY;
		material = spriteRenderer.material;
		return true;
	}

	public bool PasteToComponent(Component target, bool isTween, float during, LeanTweenType ease)
	{
		SpriteRenderer obj = target as SpriteRenderer;
		obj.sprite = sprite;
		obj.color = color;
		obj.flipX = flipX;
		obj.flipY = flipY;
		obj.material = material;
		return true;
	}

	public bool IsEqualTo(Component target)
	{
		SpriteRenderer spriteRenderer = target as SpriteRenderer;
		if (sprite == spriteRenderer.sprite && color == spriteRenderer.color && flipX == spriteRenderer.flipX && flipY == spriteRenderer.flipY)
		{
			return material == spriteRenderer.material;
		}
		return false;
	}
}
