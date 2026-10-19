using System.Threading;
using ACT.MultiPlayer;
using UnityEngine;

namespace ACT.Battle;

public class CompTrajectory : EcsComponent
{
	public RuntimeTrajectory trajectory;

	public Ability ability;

	public MPSkill mpSkill;

	public TrajectoryState state;

	public bool lifeEnd;

	public bool currentFrameLifeEnd;

	public float life;

	public int hitCount;

	public int reboundCount;

	public Shape shape;

	public Vector3 size;

	public Collider[] customColliders;

	public bool forceDestroy;

	public bool isOverrideLifeTime;

	public float overrideLifeTime;

	public float lifePatternLife;

	public TrajectoryTag tag;

	public string ignoreEnvironmentCollisionTag;

	private CancellationTokenSource m_LifeTokenSource;

	public bool hasIgnoreEnvironmentCollisionTag => !string.IsNullOrEmpty(ignoreEnvironmentCollisionTag);

	public bool isActive => state == TrajectoryState.Active;

	public bool ShouldIgnoreEnvironmentCollision(Collider collider)
	{
		if (!hasIgnoreEnvironmentCollisionTag || collider == null)
		{
			return false;
		}
		int num = 1 << collider.gameObject.layer;
		if ((BattleConsts.enviromentMask & num) != 0)
		{
			return collider.CompareTag(ignoreEnvironmentCollisionTag);
		}
		return false;
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		trajectory?.Reset();
		trajectory = null;
		ability = null;
		mpSkill = default;
		state = TrajectoryState.BeforeInit;
		life = 0f;
		lifeEnd = false;
		hitCount = 0;
		reboundCount = 0;
		forceDestroy = false;
		isOverrideLifeTime = false;
		overrideLifeTime = 0f;
		tag = (TrajectoryTag)0;
		ignoreEnvironmentCollisionTag = null;
		lifePatternLife = 0f;
		customColliders = null;
	}

	public float RemainingLifeTime()
	{
		return Mathf.Max(0f, lifePatternLife - life);
	}
}
