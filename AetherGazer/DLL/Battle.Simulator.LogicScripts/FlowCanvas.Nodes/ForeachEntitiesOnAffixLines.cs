using System.Collections.Generic;
using Config;
using Entitas;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历词缀连线上的实体", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历词缀连线上的实体, 两两判定, 慎用")]
public class ForeachEntitiesOnAffixLines : FlowNode
{
	private IGroup<SimEntity> mEntityBuffGroup;

	private List<SimEntity> mEntityBuffer = new List<SimEntity>();

	private List<SimEntity> mAffixList = new List<SimEntity>();

	private List<int> mCollisions = new List<int>();

	private HashSet<int> mEntityIDs = new HashSet<int>();

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		mEntityBuffGroup = null;
		mEntityBuffer.Clear();
		mAffixList.Clear();
		mCollisions.Clear();
		mEntityIDs.Clear();
	}

	protected override void RegisterPorts()
	{
		int res = 0;
		AddValueOutput("结果", () => res);
		ValueInput<int> affixIDInput = AddValueInput<int>("词缀ID");
		ValueInput<RoleType> targetRoleTypeInput = AddValueInput<RoleType>("目标类型");
		ValueInput<int> widthVar = AddValueInput<int>("宽(毫米)");
		ValueInput<int> heightVar = AddValueInput<int>("高(毫米)");
		FlowOutput doOut = AddFlowOutput("Do");
		FlowOutput doneOut = AddFlowOutput("Done");
		AddFlowInput("", delegate(Flow f)
		{
			if (mEntityBuffGroup == null)
			{
				mEntityBuffGroup = base.mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBuff));
			}
			mAffixList.Clear();
			int affixBuffId = ConfigHelper.GetInstance().GetConfig<affix_type>(affixIDInput.value).AffixBuffId;
			mEntityBuffGroup.GetEntities(mEntityBuffer);
			for (int i = 0; i < mEntityBuffer.Count; i++)
			{
				SimEntity simEntity = mEntityBuffer[i];
				for (int j = 0; j < simEntity.entityBuff.mBuffConfigID.Count; j++)
				{
					if (simEntity.entityBuff.mBuffConfigID[j] == affixBuffId && simEntity.hasEntityBlackboard && simEntity.entityBlackboard.var.mHP > 0 && simEntity.hasEntityPositon)
					{
						mAffixList.Add(simEntity);
						break;
					}
				}
			}
			int value = widthVar.value;
			int value2 = heightVar.value;
			uint value3 = (uint)targetRoleTypeInput.value;
			for (int k = 0; k < mAffixList.Count; k++)
			{
				for (int l = k + 1; l < mAffixList.Count; l++)
				{
					Int3 mPosition = mAffixList[k].entityPositon.mPosition;
					Int3 mPosition2 = mAffixList[l].entityPositon.mPosition;
					Int3 @int = mPosition - mPosition2;
					int magnitude2D = @int.magnitude2D;
					mCollisions.Clear();
					SimPhysics.OverlapBox((mPosition + mPosition2) / 2f, @int.NormalizeTo(1000), Int3.zero, new Int3(value, value2, magnitude2D), mCollisions, value3);
					mEntityIDs.Clear();
					for (int m = 0; m < mCollisions.Count; m++)
					{
						SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(mCollisions[m]);
						if (simEntityByMultiColliders != null)
						{
							mEntityIDs.Add(simEntityByMultiColliders.creationIndex);
						}
					}
					foreach (int mEntityID in mEntityIDs)
					{
						res = mEntityID;
						doOut.Call(f);
					}
				}
			}
			doneOut.Call(f);
		});
	}
}
