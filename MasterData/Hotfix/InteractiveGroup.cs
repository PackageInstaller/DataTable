using UnityEngine;

public class InteractiveGroup : MonoBehaviour
{
	public string groupTitle;

	public InteractiveBase[] _ineractives;

	private void Start()
	{
		if (_ineractives == null || _ineractives.Length == 0)
		{
			resetData();
		}
		InteractiveBase[] ineractives = _ineractives;
		if (ineractives != null && ineractives.Length > 0)
		{
			Singleton<InteractiveManager>.Instance.AddInteractiveGroup(this);
		}
	}

	private void resetData()
	{
		_ineractives = transform.GetComponentsInChildren<InteractiveBase>(includeInactive: true);
	}

	public void setIneractiveInerState(InteractiveManager.processState _inerState)
	{
		for (int i = 0; i < _ineractives.Length; i++)
		{
			_ineractives[i].SetProcessState(_inerState);
		}
	}

	public void ForceActive()
	{
		for (int i = 0; i < _ineractives.Length; i++)
		{
			if (_ineractives[i].defaultDeactive)
			{
				_ineractives[i].ForceActive();
			}
		}
	}
}
