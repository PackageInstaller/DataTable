using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建增益掉落(逻辑)", 0)]
[Category("Logic/增益掉落")]
[Description("创建增益掉落,增益掉落的ID为【BuffItem】表的ID,原理是让环境实体创建抛掷物,该抛掷物逻辑在 BattleLogicLaucher 的 BuffItem 图中")]
public class CreateBuffItem : FlowControlNode
{
	private ValueInput<int> m_buffItemIDInput;

	private ValueInput<Int3> m_positionInput;

	private ValueInput<Int3> m_forwardInput;

	private ValueInput<bool> m_isRandomInput;

	private ValueInput<int> m_insideRadiusInput;

	private ValueInput<int> m_outsideRadiusInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_buffItemIDInput = AddValueInput<int>("增益掉落ID", "battleItemID");
		m_positionInput = AddValueInput<Int3>("中心位置", "position");
		m_forwardInput = AddValueInput<Int3>("朝向", "forward").SetDefaultAndSerializedValue(Int3.forward);
		m_isRandomInput = AddValueInput<bool>("随机位置", "isRandom").SetDefaultAndSerializedValue(v: true);
		m_insideRadiusInput = AddValueInput<int>("掉落内半径(毫秒)", "insideRadius").SetDefaultAndSerializedValue(2000);
		m_outsideRadiusInput = AddValueInput<int>("掉落外半径(毫秒)", "outsideRadius").SetDefaultAndSerializedValue(4000);
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!base.mSimContext.hasEntitySourceSpace)
			{
				m_error.Call(f);
			}
			else
			{
				SimEntity entitySourceSpaceEntity = base.mSimContext.entitySourceSpaceEntity;
				int mAttributeID = entitySourceSpaceEntity.entityBlackboard.var.mAttributeID;
				BuffItem config = ConfigHelper.GetInstance().GetConfig<BuffItem>(m_buffItemIDInput.GetValue());
				if (config == null)
				{
					m_error.Call(f);
				}
				else
				{
					m_positionInput.GetValue();
					Int obj = DRandom.Random(360u) * 1000;
					obj = IntMath.AngleOfVector(m_forwardInput.GetValue()) + obj;
					Int3 @int = IntMath.VectorOfAngle(obj);
					int value = m_insideRadiusInput.GetValue();
					int value2 = m_outsideRadiusInput.GetValue();
					int newMagn = value;
					if (value2 > value)
					{
						newMagn = (int)DRandom.Random((uint)(value2 - value)) + value;
					}
					Int3 end = m_positionInput.GetValue() + @int.NormalizeTo(newMagn);
					end = CommonProcessor.GetPositionInGraphWithoutTangentMove(m_positionInput.GetValue(), end);
					ThrownProcessor.SpawnThrown(base.mSimContext, entitySourceSpaceEntity.creationIndex, 0, 0, end, @int.NormalizeTo(1000), config.TimelineId, useCommon: true, entitySourceSpaceEntity.creationIndex, config.TimelineId, mAttributeID, out var thrownState);
					thrownState.mDontMovement = true;
					thrownState.mBuffItemID = m_buffItemIDInput.value;
				}
			}
		});
	}
}
