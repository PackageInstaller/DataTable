using System.Collections.Generic;
using UnityEngine;

public class TeachSkills : MonoBehaviour
{
	public TeachSkillItem tpl;

	public RectTransform layout;

	public GameObject completed;

	public float playCompleteDelayTime = 1f;

	public int maxItemNumber = 5;

	public int moveWidth = 148;

	public float moveTime = 0.1f;

	private List<TeachSkillItem> teachSkillItems = new List<TeachSkillItem>();

	private int current;

	private float targetPositionX;

	public bool useLoop = true;

	private bool startPlayComplete;

	private float playCompleteWaitTime;

	public void Init()
	{
		if (!(tpl == null))
		{
			tpl.gameObject.SetActive(value: false);
			current = 0;
			for (int i = 0; i < teachSkillItems.Count; i++)
			{
				Object.Destroy(teachSkillItems[i].gameObject);
			}
			teachSkillItems.Clear();
			if (layout != null)
			{
				layout.transform.localPosition = Vector3.zero;
				LeanTween.cancel(layout);
				targetPositionX = layout.localPosition.x;
			}
			if (completed != null)
			{
				completed.SetActive(value: false);
			}
			startPlayComplete = false;
			playCompleteWaitTime = 0f;
		}
	}

	public TeachSkillItem AddSkillItem()
	{
		if (tpl == null)
		{
			return null;
		}
		GameObject gameObject = Object.Instantiate(tpl.gameObject, tpl.transform.parent);
		if (gameObject == null)
		{
			return null;
		}
		gameObject.SetActive(value: true);
		TeachSkillItem component = gameObject.GetComponent<TeachSkillItem>();
		if (component == null)
		{
			return null;
		}
		if (component.loop != null && useLoop)
		{
			if (teachSkillItems.Count == 0)
			{
				component.loop.SetActive(value: true);
			}
			else
			{
				component.loop.SetActive(value: false);
			}
		}
		teachSkillItems.Add(component);
		if (teachSkillItems.Count > 5 && layout != null)
		{
			layout.localPosition += new Vector3(moveWidth / 2, 0f);
			targetPositionX = layout.localPosition.x;
		}
		return component;
	}

	public TeachSkillItem GetCurrent()
	{
		if (current < teachSkillItems.Count)
		{
			return teachSkillItems[current];
		}
		return null;
	}

	public int GetCurrentIndex()
	{
		return current;
	}

	public void FinishCurrent(bool success, bool miss = false)
	{
		TeachSkillItem teachSkillItem = GetCurrent();
		if (teachSkillItem == null)
		{
			return;
		}
		teachSkillItem.PlayAnimaton(success, miss);
		if (success)
		{
			if (current != 0)
			{
				Move();
			}
			current++;
			TeachSkillItem teachSkillItem2 = GetCurrent();
			if (teachSkillItem2 != null && teachSkillItem2.loop != null && useLoop)
			{
				teachSkillItem2.loop.SetActive(value: true);
			}
			if (teachSkillItem2 == null)
			{
				startPlayComplete = true;
			}
		}
	}

	private void Update()
	{
		if (!startPlayComplete)
		{
			return;
		}
		playCompleteWaitTime += Time.deltaTime;
		if (playCompleteWaitTime > playCompleteDelayTime)
		{
			Init();
			if (completed != null)
			{
				completed.SetActive(value: true);
			}
		}
	}

	private void Move()
	{
		if (!(layout == null))
		{
			targetPositionX -= moveWidth;
			LeanTween.moveLocalX(layout.gameObject, targetPositionX, moveTime);
		}
	}
}
