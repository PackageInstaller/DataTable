using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EatSnakeFood : MonoBehaviour
{
	public int x;

	public int y;

	public Image image;

	public List<Sprite> foodSpriteList = new List<Sprite>();

	public float spawnTime;

	public Color Color { get; private set; }

	public int type { get; private set; }

	private void Start()
	{
	}

	public void SetData(int x, int y, int type, float spawnTime)
	{
		this.x = x;
		this.y = y;
		this.type = type;
		this.spawnTime = spawnTime;
		image.sprite = foodSpriteList[type - 1];
	}
}
