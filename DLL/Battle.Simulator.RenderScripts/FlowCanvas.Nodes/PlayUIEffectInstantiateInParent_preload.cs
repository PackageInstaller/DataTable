using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放Boss出场UI特效_preload(过时)", 0)]
[Category("Render/特效")]
[Description("创建特效,节点填写路径\n例如:Asset/ABResources/Effect/Scene/fx_chuchang_01,只要使用:Effect/Scene/fx_chuchang_01\n时长单位:秒\n这个会直接出生在parent下面")]
public class PlayUIEffectInstantiateInParent_preload : EffectCreateBaseNode
{
	private GameObject panel;

	public string mainNamePath = "Designer/name/name_text";

	public string typeNamePath = "Designer/name/type_text";

	public string factionPath = "Words/content/text";

	public string factionFormat = "所属势力: {0}";

	public string featuresPath = "Words/content/text (1)";

	public string featuresFormat = "特性: {0}";

	public string attack_typePath = "Words/content/text (2)";

	public string attack_typeFormat = "攻击方式: {0}";

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(mainNamePath);
		writer.Write(typeNamePath);
		writer.Write(factionPath);
		writer.Write(factionFormat);
		writer.Write(featuresPath);
		writer.Write(featuresFormat);
		writer.Write(attack_typePath);
		writer.Write(attack_typeFormat);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		mainNamePath = reader.ReadString();
		typeNamePath = reader.ReadString();
		factionPath = reader.ReadString();
		factionFormat = reader.ReadString();
		featuresPath = reader.ReadString();
		featuresFormat = reader.ReadString();
		attack_typePath = reader.ReadString();
		attack_typeFormat = reader.ReadString();
	}

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		FlowOutput output = AddFlowOutput("out");
		AddValueInput<int>("ID");
		AddFlowInput("", delegate(Flow f)
		{
			f.Call(output);
		});
	}
}
