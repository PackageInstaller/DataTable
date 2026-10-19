using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.ECS.System;

public class SystemInput : ECSSystem
{
	public const float PRESS_THRESHOLD = 0.2f;

	private bool m_couldInput;

	private Entity _overrideOperateEntity;

	public bool CouldInput
	{
		get
		{
			return m_couldInput;
		}
		set
		{
			m_couldInput = value;
		}
	}

	public override Filter MajorFilter { get; }

	protected override void OnCreate()
	{
	}

	public override void FixedUpdate()
	{
		if (m_couldInput)
		{
			Entity entity = ((_overrideOperateEntity == Entity.Invalid) ? MonoECS.instance.mainEntity : _overrideOperateEntity);
			Singleton<GameInputActionManager>.instance.FixedUpdatePlayerInput(entity);
		}
	}

	public void SetOverrideOperateEntity(Entity entity)
	{
		_overrideOperateEntity = entity;
	}
}
