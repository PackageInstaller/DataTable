using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/BigWorldInteractObject")]
public class BigWorldRunningInteractObject : StateObjectBase
{
	public YooAssetReference pickAssetAssetID;

	private ChallengeCheckPointData _data;

	private List<AssetLoadHandle> _pointlist = new List<AssetLoadHandle>();

	private int count;

	private Delayer _delayer;

	private const float _delaytime = 0.5f;

	public override bool serviceSave => true;

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (0 <= stateId)
		{
			return stateId <= 3;
		}
		return false;
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

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is ChallengeCheckPointData data)
		{
			_data = data;
			base.InitStateObject(stateId);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		switch (stateId)
		{
		case 1:
		{
			for (int i = 0; i < _data.points.Count; i++)
			{
				int index = i;
				AssetLoadHandle item = AssetStationManager.BattleStation.InstantiateAsync(pickAssetAssetID, transform, instantiateInWorldSpace: false, (AssetLoadHandle result) =>
				{
					GameObject obj = result.AsGameObject();
					BetterAnimation ani = obj.GetComponent<BetterAnimation>();
					ani.GetSequence("appear").OnComplete((AnimationBuilder c) =>
					{
						ani.GetSequence("idle").SetLoops(-1).Play();
					}).Play();
					BigWorldRunningPointTrigger component = obj.GetComponent<BigWorldRunningPointTrigger>();
					component.onTriggerEnter = (Action<Collider>)Delegate.Combine(component.onTriggerEnter, (Action<Collider>)((Collider collier) =>
					{
						obj.GetComponent<Collider>().enabled = false;
						if (obj.activeSelf)
						{
							count++;
							ani.GetSequence("AfterHit").OnComplete((AnimationBuilder c) =>
							{
								obj.SetActive(value: false);
							}).Play();
							BigWordRunningPointChange evt = Singleton<EventManager>.instance.GetEvt<BigWordRunningPointChange>();
							evt.count = count.ToString();
							Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChallengeCollect, evt);
							Singleton<EventManager>.instance.ReleaseEvt(evt);
							if (count == _pointlist.Count)
							{
								_delayer = UpdateTimer.Default.DelayMs(500, () =>
								{
									NetEnterState(2).Forget();
								});
							}
						}
					}));
					obj.transform.position = _data.points[index].value;
				});
				_pointlist.Add(item);
			}
			break;
		}
		case 2:
			DestroyPoint();
			break;
		case 3:
			DestroyPoint();
			break;
		case 0:
			break;
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		switch (stateId)
		{
		case 1:
			DestroyPoint();
			break;
		case 0:
		case 2:
			break;
		}
	}

	private void DestroyPoint()
	{
		if (_pointlist.Count > 0)
		{
			for (int i = 0; i < _pointlist.Count; i++)
			{
				AssetStationManager.BattleStation.ReleaseInstance(_pointlist[i]);
			}
			_pointlist.Clear();
			count = 0;
		}
	}

	public override void ReleaseStateObject()
	{
		if (_delayer.IsValid())
		{
			_delayer.Cancel();
		}
		base.ReleaseStateObject();
		if (currentStateId == 1)
		{
			DestroyPoint();
		}
	}
}
