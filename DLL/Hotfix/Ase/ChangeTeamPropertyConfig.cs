using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
[CreateAssetMenu(menuName = "ChangeTeamKeepProperty")]
public class ChangeTeamPropertyConfig : ScriptableObject
{
	public List<string> RetentionPropertyKeys = new List<string>();
}
