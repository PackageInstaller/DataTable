using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]播放通用格挡特效", 0)]
[Category("Logic/Buff")]
[Description("向实体添加buff表内预定义的数值buff。\n强度 0 - 小格挡成功表现, 1 - 大格挡成功表现")]
public class AddCommonGuard : FlowNode
{
	private readonly int buffID0 = 10020;

	private readonly int buffID1 = 10021;

	private readonly int buffTime0 = 200;

	private readonly int buffTime1 = 600;

	private int buffID;

	private int buffTime;

	private bool hasOverWriteLogic = true;

	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID", "作用对象");
		AddValueOutput("目标实体ID", "作用对象", () => targetIDInput.value);
		ValueInput<int> casterIDInput = AddValueInput<int>("释放者实体ID", "添加者");
		AddValueOutput("释放者实体ID", "添加者", () => casterIDInput.value);
		ValueInput<int> levelInput = AddValueInput<int>("强度(0弱1强)", "强度");
		AddValueOutput("使用的逻辑BuffID", "buffID", () => buffID);
		ValueInput<SimVar> param1Input = AddValueInput<SimVar>("参数1", "buff参数1");
		ValueInput<SimVar> param2Input = AddValueInput<SimVar>("参数2", "buff参数2");
		ValueInput<SimVar> param3Input = AddValueInput<SimVar>("参数3", "buff参数3");
		ValueInput<SimVar> param4Input = AddValueInput<SimVar>("参数4", "buff参数4");
		FlowOutput output = AddFlowOutput("");
		FlowOutput outputFalse = AddFlowOutput("没有添加");
		AddFlowInput("", delegate(Flow f)
		{
			bool flag = true;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
			if (entityWithEntityID != null)
			{
				switch (levelInput.value)
				{
				case 0:
					buffID = buffID0;
					buffTime = buffTime0;
					break;
				case 1:
					buffID = buffID1;
					buffTime = buffTime1;
					break;
				}
				if (!entityWithEntityID.hasEntityBuff)
				{
					entityWithEntityID.AddEntityBuff(FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<BuffParams>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim());
				}
				int value = casterIDInput.GetValue();
				int value2 = targetIDInput.GetValue();
				BuffProcessor.RemoveBuffClass(value, value2, buffID);
				if (flag)
				{
					BuffParams buffParams = new BuffParams
					{
						v1 = param1Input.value,
						v2 = param2Input.value,
						v3 = param3Input.value,
						v4 = param4Input.value
					};
					if (BuffProcessor.AddBuffClassID(value, value2, buffID, 0, buffTime, 0, isOnce: true, isLoop: false, buffParams, 0, 1) != 0)
					{
						output.Call(f);
					}
					else
					{
						outputFalse.Call(f);
					}
				}
				else
				{
					outputFalse.Call(f);
				}
			}
		});
	}
}
