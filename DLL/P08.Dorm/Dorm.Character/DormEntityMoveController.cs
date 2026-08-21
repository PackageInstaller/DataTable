using Sirenix.OdinInspector;
using UnityEngine;

namespace Dorm.Character;

internal class DormEntityMoveController : SerializedMonoBehaviour, IMoveController
{
	private readonly DormStickController controller = new DormStickController();

	private Vector2 input;

	private EntityCmdExecutor cmdExecutor;

	private CharacterController character;

	private Transform lookingTarget;

	private Vector3? lookingDir;

	private DormEntityAction.MoveByControllerCmd cmd;

	public Vector2 InputVec
	{
		get
		{
			return input;
		}
		set
		{
			input = value;
			controller.UpdateLogic(input);
		}
	}

	public Vector3 GetMovingVec()
	{
		return controller.GetMovingVec();
	}

	private void Awake()
	{
		cmdExecutor = GetComponent<EntityCmdExecutor>();
		character = GetComponent<CharacterController>();
		controller.StartMoving = StartMoving;
		cmd = new DormEntityAction.MoveByControllerCmd(character, null);
		cmd.lookingTarget = lookingTarget;
		cmd.lookingDir = lookingDir;
	}

	private bool StartMoving(DormStickController controller)
	{
		if (cmdExecutor.CanAccept(DormEntityManager.EntityCmdPriority.Normal))
		{
			DormEntityAction.MoveByControllerCmd moveByControllerCmd = cmd.UseStickController(this).StandWhenBlocked(1f);
			moveByControllerCmd.Reset();
			return cmdExecutor.SendCmd(moveByControllerCmd, queue: false);
		}
		return false;
	}

	public void SetLookingTarget(Transform target)
	{
		lookingTarget = target;
		if (cmd != null)
		{
			cmd.lookingTarget = target;
		}
	}

	public void SetLookingDir(Vector3? lookingDir)
	{
		this.lookingDir = lookingDir;
		if (cmd != null)
		{
			cmd.lookingDir = lookingDir;
		}
	}

	private void OnDisable()
	{
		cmd?.ForceStop();
		InputVec = Vector3.zero;
	}
}
