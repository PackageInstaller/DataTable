using System.Threading;
using ACT.Battle;
using ACT.Event;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractRaidTrap")]
public class InteractRaidTrap : StateObjectBase
{
	private Animator m_animator;

	private int m_BehaveId;

	private float m_MoveSpeed;

	private Vector3 m_Direction;

	private RaidTrapData _data;

	private bool m_IsRunning;

	private float m_delayTime;

	private Entity m_AttackEntity;

	private CancellationTokenSource m_TokenSource;

	private Transform _moveTrans;

	[SerializeField]
	private Material[] _materials;

	private Material[] _originMaterial;

	private bool m_Init;

	public override bool serviceSave => true;

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	public override void InitStateObject(int stateId)
	{
		if (!(entity.GetCompStateObject()?.StateWorldAssetData is RaidTrapData data))
		{
			return;
		}
		_data = data;
		Material[] materials = _materials;
		if (materials != null && materials.Length > 0)
		{
			_originMaterial = new Material[_materials.Length];
		}
		for (int i = 0; i < _materials.Length; i++)
		{
			Material material = _materials[i];
			if (material != null)
			{
				_originMaterial[i] = new Material(material);
				ToonGenericMaterialState.SetDissolveEnabled(material, enabled: true);
			}
		}
		m_TokenSource = new CancellationTokenSource();
		CoSpawnAttackEntity(stateId).Forget();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RaidTrapTriggerEvent, RaidTrapTrigger);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RaidTrapStopChange, RaidTrapStopChange);
		base.InitStateObject(stateId);
	}

	public void RaidTrapTrigger(BaseEventContent obj)
	{
		RaidTrapTriggerEvt raidTrapTriggerEvt = (RaidTrapTriggerEvt)obj;
		SetState(raidTrapTriggerEvt.state);
	}

	public void RaidTrapStopChange(BaseEventContent obj)
	{
		RaidTrapStopChange raidTrapStopChange = (RaidTrapStopChange)obj;
		SetStop(raidTrapStopChange.isStop);
	}

	private async UniTaskVoid CoSpawnAttackEntity(int stateId)
	{
		m_AttackEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		Entity eb = m_AttackEntity;
		eb.GetCompStateObject().StateWorldAssetData = _data;
		await MonoECS.instance.CoServerSpawnTrapAttack(eb, _data.attackId, _data.trapType, _data.defenceTowerType, _data.alliance, transform.position, transform.rotation, Vector3.one, _data.modelAssetID);
		if (!m_TokenSource.IsCancellationRequested)
		{
			eb.GetRoot().TryGetComponent<Animator>(out m_animator);
			m_animator?.SetInteger("state", stateId);
			eb.GetRootTransform().SetParent(transform);
			_moveTrans = eb.GetRoot().GetComponentInChildren<RaidFollower>().transform;
			eb.GetMono().GetMixedPart("attackField").monoAttackPart.Init(_data.fields);
			m_AttackEntity.GetCompAbility().AddAbilities(_data.abilities, AbilitySource.Ability);
			m_Init = true;
		}
	}

	public override void ReleaseStateObject()
	{
		m_Init = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RaidTrapTriggerEvent, RaidTrapTrigger);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RaidTrapStopChange, RaidTrapStopChange);
		m_TokenSource.Cancel();
		m_TokenSource.Dispose();
		ReleaseAttackEntity().Forget();
		for (int i = 0; i < _materials.Length; i++)
		{
			Material material = _materials[i];
			if (material != null)
			{
				material.CopyPropertiesFromMaterial(_originMaterial[i]);
			}
		}
		base.ReleaseStateObject();
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

	public virtual void OnInteract(Entity eb)
	{
	}

	public void SetState(int state)
	{
		ReplayCurrentState();
		m_animator?.SetInteger("state", state);
		m_delayTime = 1f;
	}

	public void SetStop(bool stop)
	{
		if (m_animator != null)
		{
			if (stop)
			{
				m_animator.speed = 0f;
			}
			else
			{
				m_animator.speed = 1f;
			}
		}
	}

	private void ReplayCurrentState()
	{
		AnimatorStateInfo currentAnimatorStateInfo = m_animator.GetCurrentAnimatorStateInfo(0);
		m_animator.Play(currentAnimatorStateInfo.fullPathHash, 0, 0f);
	}

	private void FixedUpdate()
	{
		if (!m_Init || m_animator == null)
		{
			return;
		}
		if (currentStateId == 0)
		{
			m_animator.speed = 0f;
			m_IsRunning = false;
			return;
		}
		bool flag = !MonoECS.instance.running || MonoECS.instance == null || !MonoECS.instance.mainEntity.IsAlive();
		if (flag && m_IsRunning)
		{
			m_animator.speed = 0f;
			m_IsRunning = false;
		}
		else if (!flag && !m_IsRunning)
		{
			m_animator.speed = 1f;
			m_IsRunning = true;
		}
		if (m_delayTime > 0f)
		{
			m_delayTime -= Time.fixedDeltaTime;
			if (m_delayTime <= 0f)
			{
				m_animator?.SetInteger("state", 0);
			}
		}
	}

	private void Update()
	{
		if (!m_Init || !(_moveTrans != null))
		{
			return;
		}
		for (int i = 0; i < _materials.Length; i++)
		{
			Material material = _materials[i];
			if (material != null)
			{
				material.SetFloat(BattleConsts.SHAER_EFFECT_DISSOLVEDiIROFFSET, _moveTrans.position.x);
			}
		}
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	protected override void HandleInitState(int stateId)
	{
		m_animator?.SetInteger("state", stateId);
		m_delayTime = 1f;
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		m_animator?.SetInteger("state", toStateId);
		m_delayTime = 1f;
	}

	protected override void HandleUninitState(int stateId)
	{
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-4 <= stateId)
		{
			return stateId <= 2;
		}
		return false;
	}
}
