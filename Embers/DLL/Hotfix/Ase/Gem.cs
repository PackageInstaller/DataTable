using System;
using UnityEngine;

namespace Ase;

public class Gem : MonoBehaviour
{
	private bool _isSuccessUpgrade;

	private GameObject _effectObj;

	private GameObject _newGem;

	private Transform _parentObj;

	public int effectTime;

	public float awaitTime;

	private GemMode _gemMode;

	private Action<Gem> _playEffectAction;

	private Action _getAction;

	public int Rarity;

	[SerializeField]
	private GameObject lightObj;

	public bool isShow;

	public GemMode GemMode => _gemMode;

	public bool IsSuccessUpgrade => _isSuccessUpgrade;

	public GameObject EffectObj => _effectObj;

	public void Init(Transform parentObj, Action getAction, Action<Gem> playEffectAction = null, GameObject effectObj = null, GameObject newGem = null)
	{
		_isSuccessUpgrade = false;
		_effectObj = effectObj;
		_newGem = newGem;
		_parentObj = parentObj;
		effectTime = 5;
		awaitTime = 3f;
		_getAction = getAction;
		_playEffectAction = playEffectAction;
		if (lightObj != null)
		{
			lightObj.SetActive(value: false);
		}
	}

	public void SetSuccessUpgrade(bool value)
	{
		_isSuccessUpgrade = value;
	}

	public void OpenLightObj()
	{
		if (lightObj != null)
		{
			lightObj.SetActive(value: true);
		}
	}

	public void GemGet()
	{
		_getAction();
		OpenLightObj();
	}

	public void SetGemMode(int mode)
	{
		_gemMode = (GemMode)mode;
	}

	public void PlayUpgrade(float drag, float explosionForce, Vector3 explosionPosition, float explosionRadius, float upwardsModifier)
	{
		if (_newGem != null && IsSuccessUpgrade)
		{
			GameObject obj = UnityEngine.Object.Instantiate(_newGem, _parentObj);
			obj.AddComponent<MeshCollider>();
			obj.GetComponent<MeshCollider>().convex = true;
			obj.AddComponent<Rigidbody>();
			Rigidbody component = obj.GetComponent<Rigidbody>();
			component.drag = drag;
			component.AddExplosionForce(explosionForce, explosionPosition, explosionRadius, upwardsModifier);
			obj.GetComponent<Gem>().OpenLightObj();
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	public void PlayUpgrade()
	{
		if (_playEffectAction != null)
		{
			_playEffectAction(this);
		}
	}

	public void PlayResultUpgrade()
	{
		if (_gemMode == GemMode.ResultUpgrade)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(_newGem, _parentObj);
			GameObject obj = UnityEngine.Object.Instantiate(_effectObj, gameObject.transform.position, default(Quaternion));
			gameObject.GetComponent<Gem>().OpenLightObj();
			UnityEngine.Object.Destroy(base.gameObject);
			UnityEngine.Object.Destroy(obj, effectTime);
		}
	}
}
