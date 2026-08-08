using Google.Protobuf.Reflection;

namespace Config;

public enum ShapePartType
{
	[OriginalName("ShapePartType_Body")]
	Body,
	[OriginalName("ShapePartType_Foreleg")]
	Foreleg,
	[OriginalName("ShapePartType_Hindleg")]
	Hindleg,
	[OriginalName("ShapePartType_LeftHand")]
	LeftHand,
	[OriginalName("ShapePartType_RightHand")]
	RightHand,
	[OriginalName("ShapePartType_LeftFoot")]
	LeftFoot,
	[OriginalName("ShapePartType_RightFoot")]
	RightFoot,
	[OriginalName("ShapePartType_Head")]
	Head,
	[OriginalName("ShapePartType_Tail")]
	Tail,
	[OriginalName("ShapePartType_LeftArm1")]
	LeftArm1,
	[OriginalName("ShapePartType_LeftArm2")]
	LeftArm2,
	[OriginalName("ShapePartType_RightArm1")]
	RightArm1,
	[OriginalName("ShapePartType_RightArm2")]
	RightArm2,
	[OriginalName("ShapePartType_RightLeg1")]
	RightLeg1,
	[OriginalName("ShapePartType_RightLeg2")]
	RightLeg2,
	[OriginalName("ShapePartType_LeftLeg1")]
	LeftLeg1,
	[OriginalName("ShapePartType_LeftLeg2")]
	LeftLeg2
}
