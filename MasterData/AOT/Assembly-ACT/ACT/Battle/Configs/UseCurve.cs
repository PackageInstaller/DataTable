using UnityEngine;

namespace ACT.Battle.Configs;

[Tooltip(" 补偿的速度向量 要参考那个curve ， None就是 线性的补偿， （Y）Rootmotion是参考动画的，Custom自定义的Curve")]
public enum UseCurve
{
	None,
	RootMotion,
	YMotion,
	XMotion,
	Custom
}
