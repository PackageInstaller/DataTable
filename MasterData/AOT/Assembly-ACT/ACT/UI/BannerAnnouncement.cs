using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Game.Data;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class BannerAnnouncement : MonoBehaviour, IContext
{
	public RectTransform container;

	public TextMeshProUGUI text;

	public float Speed;

	private List<TipNotice> messages = new List<TipNotice>();

	private Queue<TipNotice> messageQueue = new Queue<TipNotice>();

	private Coroutine corun;

	public static BannerAnnouncement Instance { get; private set; }

	public ContextType ContextType => ContextType.NET;

	private void Start()
	{
		Instance = this;
		container.gameObject.SetActive(value: false);
		text.rectTransform.pivot = new Vector2(1f, 0.5f);
		container.pivot = new Vector2(1f, 0.5f);
	}

	private void FixedUpdate()
	{
		for (int num = messages.Count - 1; num >= 0; num--)
		{
			TipNotice tipNotice = messages[num];
			if (tipNotice.BeginTime.ToDatetime(milliseconds: false) < DateTime.Now)
			{
				EnQueue(tipNotice);
				messages.RemoveAt(num);
			}
		}
	}

	public void AddMessage(TipNotice msg)
	{
		messages.Add(msg);
	}

	public void EnQueue(TipNotice msg)
	{
		container.gameObject.SetActive(value: true);
		messageQueue.Enqueue(msg);
		if (corun == null)
		{
			corun = StartCoroutine(Run());
		}
	}

	public IEnumerator Run()
	{
		while (messageQueue.Count > 0)
		{
			Vector2 pos = text.rectTransform.anchoredPosition;
			TipNotice tipNotice = messageQueue.Dequeue();
			int loop = tipNotice.ShowNum;
			text.text = tipNotice.Content;
			yield return new WaitForEndOfFrame();
			float beginX = container.rect.width + text.rectTransform.rect.width;
			while (loop-- > 0)
			{
				text.rectTransform.anchoredPosition = new Vector2(beginX, pos.y);
				while (text.rectTransform.anchoredPosition.x > 0f)
				{
					text.rectTransform.anchoredPosition = new Vector2(text.rectTransform.anchoredPosition.x - Speed * Time.deltaTime, pos.y);
					yield return new WaitForEndOfFrame();
				}
			}
			yield return null;
		}
		corun = null;
		container.gameObject.SetActive(value: false);
	}

	private void OnDisable()
	{
		StopAllCoroutines();
	}

	public void ContextDestroy()
	{
	}

	public void ContextReset()
	{
		messages.Clear();
		container.gameObject.SetActive(value: false);
	}
}
