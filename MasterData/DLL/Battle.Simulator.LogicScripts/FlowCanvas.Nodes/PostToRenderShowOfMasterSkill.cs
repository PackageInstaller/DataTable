using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("通知芯片技能演出(逻辑)", 0)]
[Category("Logic/芯片技能")]
[Description("通知渲染层进行芯片技能演出，本质是给环境实体添加逻辑ID为 100099989 添加BUFF\n-1:默认品级;\n0:强制低品级")]
public class PostToRenderShowOfMasterSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		ValueInput<int> levelInput = AddValueInput<int>("强制规格", "level").SetDefaultAndSerializedValue(-1);
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!base.graph.mSimContext.hasEntitySourceSpace)
			{
				errorOut.Call(f);
			}
			else
			{
				SimEntity entitySourceSpaceEntity = base.graph.mSimContext.entitySourceSpaceEntity;
				if (!entitySourceSpaceEntity.hasEntityBuff)
				{
					entitySourceSpaceEntity.AddEntityBuff(FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<BuffParams>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim());
				}
				BuffParams buffParams = new BuffParams
				{
					v1 = levelInput.value,
					v2 = 0,
					v3 = 0,
					v4 = 0
				};
				BuffProcessor.AddBuffClassID(entitySourceSpaceEntity.creationIndex, entitySourceSpaceEntity.creationIndex, 100099989, 0, 1, 0, isOnce: false, isLoop: false, buffParams, 0, 1);
				output.Call(f);
			}
		});
	}
}
