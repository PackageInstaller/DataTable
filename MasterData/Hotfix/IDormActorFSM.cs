using UnityEngine;

public abstract class IDormActorFSM
{
	public class DormActorStateData
	{
		public int[] vInts;

		public bool[] vBools;

		public string[] vStrings;

		public float[] vFloats;
	}

	public abstract int State { get; }

	public abstract void OnEnter(object data = null);

	public abstract void OnExit();

	public abstract void OnUpdate();

	public virtual void OnLateUpdate()
	{
	}

	public virtual void OnInputUpdate(bool movementHasInput, Vector2 inputValue, bool bWalk = false)
	{
	}
}
