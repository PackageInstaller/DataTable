using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class TweenList
{
	public string name;

	[HideInInspector]
	public List<TweenNode> tweenList = new List<TweenNode>(32);

	public string tweenJson;
}
