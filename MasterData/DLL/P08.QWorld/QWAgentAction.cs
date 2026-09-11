public class QWAgentAction
{
	public enum E_Type
	{
		ChangeName = 1,
		ChangeRush = 301,
		ChangeFastRush = 302,
		PlayAnim = 3,
		MoveToTarget = 4,
		ShowQuest = 5,
		Teleport = 6,
		RotateToForward = 7,
		EnterInteractiveState = 8,
		LookAt = 9,
		AddToStage = 10,
		RemoveFromStage = 11,
		EnterPlayerFocusState = 12,
		TeleportCamera = 13,
		BodyDither = 20,
		Furniture_PlayEffect = 31,
		Furniture_AttachTo = 32,
		Furniture_Enter = 33,
		Furniture_GrabItem = 34,
		Furniture_Visible = 35,
		Camera_LookAtTarget = 61,
		Camera_Reset = 62,
		CommonHudShow = 101,
		ChangeCharacter = 201,
		PostChangeCharacter = 202,
		ChangeInteractionMode = 901
	}

	public enum E_State
	{
		E_ACTIVE,
		E_SUCCESS,
		E_FAILED,
		E_UNUSED
	}

	public E_Type Type;

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

	public QWAgentAction(E_Type type)
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
