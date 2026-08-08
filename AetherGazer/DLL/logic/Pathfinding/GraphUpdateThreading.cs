namespace Pathfinding;

public enum GraphUpdateThreading
{
	UnityThread = 0,
	SeparateThread = 1,
	UnityInit = 2,
	UnityPost = 4,
	SeparateAndUnityInit = 3
}
