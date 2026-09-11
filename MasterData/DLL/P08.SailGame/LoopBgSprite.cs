using System.Collections.Generic;
using UnityEngine;

public class LoopBgSprite : MonoBehaviour
{
	public List<Transform> moveTransList = new List<Transform>();

	private List<float> newPosXList = new List<float>();

	private int transCount;

	private int firstTransIndex;

	private float bgWidth;

	private float endPos;

	private float absEndPos;

	private bool canMove;

	private float deltaMove;

	private int moveDirection = -1;

	public float moveVelocity;

	public bool isRight = true;

	private void Update()
	{
		if (!canMove)
		{
			return;
		}
		deltaMove = (float)moveDirection * moveVelocity * Time.deltaTime;
		for (int i = 0; i < transCount; i++)
		{
			newPosXList[i] += deltaMove;
			SetPositionX(moveTransList[i], newPosXList[i]);
		}
		if (Mathf.Abs(newPosXList[firstTransIndex]) > absEndPos)
		{
			newPosXList[firstTransIndex] += (float)(-1 * moveDirection) * bgWidth * (float)transCount;
			SetPositionX(moveTransList[firstTransIndex], newPosXList[firstTransIndex]);
			if (firstTransIndex + 1 == transCount)
			{
				firstTransIndex = 0;
			}
			else
			{
				firstTransIndex++;
			}
		}
	}

	public void StartMove()
	{
		canMove = true;
		ResetTransforms();
	}

	public void PuaseMove()
	{
		canMove = false;
	}

	public void ResumeMove()
	{
		canMove = true;
	}

	private void ResetTransforms()
	{
		moveDirection = ((!isRight) ? 1 : (-1));
		SpriteRenderer component = moveTransList[0].GetComponent<SpriteRenderer>();
		bgWidth = component.sprite.bounds.size.x;
		float num = Camera.main.orthographicSize * 2f / (float)Screen.height * (float)Screen.width;
		endPos = (float)moveDirection * (num / 2f + bgWidth / 2f);
		absEndPos = Mathf.Abs(endPos);
		transCount = moveTransList.Count;
		int count = newPosXList.Count;
		float x = moveTransList[0].position.x;
		for (int i = 0; i < transCount; i++)
		{
			if (i > 0)
			{
				SetPositionX(moveTransList[i], x + (float)i * bgWidth);
			}
			if (i < count)
			{
				newPosXList[i] = moveTransList[i].position.x;
			}
			else
			{
				newPosXList.Add(moveTransList[i].position.x);
			}
		}
		firstTransIndex = 0;
	}

	private void SetPositionX(Transform trans, float x)
	{
		Vector3 position = trans.position;
		position.x = x;
		trans.position = position;
	}
}
