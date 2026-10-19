using System.Threading;
using ACT.Battle;
using ACT.Sound;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractMovableTrap")]
public class InteractMovableTrap : StateObjectBase
{
	public int entityNeutralId;

	public Alliance alliance = Alliance.Netural;

	[HideInInspector]
	public MovableTrapData data;

	private CancellationTokenSource m_TokenSource;

	[SerializeField]
	private Vector3 velocity;

	[SerializeField]
	private Vector3 lastPhysicsPosition;

	private PushAttack m_PushAttack;

	private float m_DelayTime;

	private Entity m_TrapEntity;

	private StateRoute currentRoute;

	private float routeLocalTime;

	private int routePointIndex;

	private Vector3 startRoutePosition;

	public override bool serviceSave => true;

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	public override void InitStateObject(int stateId)
	{
		data = entity.GetCompStateObject().StateWorldAssetData as MovableTrapData;
		lastPhysicsPosition = entity.GetCompTransform().physicsPosition;
		m_PushAttack = GetComponentInChildren<PushAttack>();
		CoSpawnTrap(new YooAssetReference(null), entityNeutralId, data.trapType, data.defenceTowerType, alliance, data.initPos, data.initRotate, Vector3.one, null).Forget();
		m_PushAttack.attackSource = m_TrapEntity;
		base.InitStateObject(stateId);
	}

	public override async void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		GameObject root = m_TrapEntity.GetRoot();
		if ((bool)root)
		{
			AssetStationManager.BattleStation.ReleaseInstance(root);
		}
		if (m_TrapEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(m_TrapEntity);
			return;
		}
		await UniTask.WaitUntil(() => m_TrapEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(m_TrapEntity);
	}

	protected override void HandleInitState(int stateId)
	{
		RunStateRoute(stateId);
		base.HandleInitState(stateId);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
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

	private void RunStateRoute(int stateId)
	{
		currentRoute = null;
		CompTransform compTransform = entity.GetCompTransform();
		StateRoute[] stateRoutes = data.stateRoutes;
		foreach (StateRoute stateRoute in stateRoutes)
		{
			if (stateRoute.stateId == stateId)
			{
				currentRoute = stateRoute;
				routePointIndex = 0;
				routeLocalTime = 0f;
				startRoutePosition = compTransform.physicsPosition;
				m_DelayTime = 0f;
				break;
			}
		}
	}

	private void FixedUpdate()
	{
		if (currentRoute == null || currentRoute.route.routePoints.Length == 0)
		{
			return;
		}
		float fixedDeltaTime = entity.GetCompTime().fixedDeltaTime;
		if (fixedDeltaTime == 0f)
		{
			return;
		}
		if (m_DelayTime < currentRoute.delayTime)
		{
			m_DelayTime += fixedDeltaTime;
			return;
		}
		RoutePoint routePoint = currentRoute.route.routePoints[routePointIndex];
		if (routeLocalTime == 0f)
		{
			OnRoutePointStart(routePoint);
		}
		m_PushAttack.moveAttack = routePoint.moveAttack;
		Vector3 value = routePoint.position.value;
		CompTransform compTransform = entity.GetCompTransform();
		lastPhysicsPosition = compTransform.physicsPosition;
		routeLocalTime += fixedDeltaTime;
		Vector3 vector = Vector3.Lerp(startRoutePosition, value, (routePoint.moveTime == 0f) ? 1f : GameLoader.meta.curveLibrary.GetCurve(routePoint.curveIndex).Evaluate(routeLocalTime / routePoint.moveTime));
		if (routeLocalTime < routePoint.moveTime)
		{
			velocity = ((fixedDeltaTime == 0f) ? Vector3.zero : ((vector - lastPhysicsPosition) / fixedDeltaTime));
		}
		else
		{
			velocity = Vector3.zero;
		}
		compTransform.UpdatePosition(vector);
		if (routeLocalTime > routePoint.moveTime + routePoint.waitTime)
		{
			OnRoutePointEnd(routePoint);
			routePointIndex++;
			if (routePointIndex == currentRoute.route.routePoints.Length)
			{
				routePointIndex = 0;
			}
			routeLocalTime = 0f;
			startRoutePosition = vector;
		}
	}

	private void OnRoutePointStart(RoutePoint routePoint)
	{
		if (routePoint.startEffectAssetID != null && routePoint.startEffectAssetID.RuntimeKeyIsValid())
		{
			GameManager.effectSystem.FireEffect(routePoint.startEffectAssetID, transform.position, transform.rotation);
		}
	}

	private void OnRoutePointEnd(RoutePoint routePoint)
	{
		if (routePoint.startEffectAssetID != null && routePoint.startEffectAssetID.RuntimeKeyIsValid())
		{
			GameManager.effectSystem.FireEffect(routePoint.endEffectAssetID, transform.position, transform.rotation);
		}
		Singleton<GameManager>.instance.audioManager.PlaySound(routePoint.audioEndSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
	}

	private void Update()
	{
		transform.position = lastPhysicsPosition + (Time.time - Time.fixedTime) * velocity;
	}

	private async UniTask CoSpawnTrap(YooAssetReference assetReference, int neutralId, int trapType, int defenceTowerType, Alliance alliance, Vector3 pos, Quaternion rotation, Vector3 scale, Transform parent)
	{
		Entity er = (m_TrapEntity = GameManager.entities.factory.CreateMechanismTrapEntity());
		er.GetCompStateObject().StateWorldAssetData = entity.GetCompStateObject().StateWorldAssetData;
		await MonoECS.instance.CoServerSpawnTrapAttack(er, neutralId, trapType, defenceTowerType, alliance, pos, rotation, scale, assetReference, parent);
	}
}
