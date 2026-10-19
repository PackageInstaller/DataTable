namespace ACT.Model.Jump;

public interface IJumpable
{
	LuminModelType JumpSourceType { get; }

	JumpResult CanJump(RuntimeJumpData jumpData);

	void Jump(RuntimeJumpData jumpData);
}
