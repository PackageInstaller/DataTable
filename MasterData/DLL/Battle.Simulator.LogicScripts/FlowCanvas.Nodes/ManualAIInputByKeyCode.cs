using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("人工AI输入事件(KeyCode)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("向AI发送操作指令,希望干预AI触发的事件")]
public class ManualAIInputByKeyCode : ManualAIInputEventBase
{
	private ValueInput<int> m_keyCodeInput;

	protected override void AddCustomValueInput()
	{
		m_keyCodeInput = AddValueInput<int>("KeyCode", "keyCode");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(bool disableInCD, int entityID, int keyCode, out SimEntity simEntity)
	{
		if (!base.ConditionFunc(disableInCD, entityID, keyCode, out simEntity))
		{
			return false;
		}
		if (m_keyCodeInput.value != -1 && m_keyCodeInput.GetValue() != keyCode)
		{
			return false;
		}
		return true;
	}
}
