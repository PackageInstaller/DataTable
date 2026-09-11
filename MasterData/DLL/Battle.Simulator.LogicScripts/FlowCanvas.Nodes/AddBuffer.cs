using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加Buff(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("向实体添加纯逻辑buff。\n不可使用本节点添加属于数值BuffClass的buff\n不可使用本节点添加buff表内的数值buff\n\n勾选【是否覆盖】时，若实体身上已存在相同class的buff，会先将该buff移除，之后再添加一次buff\n（会先走原有buff的【移除】，再走一次新buff的【添加】，各参数直接覆盖，buff生命周期重新开始）\n\n未勾选【是否覆盖】时，若实体身上已存在相同class的buff，添加时不会将原有buff移除。添加后，实体身上会存在两个相同class的buff，二者独立运行，互不干扰")]
[ExposeAsDefinition]
public class AddBuffer : FlowControlNode
{
	private int mBuffID;

	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("false");
		ValueInput<int> p1 = AddValueInput<int>("释放者实体ID", "添加者");
		ValueInput<int> p2 = AddValueInput<int>("目标实体ID", "作用对象");
		ValueInput<int> p3 = AddValueInput<int>("类型(处理逻辑)ID", "buff类型");
		ValueInput<int> p4 = AddValueInput<int>("延迟时长(毫秒)", "buff延迟触发");
		ValueInput<int> p5 = AddValueInput<int>("存活时长(毫秒)", "buff存活时间");
		ValueInput<int> p6 = AddValueInput<int>("触发间隔时长(毫秒)", "buff触发间隔");
		ValueInput<bool> p7 = AddValueInput<bool>("永不触发", "buff单次触发");
		ValueInput<bool> p13 = AddValueInput<bool>("永久存在", "buff永久存在");
		ValueInput<bool> p14 = AddValueInput<bool>("是否覆盖", "buff是否会覆盖同类型buff");
		ValueInput<SimVar> p15 = AddValueInput<SimVar>("参数1", "buff参数1");
		ValueInput<SimVar> p16 = AddValueInput<SimVar>("参数2", "buff参数2");
		ValueInput<SimVar> p17 = AddValueInput<SimVar>("参数3", "buff参数3");
		ValueInput<SimVar> p18 = AddValueInput<SimVar>("参数4", "buff参数4");
		AddFlowInput(" ", delegate(Flow f)
		{
			if (Invoke(p1.GetValue(), p2.GetValue(), p3.GetValue(), p4.GetValue(), p5.GetValue(), p6.GetValue(), p7.GetValue(), p13.GetValue(), p14.GetValue(), p15.GetValue(), p16.GetValue(), p17.GetValue(), p18.GetValue()))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("创建ID", "buffID: ", () => mBuffID);
	}

	private bool Invoke(int casterID, int targetID, int buffClass, int buffDelay, int buffAliveTime, int buffTick, bool isOnce, bool isLoop, bool isOverride, SimVar param1, SimVar param2, SimVar param3, SimVar param4)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(casterID);
		if (entityWithEntityID == null)
		{
			return false;
		}
		SimEntity simEntity = null;
		simEntity = ((targetID != casterID) ? base.mSimContext.GetEntityWithEntityID(targetID) : entityWithEntityID);
		if (simEntity == null)
		{
			return false;
		}
		if (!simEntity.hasEntityBuff)
		{
			simEntity.AddEntityBuff(FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<BuffParams>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim(), FrameListPool<int>.Claim());
		}
		if (isOverride)
		{
			BuffProcessor.RemoveBuffClass(casterID, targetID, buffClass);
		}
		BuffParams buffParams = new BuffParams
		{
			v1 = param1,
			v2 = param2,
			v3 = param3,
			v4 = param4
		};
		mBuffID = BuffProcessor.AddBuffClassID(casterID, targetID, buffClass, buffDelay, buffAliveTime, buffTick, isOnce, isLoop, buffParams, 0, 1);
		return true;
	}
}
