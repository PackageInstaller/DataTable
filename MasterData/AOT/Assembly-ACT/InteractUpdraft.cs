using ACT.Sound;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;

[RequireComponent(typeof(BoxCollider))]
public class InteractUpdraft : StateObjectBase
{
	public Transform dynamicRegionVfx;

	public Transform dynamicTopVfx;

	public Transform burstVfx;

	public Transform lockVfx;

	public ObjectSound sound;

	private UpdraftData m_Data;

	private BoxCollider _box;

	private UpdraftRegion _region;

	private Vector2 _vfxBaseSize = new Vector2(2f, 10f);

	private bool is2DAudio;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is UpdraftData data)
		{
			m_Data = data;
			if (m_Data == null)
			{
				base.InitStateObject(stateId);
				return;
			}
			_box.center = m_Data.triggerField.center;
			_box.size = m_Data.triggerField.size;
			EnsureRegion();
			_region.dynamicRegionVfx = dynamicRegionVfx;
			_region.dynamicTopVfx = dynamicTopVfx;
			_region.Init(m_Data.ForceDir, m_Data.Force, _box.center, _box.size, m_Data.useDynamicRegion, _vfxBaseSize);
			base.InitStateObject(stateId);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		gameObject.SetActive(stateId >= 0);
		lockVfx?.gameObject.SetActive(stateId == 2);
		bool active = stateId == 0;
		if (_region != null)
		{
			_region.SetEnabled(active);
			return;
		}
		dynamicRegionVfx?.gameObject.SetActive(active);
		dynamicTopVfx?.gameObject.SetActive(active);
		_box.enabled = active;
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (fromStateId == 2 && toStateId == 0)
		{
			if (burstVfx != null)
			{
				burstVfx.gameObject.SetActive(value: true);
			}
		}
		else
		{
			burstVfx?.gameObject.SetActive(value: false);
		}
		lockVfx?.gameObject.SetActive(toStateId == 2);
		bool active = toStateId == 0;
		if (_region != null)
		{
			_region.SetEnabled(active);
			return;
		}
		dynamicRegionVfx?.gameObject.SetActive(active);
		dynamicTopVfx?.gameObject.SetActive(active);
		_box.enabled = active;
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

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	private void Awake()
	{
		_box = GetComponent<BoxCollider>();
		_box.isTrigger = true;
		EnsureRegion();
	}

	private void EnsureRegion()
	{
		if (_region == null)
		{
			_region = GetComponent<UpdraftRegion>();
			if (_region == null)
			{
				_region = gameObject.AddComponent<UpdraftRegion>();
			}
		}
	}

	private void Update()
	{
		if (!(_region == null) && !(sound == null) && sound.useAxisAttenuationProxy)
		{
			sound.attenuationFreeYDistance = _box.size.y;
		}
	}
}
