using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EatSnakeBody : MonoBehaviour
{
	public int x;

	public int y;

	public int type;

	public Image image;

	public List<Sprite> bodySpriteList = new List<Sprite>();

	public Animator animator;

	public EatSnakeMain eatSnakeMain;

	public bool isRemoving;

	private Vector3 targetPos;

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void SetData(int x, int y, int type)
	{
		this.x = x;
		this.y = y;
		base.transform.localScale = new Vector3(1f, 1f, 1f);
		SetType(type);
	}

	public void SetType(int type)
	{
		this.type = type;
		image.sprite = bodySpriteList[type - 1];
	}

	public void Disappear()
	{
		animator.Play("SnakeBody_disappear", 0, 0f);
	}

	public void Break()
	{
		animator.Play("SnakeBody_break", 0, 0f);
		isRemoving = true;
	}
}
