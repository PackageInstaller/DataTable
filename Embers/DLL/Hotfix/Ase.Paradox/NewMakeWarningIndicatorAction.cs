using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建预警圈(新)", 0)]
[Description("根据指定的形状、位置、时间和颜色等参数创建预警圈。")]
[Category("✫ DragonLost/Entity")]
public class NewMakeWarningIndicatorAction : ActionTaskBase
{
	[ParadoxNotion.Design.Header("============通用数据=============")]
	[RequiredField]
	[Name("预警圈创建者ID", 0)]
	public BBParameter<int> CreatorId;

	[Name("形状", 0)]
	public WarningIndicatorFormType WarnRingShape;

	[ShowIf("WarnRingShape", 1)]
	[Name("矩形的X轴（左右）", 0)]
	public BBParameter<float> Length;

	[ShowIf("WarnRingShape", 1)]
	[Name("矩形的Z轴（前后）", 0)]
	public BBParameter<float> Width;

	[HideIf("WarnRingShape", 1)]
	[Name("圆形或环形的半径", 0)]
	public BBParameter<float> radius;

	[ShowIf("WarnRingShape", 2)]
	[Name("环形的内圈半径", 0)]
	public BBParameter<float> ringRadius;

	[HideIf("WarnRingShape", 1)]
	[Name("圆形或环形的角度", 0)]
	public BBParameter<float> warnRingAngle;

	[ParadoxNotion.Design.Header("============位置数据=============")]
	[Tooltip("FixPoint,\t固定点\r\nFollow,\t\t跟随实体移动\r\nEntityPoint,\t固定实体位置")]
	[Name("跟随类型", 0)]
	public FollowType FollowType;

	[ShowIf("FollowType", new int[] { 1, 2 })]
	[RequiredField]
	[Name("跟随的实体ID", 0)]
	public BBParameter<int> FollowId;

	[ShowIf("FollowType", 0)]
	[Name("固定生成位置", 0)]
	public BBParameter<Vector3> FixPoint;

	[ShowIf("FollowType", new int[] { 1, 2 })]
	[Name("生成位置偏移", 0)]
	public BBParameter<Vector3> PositionOffset;

	[ShowIf("FollowType", 0)]
	[Name("固定生成角度", 0)]
	public BBParameter<float> FixAngle;

	[ShowIf("FollowType", new int[] { 1, 2 })]
	[Name("生成角度偏移", 0)]
	public BBParameter<float> AngleOffset;

	[ShowIf("FollowType", 1)]
	[Name("是否为相对位置偏移", 0)]
	[Description("偏移位置是否继承旋转值")]
	public bool isRelativePosition;

	[ShowIf("FollowType", 1)]
	[Name("是否为相对角度偏移", 0)]
	[Description("旋转角度是否继承旋转值")]
	public bool isRelativeRotation;

	[ParadoxNotion.Design.Header("============时间数据=============")]
	[Name("总生命周期（持续帧）", 0)]
	public BBParameter<int> DurationFrame;

	[Name("充能帧", 0)]
	[Description("预警圈的充能帧数。")]
	public BBParameter<int> ChargingDurationFrame;

	[ParadoxNotion.Design.Header("============颜色数据=============")]
	[Name("充能期间的进度条颜色", 0)]
	public Color ChargingColor = Color.white;

	[Name("充能完成的预警圈颜色", 0)]
	public Color FinishedColor = Color.white;

	[Name("返回预警圈实体ID", 0)]
	public BBParameter<int> returnEntityID;

	private WarningIndicatorData _indicatorData;

	private WarningIndicatorCommonData commonData;

	protected override async void OnExecute()
	{
		base.OnExecute();
		float num = (float)DurationFrame.value * 0.033f;
		float num2 = (float)ChargingDurationFrame.value * 0.033f;
		WarningIndicatorShapeData shapeData = null;
		switch (WarnRingShape)
		{
		case WarningIndicatorFormType.Circle:
			shapeData = WarnIndicatorProcessor.ProcessWarnIndicatorCircle(radius.value, warnRingAngle.value);
			break;
		case WarningIndicatorFormType.Rect:
			shapeData = WarnIndicatorProcessor.ProcessWarnIndicatorRect(Length.value, Width.value);
			break;
		case WarningIndicatorFormType.Ring:
			shapeData = WarnIndicatorProcessor.ProcessWarnIndicatorRing(ringRadius.value, radius.value, warnRingAngle.value);
			break;
		}
		WarningIndicatorTimeData timeData = WarnIndicatorProcessor.ProcessWarnIndicatorTime(Mathf.Max(num - num2, 0f), num2, 0f, 0f);
		BaseEntity entity = GetEntity(FollowId.value, isSyncEntity: false);
		BaseEntity entity2 = GetEntity(CreatorId.value, isSyncEntity: false);
		switch (FollowType)
		{
		case FollowType.FixPoint:
			commonData = WarnIndicatorProcessor.ProcessWarnIndicatorCommonData(FixPoint.value, FixAngle.value, entity2, isRelativeAngle: false, isRelativePosition: false, Vector3.zero, 0f, skillStop: false, ChargingColor, FinishedColor);
			_indicatorData = WarnIndicatorProcessor.ProcessWarnIndicator<NormalWarningIndicatorData>(shapeData, timeData, commonData);
			(_indicatorData as NormalWarningIndicatorData)?.ProcessNormal();
			break;
		case FollowType.Follow:
			commonData = WarnIndicatorProcessor.ProcessWarnIndicatorCommonData(entity.transform.position, entity.transform.eulerAngles.y, entity2, isRelativeRotation, isRelativePosition, PositionOffset.value, AngleOffset.value, skillStop: false, ChargingColor, FinishedColor);
			_indicatorData = WarnIndicatorProcessor.ProcessWarnIndicator<FollowWarningIndicatorData>(shapeData, timeData, commonData);
			(_indicatorData as FollowWarningIndicatorData)?.ProcessFollow(FollowId.value);
			break;
		case FollowType.EntityPoint:
			commonData = WarnIndicatorProcessor.ProcessWarnIndicatorCommonData(entity.transform.position, entity.transform.eulerAngles.y, entity2, isRelativeAngle: false, isRelativePosition: false, PositionOffset.value, AngleOffset.value, skillStop: false, ChargingColor, FinishedColor);
			_indicatorData = WarnIndicatorProcessor.ProcessWarnIndicator<NormalWarningIndicatorData>(shapeData, timeData, commonData);
			(_indicatorData as NormalWarningIndicatorData)?.ProcessNormal();
			break;
		}
		WarningIndicatorEntity warningIndicatorEntity = ownerEntity.GetSystem<WarningIndicatorSystem>().CreateWarnRingIndicator(_indicatorData);
		if (warningIndicatorEntity != null)
		{
			returnEntityID.value = warningIndicatorEntity.Id;
		}
		EndAction();
	}
}
