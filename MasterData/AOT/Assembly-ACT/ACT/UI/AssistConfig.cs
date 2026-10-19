using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public abstract class AssistConfig
{
	[Header("预制资源")]
	public YooAssetReference assistPrefab;
}
