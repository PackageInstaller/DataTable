using UnityEngine;
using UnityEngine.UI;

namespace Ase;

[RequireComponent(typeof(Image))]
public class LoadUISprite : MonoBehaviour
{
	private string _path;

	private Image _img;

	private bool _isDirty;

	private bool _hasImgComp;

	private bool _isDestroyed;

	public Image Image => _img;

	public string Path
	{
		get
		{
			return _path;
		}
		set
		{
			if (!string.IsNullOrEmpty(value) && !string.Equals(_path, value))
			{
				_path = value;
				PreloadImg(_path);
				_isDirty = true;
				if (base.gameObject.activeInHierarchy)
				{
					LoadImg(_path);
				}
			}
		}
	}

	private async void PreloadImg(string path)
	{
		string spriteGroup = $"{GetInstanceID()}";
		await GameEntry.Resource.LoadSpriteAsync(AssetUtility.GetTextureAsset(path), spriteGroup);
		_ = _isDestroyed;
	}

	private void OnEnable()
	{
		if (_isDirty)
		{
			LoadImg(_path);
		}
	}

	private void OnDestroy()
	{
		GameEntry.Resource.UnLoadSpriteGroup($"{GetInstanceID()}");
		_isDestroyed = true;
	}

	private async void LoadImg(string path)
	{
		if (!_hasImgComp)
		{
			_hasImgComp = _img != null;
			if (!_hasImgComp && TryGetComponent<Image>(out var component))
			{
				_img = component;
				_img.enabled = false;
				_hasImgComp = true;
			}
		}
		_isDirty = false;
		if (!_hasImgComp)
		{
			return;
		}
		string spriteGroup = $"{GetInstanceID()}";
		Sprite sprite = await GameEntry.Resource.LoadSpriteAsync(AssetUtility.GetTextureAsset(path), spriteGroup);
		if (!_isDestroyed)
		{
			_img.sprite = sprite;
			if (!_img.enabled)
			{
				_img.enabled = true;
			}
		}
	}
}
