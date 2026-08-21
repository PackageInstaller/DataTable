using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleTimelineCastingWindow : UGuiWindow
{
	public Image targetImage;

	public List<GameObject> laterShow;

	private Texture2D _texture2D;

	private readonly List<Sprite> _createdSprites = new List<Sprite>();

	protected override void OnEnable()
	{
		base.OnEnable();
		StartCoroutine(CaptureScreen());
	}

	private IEnumerator CaptureScreen()
	{
		yield return new WaitForEndOfFrame();
		if (_texture2D == null)
		{
			_texture2D = new Texture2D(Screen.width, Screen.height, TextureFormat.RGB24, mipChain: false);
		}
		_texture2D.ReadPixels(new Rect(0f, 0f, Screen.width, Screen.height), 0, 0);
		_texture2D.Apply();
		Sprite sprite = Sprite.Create(_texture2D, new Rect(0f, 0f, _texture2D.width, _texture2D.height), new Vector2(0.5f, 0.5f));
		_createdSprites.Add(sprite);
		if (targetImage != null)
		{
			targetImage.gameObject.SetActive(value: true);
			targetImage.sprite = sprite;
		}
		if (laterShow.Count <= 0)
		{
			yield break;
		}
		foreach (GameObject item in laterShow)
		{
			item.SetActive(value: true);
		}
	}

	public void SetShow()
	{
		OnShow();
	}

	public void SetHide()
	{
		OnHide();
	}

	public void CloseUI()
	{
		for (int num = _createdSprites.Count - 1; num >= 0; num--)
		{
			Object.Destroy(_createdSprites[num]);
		}
		if (_texture2D != null)
		{
			Object.Destroy(_texture2D);
		}
		_createdSprites.Clear();
		Close();
	}
}
