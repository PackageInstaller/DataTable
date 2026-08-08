public class AgentAction
{
	public enum E_State
	{
		E_ACTIVE,
		E_SUCCESS,
		E_FAILED,
		E_UNUSED
	}

	public AgentActionFactory.E_Type Type;

	public E_State Status;

	public bool IsActive()
	{
		return Status == E_State.E_ACTIVE;
	}

	public bool IsFailed()
	{
		return Status == E_State.E_FAILED;
	}

	public bool IsSuccess()
	{
		return Status == E_State.E_SUCCESS;
	}

	public bool IsUnused()
	{
		return Status == E_State.E_UNUSED;
	}

	public void SetSuccess()
	{
		Status = E_State.E_SUCCESS;
	}

	public void SetFailed()
	{
		Status = E_State.E_FAILED;
	}

	public void SetUnused()
	{
		Status = E_State.E_UNUSED;
	}

	public void SetActive()
	{
		Status = E_State.E_ACTIVE;
	}

	public AgentAction(AgentActionFactory.E_Type type)
	{
		Type = type;
	}

	public virtual void Reset()
	{
	}

	public override string ToString()
	{
		return Type.ToString() + " " + Status;
	}
}
