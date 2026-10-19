using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.Behave;
using Bamboo.AssetField;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractSubmergePlatform")]
public class InteractSubmergePlatform : StateObjectBase
{
	public SubmergePlatformBehaveEvents behaveEvent;

	public Transform parent;

	private AssetLoadHandle m_Handle;

	private SubmergePlatformData m_Data;

	public override bool serviceSave => true;

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	public void PhysicsInteractSubmergePlatform(Entity entity, bool enter)
	{
		if (MonoECS.instance.IsMainEntity(entity))
		{
			behaveEvent.Effect = enter;
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
		behaveEvent.OnChangeState(stateId, m_Data);
		if (AssetLoadHandleExtensions.IsValid(m_Handle))
		{
			if (stateId == 0)
			{
				m_Handle.AsGameObject().SetActive(value: true);
			}
			if (stateId == -1)
			{
				m_Handle.AsGameObject().SetActive(value: false);
			}
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is SubmergePlatformData data)
		{
			m_Data = data;
			behaveEvent.Init(this, m_Data, stateId);
			base.InitStateObject(stateId);
			if (m_Data.endPointModelAssetID != null && m_Data.endPointModelAssetID.RuntimeKeyIsValid())
			{
				m_Handle = AssetStationManager.BattleStation.InstantiateAsync(m_Data.endPointModelAssetID, parent);
				m_Handle.Completed += Completed;
			}
		}
	}

	private void Completed(AssetLoadHandle obj)
	{
		GameObject gameObject = obj.AsGameObject();
		Transform transform = gameObject.transform;
		PathInfo[] pathInfos = m_Data.pathInfos;
		transform.position = pathInfos[pathInfos.Length - 1].position;
		if (currentStateId == -1)
		{
			gameObject.SetActive(value: false);
		}
	}

	public override void ReleaseStateObject()
	{
		if (AssetLoadHandleExtensions.IsValid(m_Handle))
		{
			m_Handle.Completed -= Completed;
			AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
		}
		base.ReleaseStateObject();
	}
}
