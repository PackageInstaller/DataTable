#define ENABLE_LOG
using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("残影效果", 0)]
[Category("✫ DragonLost/View")]
[Description("打开或关闭实体的残影效果。")]
public class GhostAction : ActionTaskBase
{
	[Name("实体Id", 0)]
	[Description("要应用残影效果的实体的ID。")]
	public BBParameter<int> entityId;

	[Name("打开或关闭效果", 0)]
	[Description("指示是否打开（true）或关闭（false）残影效果。")]
	public bool isOpen;

	[Name("是否不位移也要创建残影", 0)]
	[Description("指示即使实体未移动也要创建残影。")]
	public bool createEveryFrame;

	[Name("残影大小", 0)]
	[Description("残影的大小。")]
	public Vector3 chostSizeList;

	[Name("持续时间", 0)]
	[Description("残影的持续时间。")]
	public float duration;

	[Name("创建新残影间隔", 0)]
	[Description("创建新残影的时间间隔。")]
	public float interval;

	[Name("残影材质ID", 0)]
	[Description("残影的材质球。")]
	public int materialID;

	[Name("残影数量", 0)]
	[Description("最大残影数量。")]
	public int maxCount;

	[Name("渐隐色调Shadow参数名", 0)]
	[Description("用于渐隐的参数名。")]
	public string propertyName;

	[Name("渐隐色调Shadow参数类型", 0)]
	[Description("用于渐隐的参数类型，可以是颜色（Color）或浮点数（Float）之一。")]
	[PopupField(new object[] { "Color", "Float" })]
	public string propertyType = "Color";

	[Name("渐隐曲线", 0)]
	[Description("用于渐隐的曲线。")]
	public AnimationCurve ColorTintCurve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 0f));

	[Name("是否随行为树结束关闭残影", 0)]
	public bool IsStopEffectOnTreeEnd;

	[Name("是否只使用部位残影", 0)]
	public bool IsOnlyPartGhost;

	[Name("实体绑点Key列表", 0)]
	[Description("实体绑定点的名称。")]
	[ShowIf("IsOnlyPartGhost", 1)]
	public BBParameter<List<string>> PointListName;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
		if (entity == null)
		{
			LogActionError("打开残影效果错误：实体为空!");
			EndAction(success: false);
			return;
		}
		if (isOpen)
		{
			DRMaterial dataRow = GameEntry.DataTable.GetDataRow<DRMaterial>(materialID);
			if (dataRow != null)
			{
				string materialByParentSkinConfig = ownerEntity.GetMaterialByParentSkinConfig(dataRow);
				Material material = GameEntry.Resource.LoadAsset<Material>(materialByParentSkinConfig);
				entity.GetComponent<EntityViewComponent>().EntityView.InitGhost(createEveryFrame, chostSizeList, duration, interval, material, maxCount, propertyName, propertyType, ColorTintCurve, IsOnlyPartGhost, PointListName.value);
				entity.GetSystem<GameResourceSystem>()?.AddMaterialResPath(materialByParentSkinConfig);
			}
		}
		else
		{
			entity.GetComponent<EntityViewComponent>().EntityView.HideGhost();
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null)
		{
			BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
			if (entity == null)
			{
				LogActionError("打开残影效果错误：实体为空!");
				EndAction(success: false);
			}
			else if (IsStopEffectOnTreeEnd)
			{
				entity.GetComponent<EntityViewComponent>().EntityView.HideGhost();
			}
		}
	}
}
