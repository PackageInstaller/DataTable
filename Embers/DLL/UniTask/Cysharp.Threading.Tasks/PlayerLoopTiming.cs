namespace Cysharp.Threading.Tasks;

public enum PlayerLoopTiming
{
	Initialization,
	LastInitialization,
	EarlyUpdate,
	LastEarlyUpdate,
	FixedUpdate,
	LastFixedUpdate,
	PreUpdate,
	LastPreUpdate,
	Update,
	LastUpdate,
	PreLateUpdate,
	LastPreLateUpdate,
	PostLateUpdate,
	LastPostLateUpdate,
	TimeUpdate,
	LastTimeUpdate
}
