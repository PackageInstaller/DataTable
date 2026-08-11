using System.Collections.Generic;
using UnityEngine;

namespace Ase.Effect;

public class EffectBossFaintView : MonoBehaviour
{
	[SerializeField]
	private List<EffectMatLerp> _allMatLerps;

	public void StartMatLerp(bool isRevert)
	{
		for (int i = 0; i < _allMatLerps.Count; i++)
		{
			_allMatLerps[i].StartMatLerp(isRevert);
		}
	}

	public void StartNormalMatLerp()
	{
		for (int i = 0; i < _allMatLerps.Count; i++)
		{
			_allMatLerps[i].StartMatLerp(isRevert: false);
		}
	}

	public void StartRevertMatLerp()
	{
		for (int i = 0; i < _allMatLerps.Count; i++)
		{
			_allMatLerps[i].StartMatLerp(isRevert: true);
		}
	}

	public void EndMatLerp()
	{
		for (int i = 0; i < _allMatLerps.Count; i++)
		{
			_allMatLerps[i].EndMatLerp();
		}
	}
}
