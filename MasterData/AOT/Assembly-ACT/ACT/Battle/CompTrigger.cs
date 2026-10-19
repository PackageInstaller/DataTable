namespace ACT.Battle;

public class CompTrigger : EcsComponent, ITriggerPredicate
{
	private uint m_TriggerGroupId;

	private bool m_CanTriggerHiddenRoom;

	public void Init()
	{
		m_TriggerGroupId = MonoECS.instance.GetNewTriggerGroupId();
	}

	public void SetCanTriggerHiddenRoom(bool canTriggerHiddenRoom)
	{
		m_CanTriggerHiddenRoom = canTriggerHiddenRoom;
	}

	public void SetTriggerGroupId(uint id)
	{
		m_TriggerGroupId = id;
	}

	public bool CanTriggerHiddenRoom()
	{
		return m_CanTriggerHiddenRoom;
	}

	public uint UintTransform()
	{
		return m_TriggerGroupId;
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		m_CanTriggerHiddenRoom = false;
	}
}
