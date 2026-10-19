using UnityEngine;

namespace ACT.UI;

public class GuideTargetNode : MonoBehaviour
{
	[SerializeField]
	private string id;

	[SerializeField]
	[Tooltip("启用/禁用时自动注册到最近父 View。循环滚动列表等需要手动控制注册时机的场景请关闭,改为手动调用 Register/Unregister。")]
	private bool autoRegister;

	private IBaseUIView _owner;

	private bool _registered;

	public string Id => id;

	public bool IsRegistered => _registered;

	private void OnEnable()
	{
		if (autoRegister)
		{
			Register();
		}
	}

	private void OnDisable()
	{
		if (autoRegister)
		{
			Unregister();
		}
	}

	public void Register()
	{
		Register(GetComponentInParent<IBaseUIView>(includeInactive: true));
	}

	public void Register(string targetId)
	{
		Register(GetComponentInParent<IBaseUIView>(includeInactive: true), targetId);
	}

	public void Register(IBaseUIView owner, string targetId)
	{
		if (_registered)
		{
			Unregister();
		}
		id = targetId;
		Register(owner);
	}

	public void Register(IBaseUIView owner)
	{
		if (owner != null && !string.IsNullOrEmpty(id))
		{
			if (_registered)
			{
				Unregister();
			}
			_owner = owner;
			_owner.RegisterGuideTarget(this);
			_registered = true;
		}
	}

	public void Unregister()
	{
		if (_registered)
		{
			_owner?.UnregisterGuideTarget(this);
			_owner = null;
			_registered = false;
		}
	}

	public void SetId(string newId)
	{
		if (!(id == newId))
		{
			if (_registered)
			{
				IBaseUIView owner = _owner;
				Unregister();
				id = newId;
				Register(owner);
			}
			else
			{
				id = newId;
			}
		}
	}
}
