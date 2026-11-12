using UnityEngine;

public class BrickWave : MonoBehaviour
{
	public enum SwitchTriggerType
	{
		None,
		AliveNum,
		DestroyNum
	}

	public bool isTriggerActived;

	public SwitchTriggerType switchTriggerType;

	public int switchThreshold;

	public string nextWaveName;
}
