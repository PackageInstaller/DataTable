using Unity.Collections;
using UnityEngine;

public class ConfigActVersion : ScriptableObject
{
	[ReadOnly]
	public string clientCommitId;

	[ReadOnly]
	public string tableCommitId;
}
