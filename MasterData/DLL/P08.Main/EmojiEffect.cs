using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EmojiEffect : BaseMeshEffect
{
	private Text _text;

	private const string EmojiName = "emoji";

	private List<Image> _awake = new List<Image>();

	private List<Image> _sleep = new List<Image>();

	private List<UIVertex> _vertexList = new List<UIVertex>();

	public override void ModifyMesh(VertexHelper vh)
	{
		if (Application.isPlaying)
		{
			_vertexList.Clear();
			vh.GetUIVertexStream(_vertexList);
		}
	}

	public List<Image> SetEmojiByEmojiRawImage(List<EmojiItem> emojiItemList)
	{
		for (int i = 0; i < _awake.Count; i++)
		{
			Image image = _awake[i];
			image.gameObject.SetActive(value: false);
			_sleep.Add(image);
		}
		_awake.Clear();
		for (int j = 0; j < emojiItemList.Count; j++)
		{
			Image image2 = null;
			if (j > _sleep.Count - 1)
			{
				image2 = NewEmojiRwaImage();
			}
			else
			{
				image2 = _sleep[0];
				_sleep.Remove(image2);
			}
			if (!(null == image2))
			{
				image2.gameObject.SetActive(value: true);
				_awake.Add(image2);
				int index = Mathf.Clamp(emojiItemList[j].pos * 6 - 4, 2, int.MaxValue);
				Vector3 localPosition = new Vector3(_vertexList[index].position.x, _vertexList[index].position.y, 0f);
				image2.transform.localPosition = localPosition;
			}
		}
		return _awake;
	}

	private Image NewEmojiRwaImage()
	{
		if (null == _text)
		{
			_text = GetComponent<Text>();
		}
		if (null == _text)
		{
			return null;
		}
		GameObject obj = new GameObject("emoji");
		Image image = obj.AddComponent<Image>();
		obj.transform.SetParent(base.transform);
		obj.transform.localScale = Vector3.one;
		image.rectTransform.sizeDelta = new Vector2(_text.fontSize, _text.fontSize);
		image.rectTransform.pivot = Vector2.zero;
		return image;
	}

	protected override void Start()
	{
		base.Start();
		_vertexList = new List<UIVertex>();
		_text = GetComponent<Text>();
	}
}
