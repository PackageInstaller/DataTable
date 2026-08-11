using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

[RequireComponent(typeof(Image))]
public class LoadUISpriteInGameMapNPC : MonoBehaviour
{
	private string _path;

	private Image _img;

	private bool _isDirty;

	private bool _hasImgComp;

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
		await GameEntry.Resource.LoadSpriteAsync(AssetUtility.GetIllustratedGuideNPCHeadAvatar(path), $"{GetInstanceID()}");
	}

	private void OnEnable()
	{
		if (_isDirty)
		{
			LoadImg(_path);
		}
	}

	private async void LoadImg(string path)
	{
		if (!_hasImgComp)
		{
			_hasImgComp = _img != null;
			if (!_hasImgComp)
			{
				_img = GetComponent<Image>();
				_img.enabled = false;
				_hasImgComp = true;
			}
		}
		_isDirty = false;
		await UniTask.WaitForEndOfFrame();
		Image img = _img;
		img.sprite = await GameEntry.Resource.LoadSpriteAsync(AssetUtility.GetIllustratedGuideNPCHeadAvatar(path), $"{GetInstanceID()}");
		if (!_img.enabled)
		{
			_img.enabled = true;
		}
	}

	private void OnDestroy()
	{
		GameEntry.Resource.UnLoadSpriteGroup($"{GetInstanceID()}");
	}
}
