using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class TouchLayout : MonoBehaviour
{
	[SerializeField]
	public List<TouchLayoutPos> pos;

	public TouchLayoutPos GetConfig(TouchLayoutEnum type)
	{
		for (int i = 0; i < pos.Count; i++)
		{
			if (pos[i].touchType == type)
			{
				return pos[i];
			}
		}
		return null;
	}
}
