using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class StoryBGController : MonoBehaviour
{
	public List<Image> bgList = new List<Image>();

	private List<Material> matInstanceList = new List<Material>();

	private int currentIdx;

	public void Init()
	{
		if (bgList != null && bgList.Count > 0)
		{
			currentIdx = 0;
			for (int i = 0; i < bgList.Count; i++)
			{
				Color color = bgList[i].color;
				color.a = 0f;
				bgList[i].color = color;
				bgList[i].sprite = null;
				bgList[i].gameObject.SetActive(value: true);
				bgList[i].rectTransform.rotation = Quaternion.identity;
				Material material = new Material(bgList[i].material);
				bgList[i].material = material;
				matInstanceList.Add(material);
			}
		}
	}

	public Image CurrentBG()
	{
		return bgList[currentIdx];
	}

	public IEnumerator ChangeBG(Sprite bg, Vector2 screenSize, float time = 0f)
	{
		Color color;
		if (time <= 0f)
		{
			color = bgList[currentIdx].color;
			color.a = 1f;
			ApplySprite(bgList[currentIdx], bg, screenSize);
			bgList[currentIdx].color = color;
			yield break;
		}
		int index = currentIdx;
		int index2 = bgList.FindIndex((Image x) => x.color.a != 1f && x != bgList[currentIdx]);
		ApplySprite(bgList[index2], bg, screenSize);
		color = bgList[index2].color;
		color.a = 0f;
		bgList[index2].color = color;
		currentIdx = index2;
		yield return CombinedFade(index, currentIdx, time);
	}

	public IEnumerator FadeBG(float startAlpha = 0f, float endAlpha = 1f, float time = 0f)
	{
		if (bgList[currentIdx].color.a != endAlpha)
		{
			yield return FadeCoroutine(bgList[currentIdx], bgList[currentIdx].color, startAlpha, endAlpha, time);
		}
	}

	public IEnumerator FadeBG(Sprite bg, Vector2 screenSize, float changetime = 0f, float startAlpha = 0f, float endAlpha = 1f, float time = 0f)
	{
		yield return ChangeBG(bg, screenSize, changetime);
		if (bgList[currentIdx].color.a != endAlpha)
		{
			yield return FadeCoroutine(bgList[currentIdx], bgList[currentIdx].color, startAlpha, endAlpha, time);
		}
	}

	private void ApplySprite(Image image, Sprite sprite, Vector2 screenSize)
	{
		image.sprite = sprite;
		image.transform.localScale = Vector3.one;
		image.rectTransform.anchoredPosition = Vector2.Scale(new Vector2(0f, 0f), screenSize);
	}

	private IEnumerator CombinedFade(int index, int nextIndex, float time)
	{
		Coroutine coroutine = StartCoroutine(FadeCoroutine(bgList[index], bgList[index].color, 1f, 0f, time));
		Coroutine fadeIn = StartCoroutine(FadeCoroutine(bgList[nextIndex], bgList[nextIndex].color, 0f, 1f, time));
		yield return coroutine;
		yield return fadeIn;
	}

	private IEnumerator FadeCoroutine(Graphic target, Color fadeColor, float startAlpha, float endAlpha, float fadeTime, Action action = null)
	{
		Color oriCol = fadeColor;
		if (startAlpha >= 0f)
		{
			oriCol.a = startAlpha;
		}
		else
		{
			oriCol = target.color;
		}
		fadeColor.a = endAlpha;
		if (fadeTime <= 0f)
		{
			target.color = fadeColor;
		}
		else
		{
			IEnumerator<Color> dic = StoryUtility.ColorLerp(oriCol, fadeColor, fadeTime);
			while (dic.MoveNext())
			{
				Color current = dic.Current;
				target.color = current;
				yield return null;
			}
			dic.Dispose();
		}
		action?.Invoke();
	}

	public IEnumerator BlurCurrentScene(float stepVal, float time)
	{
		Material mat = CurrentBG().material;
		if (mat == null)
		{
			yield break;
		}
		if (time <= 0f)
		{
			mat.SetFloat("_Step", stepVal);
			yield break;
		}
		float oriFloat = mat.GetFloat("_Step");
		IEnumerator<float> dic = StoryUtility.FloatLerp(oriFloat, stepVal, time);
		while (dic.MoveNext())
		{
			float current = dic.Current;
			mat.SetFloat("_Step", current);
			yield return null;
		}
		dic.Dispose();
	}

	private IEnumerator RotationCoroutine(RectTransform transform, Vector3 targetRotation, float scaleTime)
	{
		IEnumerator<Vector3> dic = StoryUtility.Vector3Lerp(transform.rotation.eulerAngles, targetRotation, scaleTime);
		while (dic.MoveNext())
		{
			Vector3 current = dic.Current;
			transform.rotation = Quaternion.Euler(current);
			yield return null;
		}
		dic.Dispose();
	}

	public void SetSceneRotation(string name, float x, float y, float z, float time)
	{
		if (bgList != null && bgList.Count > 0)
		{
			Image image = bgList.Find((Image image2) => image2.sprite.name == name);
			StartCoroutine(RotationCoroutine(image.rectTransform, new Vector3(x, y, z), time));
		}
	}

	private void OnDestroy()
	{
		if (matInstanceList == null || matInstanceList.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < matInstanceList.Count; i++)
		{
			if (matInstanceList[i] != null)
			{
				UnityEngine.Object.Destroy(matInstanceList[i]);
			}
		}
		matInstanceList.Clear();
		matInstanceList = null;
	}
}
