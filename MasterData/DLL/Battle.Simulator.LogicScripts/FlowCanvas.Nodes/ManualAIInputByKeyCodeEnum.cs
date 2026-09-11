using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("人工AI输入事件(枚举)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("向AI发送操作指令,希望干预AI触发的事件")]
public class ManualAIInputByKeyCodeEnum : ManualAIInputEventBase
{
	private ValueInput<ButtonType> m_keyCodeInput;

	protected override void AddCustomValueInput()
	{
		m_keyCodeInput = AddValueInput<ButtonType>("KeyCode", "keyCode");
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
		if (m_keyCodeInput.GetValue() != (ButtonType)keyCode)
		{
			return false;
		}
		return true;
	}
}
