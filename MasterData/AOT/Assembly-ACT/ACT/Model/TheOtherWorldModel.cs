using ACT.Event;
using Fundamental;

namespace ACT.Model;

public class TheOtherWorldModel : Model<TheOtherWorldModel>
{
	public enum TheOtherWorldOwnerShip
	{
		Both,
		NormalWorld,
		TheOtherWorld
	}

	public enum TheOtherWorldStatus
	{
		NormalWorld = 1,
		TheOtherWorld
	}

	private bool _activeFollowClairvoyance;

	private TheOtherWorldStatus _status = TheOtherWorldStatus.NormalWorld;

	private float _clairvoyanceTime;

	private const float DefaultClairvoyanceTime = 10f;

	public bool ActiveFollowClairvoyance
	{
		get
		{
			return _activeFollowClairvoyance;
		}
		set
		{
			if (value != _activeFollowClairvoyance)
			{
				_activeFollowClairvoyance = value;
				if (value)
				{
					EnableFollowClairvoyance();
				}
				else
				{
					DisableFollowClairvoyance();
				}
			}
		}
	}

	public float ClairvoyanceTime => _clairvoyanceTime;

	public TheOtherWorldStatus Status => _status;

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
		ActiveFollowClairvoyance = false;
	}

	public void ChangeStatus(TheOtherWorldStatus status)
	{
		if (_status != status)
		{
			TheOtherWorldStatus status2 = _status;
			_status = status;
			OnOtherWorldStatusChanged(status2, status);
		}
	}

	private void OnOtherWorldStatusChanged(TheOtherWorldStatus before, TheOtherWorldStatus after)
	{
		switch (after)
		{
		case TheOtherWorldStatus.TheOtherWorld:
			EnterOtherWorld();
			break;
		case TheOtherWorldStatus.NormalWorld:
			EnterNormalWorld();
			break;
		}
		TheOtherWorldChangeEvent evt = Singleton<EventManager>.instance.GetEvt<TheOtherWorldChangeEvent>();
		evt.before = before;
		evt.after = after;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TheOtherWorldStateChange, evt);
	}

	private void EnterOtherWorld()
	{
		GameManager.SystemTheOtherWorld.EnterTheOtherWorld();
	}

	private void EnterNormalWorld()
	{
		GameManager.SystemTheOtherWorld.EnterNormalWorld();
	}

	private void EnableFollowClairvoyance()
	{
		_clairvoyanceTime = 10f;
		GameManager.SystemTheOtherWorld.EnableFollowClairvoyance();
	}

	private void DisableFollowClairvoyance()
	{
		GameManager.SystemTheOtherWorld.DisableFollowClairvoyance();
	}

	public bool IsBelongWorld(TheOtherWorldOwnerShip ownership)
	{
		if (ownership == TheOtherWorldOwnerShip.Both)
		{
			return true;
		}
		return ownership == (TheOtherWorldOwnerShip)_status;
	}

	public void ReduceClairvoyance(float deltaTime)
	{
		if (_clairvoyanceTime > 0f)
		{
			_clairvoyanceTime -= deltaTime;
			if (_clairvoyanceTime <= 0f)
			{
				ActiveFollowClairvoyance = false;
			}
		}
	}
}
