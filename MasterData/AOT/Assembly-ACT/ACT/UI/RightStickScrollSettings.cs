using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public class RightStickScrollSettings
{
	[Header("基础设置")]
	public string bindingAction;

	public float scrollSpeed = 500f;

	public float scrollSmooth = 10f;

	public float deadZone = 0.1f;

	public bool enableControl = true;

	public bool invertVertical;

	public bool invertHorizontal;

	public bool forbiddenScrollWhenContentNotFull = true;

	[Header("高级设置")]
	public bool onlyVertical = true;

	public bool onlyHorizontal;

	public float accelerationCurve = 1f;

	public float maxSpeed = 1000f;

	public bool useHorizontalContentPositionBounds;

	public float horizontalContentMinX;

	public float horizontalContentMaxX;

	[Header("小内容滚动设置")]
	public bool allowSmallContentScroll = true;

	public float smallContentScrollRange = 0.2f;

	public float smallContentReturnSpeed = 5f;
}
