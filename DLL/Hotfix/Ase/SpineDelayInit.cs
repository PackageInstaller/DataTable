using Spine.Unity;
using UnityEngine;

namespace Ase;

public class SpineDelayInit : MonoBehaviour
{
	private bool _overwriteSpineInit;

	private bool _isInitOver;

	private SkeletonGraphic _spineCtrl;

	public void InjectSpineCtrl(SkeletonGraphic spineCtrl, bool overwrite)
	{
		_spineCtrl = spineCtrl;
		_overwriteSpineInit = overwrite;
		_isInitOver = false;
	}

	private void OnEnable()
	{
		if (!_isInitOver)
		{
			_isInitOver = true;
			_spineCtrl.Initialize(_overwriteSpineInit);
			_spineCtrl.MatchRectTransformWithBounds();
		}
	}

	private void OnDestroy()
	{
		_isInitOver = false;
		_spineCtrl = null;
	}
}
