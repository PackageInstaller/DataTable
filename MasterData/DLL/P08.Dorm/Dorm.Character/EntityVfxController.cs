using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Dorm.Character;

internal class EntityVfxController : MonoBehaviour, IEidProvider
{
	internal DormEntity entity;

	private bool isDuringClear;

	private Dictionary<EffectController, string> allVisualEfx = new Dictionary<EffectController, string>();

	private Dictionary<EffectController, Transform> efxLinkInfo = new Dictionary<EffectController, Transform>();

	public int EntityID => entity?.id ?? 0;

	private void OnEfxStop(EffectController efx)
	{
		allVisualEfx.Remove(efx);
		efxLinkInfo.Remove(efx);
	}

	internal static EffectController PlayEffectEx(string efxPath, Transform attach, bool attachOnEntity, float duration, Vector3 localOffset, Quaternion localRotation, Vector3 localScale, EEffectQuality quality, Action<EffectController> onEfxEnd)
	{
		GameObject gameObject = Asset.Instantiate(efxPath);
		PositionAttachIsNotChild component = gameObject.GetComponent<PositionAttachIsNotChild>();
		if ((bool)component)
		{
			component.AttachTransform = attach;
			component.PositionOffset = localOffset;
			gameObject.transform.parent = null;
			gameObject.transform.rotation = Quaternion.identity;
			gameObject.transform.position = attach.TransformPoint(localOffset);
		}
		else if (attachOnEntity)
		{
			gameObject.transform.SetParent(attach, worldPositionStays: false);
			gameObject.transform.localPosition = localOffset;
			gameObject.transform.localRotation = localRotation;
		}
		else
		{
			gameObject.transform.parent = null;
			gameObject.transform.position = attach.position;
			gameObject.transform.rotation = attach.rotation;
		}
		gameObject.transform.localScale = localScale;
		EffectController effectController = U3DUtil.Get<EffectController>(gameObject);
		effectController.Initialize(duration == -1f, (duration == -1f) ? float.MaxValue : duration, 1f, quality, onEfxEnd);
		effectController.Simulator(0f);
		return effectController;
	}

	internal void AddVisualEfx(string vfxType, EffectController efx, Transform attach)
	{
		if (!isDuringClear)
		{
			allVisualEfx[efx] = vfxType;
			efxLinkInfo[efx] = attach;
		}
	}

	internal bool RemoveVisualEfx(string vfxType, EffectController efx)
	{
		if (allVisualEfx.TryGetValue(efx, out var value) && value == vfxType)
		{
			efx.Stop();
			return true;
		}
		return false;
	}

	internal Transform GetVfxLinkedTrs(EffectController vfx)
	{
		if (efxLinkInfo.TryGetValue(vfx, out var value))
		{
			return value;
		}
		return null;
	}

	internal IEnumerable<EffectController> GetVisualEfx(string vfxType)
	{
		foreach (KeyValuePair<EffectController, string> item in allVisualEfx)
		{
			if (item.Value == vfxType)
			{
				yield return item.Key;
			}
		}
	}

	internal IEnumerable<EffectController> GetVisualEfx(string vfxType, Transform attach)
	{
		foreach (KeyValuePair<EffectController, string> item in allVisualEfx)
		{
			if (item.Value == vfxType && attach == efxLinkInfo[item.Key])
			{
				yield return item.Key;
			}
		}
	}

	public void ClearAllVisualEfx(string vfxType)
	{
		isDuringClear = true;
		KeyValuePair<EffectController, string>[] array = allVisualEfx.ToArray();
		for (int i = 0; i < array.Length; i++)
		{
			KeyValuePair<EffectController, string> keyValuePair = array[i];
			EffectController key = keyValuePair.Key;
			string value = keyValuePair.Value;
			if ((bool)key && value == vfxType)
			{
				key.Stop();
			}
		}
		isDuringClear = false;
	}

	public void ClearAllVisualEfx()
	{
		isDuringClear = true;
		EffectController[] array = allVisualEfx.Keys.ToArray();
		foreach (EffectController effectController in array)
		{
			if ((bool)effectController)
			{
				effectController.Stop();
			}
		}
		isDuringClear = false;
	}

	internal EffectController PlayEffect(string type, string efxPath, Transform attachPoint, Vector3 offset, Quaternion rotation, Vector3 localScale, float duration, EEffectQuality quality)
	{
		EffectController effectController = PlayEffectEx(efxPath, attachPoint, attachOnEntity: true, duration, offset, rotation, localScale, quality, OnEfxStop);
		AddVisualEfx(type, effectController, attachPoint);
		return effectController;
	}

	internal EffectController PlayEffect(string type, string efxPath, Transform attachPoint, float duration, EEffectQuality quality)
	{
		return PlayEffect(type, efxPath, attachPoint, Vector3.zero, Quaternion.identity, Vector3.one, duration, quality);
	}

	public EffectController PlayEffect(string type, string efxPath, string attachPoint, Vector3 offset, Quaternion rotation, Vector3 localScale, float duration, EEffectQuality quality)
	{
		Transform attachPoint2 = entity.FindAttachPoint(attachPoint);
		return PlayEffect(type, efxPath, attachPoint2, offset, rotation, localScale, duration, quality);
	}
}
