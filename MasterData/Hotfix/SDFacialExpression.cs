using UnityEngine;

public enum SDFacialExpression
{
	[InspectorName("* 无（仅重置）")]
	None = 0,
	[InspectorName("普通")]
	Normal = 1,
	[InspectorName("大笑")]
	Laugh = 2,
	[InspectorName("舒适")]
	Comfy = 3,
	[InspectorName("疑惑")]
	Confused = 4,
	[InspectorName("闭眼沉思")]
	EyesClosedThinking = 5,
	[InspectorName("尴尬")]
	Awkward = 6,
	[InspectorName("害羞")]
	Shy = 7,
	[InspectorName("难过")]
	Sad = 8,
	[InspectorName("晕头转向")]
	Dizzy = 9,
	[InspectorName("生气")]
	Angry = 10,
	[InspectorName("惊讶")]
	Surprised = 11,
	[InspectorName("困倦")]
	Sleepy = 12,
	[InspectorName("馋")]
	Drool = 13,
	[InspectorName("坏笑")]
	Smirk = 14,
	[InspectorName("* 额外表情 1")]
	Extra_1 = 81,
	[InspectorName("* 额外表情 2")]
	Extra_2 = 82,
	[InspectorName("* 额外表情 3")]
	Extra_3 = 83,
	[InspectorName("* 额外表情 4")]
	Extra_4 = 84,
	[InspectorName("* 额外表情 5")]
	Extra_5 = 85,
	[InspectorName("* Timeline基底（仅开启无相脸）")]
	TimelineBaseBlankFace = 98,
	[InspectorName("* Timeline基底（仅开启正常脸）")]
	TimelineBaseNormalFace = 99
}
