using System.Collections.Generic;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

public abstract class DoUniqueSkillEventBase : EventNode, IUpdatable
{
	[Name("渲染层需要延迟", 0)]
	[GatherPortsCallback]
	[DelayedField]
	public bool m_needDelay;

	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	protected ValueInput<bool> _isRenderInput;

	private int _step;

	protected int _casterID;

	private int _targetID;

	protected bool _isCooperating;

	private int _param;

	protected FlowOutput _out;

	protected UniqueSkillEvent _event;

	protected int _delayTime = -1;

	private FlowOutput _delayOut;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		m_needDelay = reader.ReadBoolean();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(m_needDelay);
	}

	protected override void RegisterPorts()
	{
		AddBaseFlowOutput();
		AddBaseValueInput();
		AddCustomValueInput();
		AddBaseValueOutput();
		AddCustomValueOutput();
	}

	private void AddBaseFlowOutput()
	{
		_out = AddFlowOutput("输出", "output");
		if (m_needDelay)
		{
			_delayOut = AddFlowOutput("延迟一帧调用", "delayOut");
		}
	}

	private void AddBaseValueInput()
	{
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	protected abstract void AddCustomValueInput();

	private void AddBaseValueOutput()
	{
		AddValueOutput("阶段", "step", () => _step);
		AddValueOutput("释放者ID", "entityID1", () => _casterID);
		AddValueOutput("目标ID", "targetID", () => _targetID);
		AddValueOutput("是连携", "isCooperating", () => _isCooperating);
		AddValueOutput("参数", "param", () => _param);
	}

	protected abstract void AddCustomValueOutput();

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<UniqueSkillEvent>(EvtHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<UniqueSkillEvent>(EvtHandler);
		}
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		_delayTime = -1;
	}

	protected abstract bool IsCurrentCategory(UniqueSkillEvent pEvt);

	protected abstract bool IsCurrentStep(UniqueSkillEvent pEvt);

	protected virtual void EvtHandler(UniqueSkillEvent pEvt)
	{
		if (IsCurrentCategory(pEvt) && IsCurrentStep(pEvt))
		{
			_event = pEvt;
			if (m_needDelay && _isRenderInput.value)
			{
				_delayTime = 1;
			}
			Flow f = CreateFlow();
			_out.Call(f);
		}
	}

	protected Flow CreateFlow()
	{
		Flow result = new Flow
		{
			returnData = _returnData
		};
		_step = _event.mStep;
		_casterID = _event.mCasterID;
		_targetID = _event.mTargetID;
		_isCooperating = _event.mIsCooperating;
		_param = _event.mParam;
		return result;
	}

	public void Update()
	{
		if (_delayTime >= 0)
		{
			if (_delayTime > 0)
			{
				_delayTime = 0;
				return;
			}
			_delayTime = -1;
			Flow f = CreateFlow();
			_delayOut.Call(f);
		}
	}
}
