using MessagePack;
using MessagePack.Formatters;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("战斗按钮UI技能充能动效挂载", 0)]
[Category("Render/UI")]
[Description("战斗按钮UI技能充能动效挂载")]
public class AttackChargingEffect : AttachButtonEffect
{
	private ValueInput<int> _powerInput;

	public Vector2 localPos;

	public Vector2 localScale = Vector2.one;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		IMessagePackFormatter<Vector2> formatter = options.Resolver.GetFormatter<Vector2>();
		localPos = formatter.Deserialize(ref reader, options);
		localScale = formatter.Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		IMessagePackFormatter<Vector2> formatter = options.Resolver.GetFormatter<Vector2>();
		formatter.Serialize(ref writer, localPos, options);
		formatter.Serialize(ref writer, localScale, options);
	}

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_powerInput = AddValueInput<int>("最大值");
	}

	protected override void Invoke(string path, GameObject button)
	{
		if (string.IsNullOrEmpty(path))
		{
			return;
		}
		GameObject gameObject = Asset.Instantiate(path);
		if (null == gameObject)
		{
			Debug.LogError("无法加载按钮特效" + path);
			return;
		}
		gameObject.transform.SetParent(button.transform, worldPositionStays: false);
		gameObject.transform.localPosition = localPos;
		gameObject.transform.localScale = localScale;
		P08AttackButton component = button.GetComponent<P08AttackButton>();
		if (component != null && component.GetButtonUILogic() is P08ButtonUILogic p08ButtonUILogic)
		{
			p08ButtonUILogic.ChargingController = gameObject.GetComponent<EffectLevel>();
			p08ButtonUILogic.ChargingController.InitEffectSourcesCount(_powerInput.value);
		}
	}
}
