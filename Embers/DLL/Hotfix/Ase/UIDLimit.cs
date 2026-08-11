using UnityEngine;

namespace Ase;

public class UIDLimit : MonoBehaviour
{
	[SerializeField]
	private int minValue;

	[SerializeField]
	private int maxValue;

	public int currentValue;

	public int GenerateNodeId()
	{
		currentValue++;
		if (currentValue > maxValue)
		{
			Debug.LogError(base.transform.GetFullPath() + "UID超出了最大限制");
		}
		return currentValue;
	}

	public void ResetUID()
	{
		currentValue = minValue;
	}
}
