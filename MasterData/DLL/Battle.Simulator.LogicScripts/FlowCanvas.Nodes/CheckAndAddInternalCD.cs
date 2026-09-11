using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("检查并增加内置CD或计时器(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("判断指定实体当前是否拥有指定编号的内置CD或计时器，只要仍在持续时间内就算拥有，如果有走【内置CD中】，没有则添加并走【无CD并添加成功】")]
public class CheckAndAddInternalCD : FlowControlNodeOfLogic
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _timeNameInput;

	private ValueInput<int> _duringTimeInput;

	private ValueInput<int> _delayTimeInput;

	private ValueInput<int> _intervalTimeInput;

	private FlowOutput _hasOut;

	private FlowOutput _addedOut;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_timeNameInput = AddValueInput<int>("编号(=计时器编号)", "key");
		_duringTimeInput = AddValueInput<int>("存在时间", "duringTime");
		_delayTimeInput = AddValueInput<int>("延迟触发时间", "delayTime");
		_intervalTimeInput = AddValueInput<int>("触发间隔", "intervalTime");
		_hasOut = AddFlowOutput("内置CD中", "true");
		_addedOut = AddFlowOutput("无CD并添加成功", "false");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				_errorOut.Call(f);
			}
			else if (entityWithEntityID.hasEntityTimer && entityWithEntityID.entityTimer.GetFirstIDByName(_timeNameInput.GetValue()) != -1)
			{
				_hasOut.Call(f);
			}
			else if (!BuffProcessor.TryAddTimer(_entityIDInput.value, _timeNameInput.value, _delayTimeInput.value, _duringTimeInput.value, _intervalTimeInput.value))
			{
				_errorOut.Call(f);
			}
			else
			{
				_addedOut.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.GetValue());
	}
}
