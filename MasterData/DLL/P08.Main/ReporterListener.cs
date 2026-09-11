using System.Collections.Generic;
using UnityEngine;

internal class ReporterListener : MonoBehaviour
{
	private Reporter reporter;

	private int numOfCircleToShow = 10;

	private List<Vector2> gestureDetector = new List<Vector2>();

	private Vector2 gestureSum = Vector2.zero;

	private float gestureLength;

	private int gestureCount;

	private void Start()
	{
		reporter = base.gameObject.AddComponent<Reporter>();
	}

	private void Update()
	{
		if (!reporter.show && isFingerDone())
		{
			numOfCircleToShow = 3;
			reporter.doShow();
		}
	}

	private void OnGUI()
	{
		if (!(null == reporter) && reporter.show)
		{
			reporter.OnGUIDraw();
		}
	}

	private bool isFingerDone()
	{
		if (Input.touchCount == 3)
		{
			Touch touch = Input.GetTouch(0);
			Touch touch2 = Input.GetTouch(1);
			Touch touch3 = Input.GetTouch(2);
			if (touch.position.x > 400f && touch2.position.x < 200f && touch3.position.x < 200f && Mathf.Abs(touch2.deltaPosition.y) + Mathf.Abs(touch3.deltaPosition.y) > 128f)
			{
				return true;
			}
		}
		return false;
	}

	private bool isGestureDone()
	{
		if (Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.IPhonePlayer)
		{
			if (Input.touches.Length != 1)
			{
				gestureDetector.Clear();
				gestureCount = 0;
			}
			else if (Input.touches[0].phase == TouchPhase.Canceled || Input.touches[0].phase == TouchPhase.Ended)
			{
				gestureDetector.Clear();
			}
			else if (Input.touches[0].phase == TouchPhase.Moved)
			{
				Vector2 position = Input.touches[0].position;
				if (gestureDetector.Count == 0 || (position - gestureDetector[gestureDetector.Count - 1]).magnitude > 10f)
				{
					gestureDetector.Add(position);
				}
			}
		}
		else if (Input.GetMouseButtonUp(0))
		{
			gestureDetector.Clear();
			gestureCount = 0;
		}
		else if (Input.GetMouseButton(0))
		{
			Vector2 vector = new Vector2(Input.mousePosition.x, Input.mousePosition.y);
			if (gestureDetector.Count == 0 || (vector - gestureDetector[gestureDetector.Count - 1]).magnitude > 10f)
			{
				gestureDetector.Add(vector);
			}
		}
		if (gestureDetector.Count < 10)
		{
			return false;
		}
		gestureSum = Vector2.zero;
		gestureLength = 0f;
		Vector2 rhs = Vector2.zero;
		for (int i = 0; i < gestureDetector.Count - 2; i++)
		{
			Vector2 vector2 = gestureDetector[i + 1] - gestureDetector[i];
			float magnitude = vector2.magnitude;
			gestureSum += vector2;
			gestureLength += magnitude;
			if (Vector2.Dot(vector2, rhs) < 0f)
			{
				gestureDetector.Clear();
				gestureCount = 0;
				return false;
			}
			rhs = vector2;
		}
		int num = (Screen.width + Screen.height) / 4;
		if (gestureLength > (float)num && gestureSum.magnitude < (float)(num / 2))
		{
			gestureDetector.Clear();
			gestureCount++;
			if (gestureCount >= numOfCircleToShow)
			{
				return true;
			}
		}
		return false;
	}
}
