using System;
using UnityEngine;

namespace ACT.UI;

public class AutoRotate : MonoBehaviour
{
	public Vector3 eulers = new Vector3(0f, 90f, 0f);

	public Space space;

	[SerializeField]
	[Range(0.1f, 5f)]
	private float interval = 2f;

	public bool useSin = true;

	private float time;

	private void Update()
	{
		if (useSin)
		{
			time += Time.deltaTime;
			float num = Mathf.Sin(time % interval / interval * MathF.PI * 2f);
			if (space == Space.World)
			{
				transform.eulerAngles = eulers * num;
			}
			else
			{
				transform.localEulerAngles = eulers * num;
			}
		}
		else
		{
			transform.Rotate(eulers * Time.deltaTime, space);
		}
	}
}
