using ACT.World;
using UnityEngine;

public class ConditionalSwitch : LuminSerializedMonoBehaviour
{
	[SerializeReference]
	private ILoadCondition _loadCondition;

	private bool _isEnabled;

	public void UpdateConditionalPassState()
	{
		if (!(_loadCondition == null || _loadCondition.Return()).Equals(_isEnabled))
		{
			gameObject.SetActive(_isEnabled);
		}
	}

	private void OnEnable()
	{
		_isEnabled = true;
	}

	private void OnDisable()
	{
		_isEnabled = false;
	}
}
