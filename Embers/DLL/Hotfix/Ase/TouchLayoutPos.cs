using System;
using UnityEngine;

namespace Ase;

[Serializable]
public class TouchLayoutPos
{
	public TouchLayoutEnum touchType;

	public RectTransform root;

	public bool defaultActive;
}
