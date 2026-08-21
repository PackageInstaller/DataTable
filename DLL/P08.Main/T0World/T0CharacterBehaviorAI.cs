using BilliardGame.Spell;
using P08.T0World.Player;
using UnityEngine;
using XXXXPathfinding;

namespace T0World;

public class T0CharacterBehaviorAI : T0WorldBehavior
{
	private EasyObjectPoolManager easyPoolMgr;

	public PlayerMoveAnimBrain moveAnimBrain;

	public AIDestinationSetter aiDestinationSetter;

	public BTEnv aiBehaviourEnv;

	private void Start()
	{
		easyPoolMgr = new EasyObjectPoolManager();
		easyPoolMgr.Init();
	}

	public void InitAI(RuntimeAIConfig config)
	{
		aiBehaviourEnv = BTEnv.Create(config);
		InitParams(aiBehaviourEnv);
		OpenMove(isMove: false);
	}

	public void SetFollowTarget(Transform target, string name = "Target")
	{
		aiBehaviourEnv?.AddObject(name, target);
	}

	public void StopAllTask()
	{
		aiBehaviourEnv?.EndAllTask();
	}

	public void DisposeAI()
	{
		aiBehaviourEnv?.Dispose();
	}

	public void OpenMove(bool isMove)
	{
		if (isMove)
		{
			if (!(moveAnimBrain == null))
			{
				moveAnimBrain.WaitAnim = false;
				moveAnimBrain?.EnableAIMove();
			}
		}
		else if (!(moveAnimBrain == null))
		{
			moveAnimBrain?.StopAIMove();
			moveAnimBrain.WaitAnim = true;
		}
	}

	public void AiMoveTargetPos(Vector3 targetPos, Vector3 targetDir)
	{
		aiDestinationSetter.target = null;
		OpenMove(isMove: true);
		Vector3 value = Quaternion.Euler(targetDir) * Vector3.forward;
		moveAnimBrain.SetNavigationDestination(targetPos, value, alignPosAndFacingByTarget: true);
	}

	private void InitParams(BTEnv env)
	{
		env.AddObject("Self", base.gameObject);
	}

	public override void Initialize()
	{
		base.Initialize();
	}

	public override void UpdateBehavior()
	{
		aiBehaviourEnv?.Run();
	}

	public override void DestroyBehavior()
	{
	}
}
