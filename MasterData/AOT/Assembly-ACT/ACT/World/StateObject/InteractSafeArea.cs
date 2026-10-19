using System;
using System.Threading;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using UnityEngine;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractSafeArea")]
public class InteractSafeArea : StateObjectBase
{
	private SafeAreaData m_Data;

	private AsyncOperationHandle<GameObject> m_Handle;

	public Animator animator;

	private CancellationTokenSource m_TokenSource;

	private const string CANTBEATTACK = "damageableCantbeAttack";

	private float m_CdTimer;

	private float m_DurationTimer;

	private Entity m_AttackEntity;

	private IDisposable m_SyncAttackablePositionDisposable;

	private bool m_init;

	private static readonly int ToShine = Animator.StringToHash("toShine");

	private static readonly int Hit = Animator.StringToHash("Hit");

	public override bool serviceSave => true;

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return true;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	protected override void HandleInitState(int stateId)
	{
	}

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is SafeAreaData data)
		{
			m_Data = data;
			m_TokenSource = new CancellationTokenSource();
			CoSpawnAttackEntity().Forget();
			base.InitStateObject(stateId);
		}
	}

	private async UniTaskVoid CoSpawnAttackEntity()
	{
		m_AttackEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		Entity eb = m_AttackEntity;
		MonoECS.instance.SpawnAttackInteractObject(eb, 2, m_Data.trapType, m_Data.defenceTowerType, m_Data.initPos, m_Data.alliance, m_Data.box.size, m_Data.initRotate);
		if (m_TokenSource.IsCancellationRequested)
		{
			return;
		}
		eb.GetCompStateObject().StateWorldAssetData = m_Data;
		CompAbility? compAbility = eb.GetCompAbility();
		compAbility.damageableHited = (Action<Entity>)Delegate.Combine(compAbility.damageableHited, new Action<Entity>(OnHited));
		compAbility.AddAbility(eb, "damageableCantbeAttack", AbilitySource.Ability, default, 1);
		m_SyncAttackablePositionDisposable = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.FixedUpdate).Subscribe((AsyncUnit _) =>
		{
			if (eb.IsValid)
			{
				eb.GetRootTransform().position = transform.position;
			}
		});
		m_init = true;
	}

	private void OnHited(Entity attacker)
	{
		CompAbility compAbility = m_AttackEntity.GetCompAbility();
		if (m_Data.abilities != null)
		{
			compAbility.AddAbilities(m_Data.abilities, AbilitySource.Ability);
		}
		m_CdTimer = m_Data.cdTime;
		m_DurationTimer = m_Data.duration;
		animator.SetTrigger(Hit);
		compAbility.damageableHited = (Action<Entity>)Delegate.Remove(compAbility.damageableHited, new Action<Entity>(OnHited));
	}

	private void FixedUpdate()
	{
		if (!m_init)
		{
			return;
		}
		CompTime compTime = m_AttackEntity.GetCompTime();
		CompAbility compAbility = m_AttackEntity.GetCompAbility();
		if (m_CdTimer > 0f)
		{
			m_CdTimer -= compTime.fixedDeltaTime;
			if (m_CdTimer < 0f)
			{
				m_CdTimer += m_Data.cdTime;
				compAbility.damageableHited = (Action<Entity>)Delegate.Combine(compAbility.damageableHited, new Action<Entity>(OnHited));
			}
		}
		if (m_DurationTimer > 0f)
		{
			m_DurationTimer -= compTime.fixedDeltaTime;
			if (m_DurationTimer <= m_Data.shineTime && m_DurationTimer > 0f)
			{
				animator.SetBool(ToShine, value: true);
			}
			else
			{
				animator.SetBool(ToShine, value: false);
			}
		}
	}

	private async UniTaskVoid ReleaseAttackEntity()
	{
		if (!m_AttackEntity.IsValid)
		{
			return;
		}
		if (m_AttackEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(m_AttackEntity);
			return;
		}
		await UniTask.WaitUntil(() => m_AttackEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(m_AttackEntity);
	}

	public override void ReleaseStateObject()
	{
		m_TokenSource.Cancel();
		m_TokenSource.Dispose();
		m_SyncAttackablePositionDisposable?.Dispose();
		ReleaseAttackEntity().Forget();
		base.ReleaseStateObject();
	}

	public void OnDestroy()
	{
		m_SyncAttackablePositionDisposable?.Dispose();
	}
}
