using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
[AddComponentMenu("Game Framework/ReferencePool")]
public sealed class ReferencePoolComponent : GameFrameworkComponent
{
	[SerializeField]
	private ReferenceStrictCheckType m_EnableStrictCheck = ReferenceStrictCheckType.AlwaysEnable;

	public bool EnableStrictCheck
	{
		get
		{
			return ReferencePool.EnableStrictCheck;
		}
		set
		{
			ReferencePool.EnableStrictCheck = value;
			if (!value)
			{
			}
		}
	}

	protected override void Awake()
	{
		base.Awake();
	}

	private void Start()
	{
		switch (m_EnableStrictCheck)
		{
		case ReferenceStrictCheckType.AlwaysEnable:
			EnableStrictCheck = true;
			break;
		case ReferenceStrictCheckType.OnlyEnableWhenDevelopment:
			EnableStrictCheck = Debug.isDebugBuild;
			break;
		case ReferenceStrictCheckType.OnlyEnableInEditor:
			EnableStrictCheck = Application.isEditor;
			break;
		default:
			EnableStrictCheck = false;
			break;
		}
	}
}
