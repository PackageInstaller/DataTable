using System;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigBlendShapes : ScriptableObject
{
	[Serializable]
	public struct blendShape
	{
		public string shapeName;

		public int weight;

		public bool changeToDefult;
	}

	[Tooltip("表情播放模式")]
	public FacePlayMode playMode;

	public float time;

	public blendShape[] blendShapes;

	[Tooltip("表情动画名称")]
	public string expressionName;

	public int layer;

	public bool IsChangeToDefult;
}
