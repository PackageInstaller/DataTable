using UnityEngine;

namespace ACT.DialogueSystem;

public enum ChatImagePosition
{
	[InspectorName("正中")]
	MiddleCenter = 0,
	[InspectorName("偏左")]
	MiddleLeft = 1,
	[InspectorName("偏右")]
	MiddleRight = 2,
	[InspectorName("自定义")]
	Custom = 10
}
