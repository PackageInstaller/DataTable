using System.Collections.Generic;
using UnityEngine;

public class DynamicObjectBinding : MonoBehaviour
{
	public enum EnumObjectType
	{
		OBJ_DEFAULT,
		OBJ_MINIGAME,
		OBJ_MULTIPLE
	}

	public EnumObjectType _objectType;

	public List<P08ObjectBinding> ObjectBindings = new List<P08ObjectBinding>();

	public List<P08MixBinding> MixBindings = new List<P08MixBinding>();

	public Dictionary<string, P08ObjectBinding> dict = new Dictionary<string, P08ObjectBinding>();

	public bool autoInit = true;

	protected void LoadDict()
	{
		foreach (P08ObjectBinding objectBinding in ObjectBindings)
		{
			if (objectBinding.go == null)
			{
				GameObject inst = objectBinding.GetInst();
				if (inst != null)
				{
					inst.name = objectBinding.key;
					inst.transform.parent = objectBinding.parentTF;
					inst.transform.SetLocalPositionAndRotation(objectBinding.position, objectBinding.rotation);
					inst.transform.SetLocalScale(objectBinding.scale);
					inst.SetActive(objectBinding.active);
				}
				objectBinding.go = inst;
			}
			if (!dict.TryGetValue(objectBinding.key, out var value) || value == null || value.go == null)
			{
				dict[objectBinding.key] = objectBinding;
			}
		}
	}

	private void Awake()
	{
		AutoInit();
	}

	public virtual void AutoInit()
	{
		if (autoInit)
		{
			ManualInit();
		}
	}

	public virtual void ManualInit()
	{
		LoadDict();
		BuildBindings();
	}

	private void OnDestroy()
	{
		if (!Application.isPlaying)
		{
			return;
		}
		foreach (KeyValuePair<string, P08ObjectBinding> item in dict)
		{
			if (!string.IsNullOrEmpty(item.Value.path))
			{
				Asset.Unload(item.Value.path);
			}
		}
	}

	protected void BuildBindings()
	{
		DynamicTimelineTrackBinding[] componentsInChildren;
		if (_objectType == EnumObjectType.OBJ_MINIGAME)
		{
			foreach (P08MixBinding mixBinding in MixBindings)
			{
				if (string.IsNullOrEmpty(mixBinding.key) || !dict.TryGetValue(mixBinding.key, out var value) || value == null)
				{
					continue;
				}
				GameObject go = value.go;
				if (go != null && !string.IsNullOrEmpty(mixBinding.subPath))
				{
					Transform transform = go.transform.Find(mixBinding.subPath);
					if (transform != null)
					{
						go = transform.gameObject;
					}
				}
				if (!(go == null) && mixBinding.componentType == "Animator")
				{
					Animator animator = mixBinding.component?.GetComponent<Animator>();
					Animator component = go.GetComponent<Animator>();
					if (animator != null && component != null)
					{
						animator.runtimeAnimatorController = component.runtimeAnimatorController;
					}
				}
			}
			{
				foreach (KeyValuePair<string, P08ObjectBinding> item in dict)
				{
					GameObject go2 = item.Value.go;
					if (go2 != null)
					{
						componentsInChildren = go2.GetComponentsInChildren<DynamicTimelineTrackBinding>(includeInactive: true);
						for (int i = 0; i < componentsInChildren.Length; i++)
						{
							componentsInChildren[i].ManualInit(base.gameObject);
						}
					}
				}
				return;
			}
		}
		if (_objectType != EnumObjectType.OBJ_MULTIPLE)
		{
			return;
		}
		base.gameObject.GetComponent<DynamicTimelineTrackBinding>()?.ManualInit(dict);
		componentsInChildren = base.gameObject.GetComponentsInChildren<DynamicTimelineTrackBinding>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].ManualInit(dict);
		}
		foreach (P08MixBinding mixBinding2 in MixBindings)
		{
			if (string.IsNullOrEmpty(mixBinding2.key) || !dict.TryGetValue(mixBinding2.key, out var value2) || value2 == null)
			{
				continue;
			}
			GameObject go3 = value2.go;
			if (go3 != null && !string.IsNullOrEmpty(mixBinding2.subPath))
			{
				Transform transform2 = go3.transform.Find(mixBinding2.subPath);
				if (transform2 != null)
				{
					go3 = transform2.gameObject;
				}
			}
			if (!(go3 == null) && mixBinding2.componentType == "Animator")
			{
				if (Application.isPlaying)
				{
					(go3?.GetComponent<Animator>()).runtimeAnimatorController = null;
				}
				mixBinding2.component = go3;
			}
		}
	}
}
