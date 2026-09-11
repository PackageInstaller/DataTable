using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("复活界面", 0)]
[Category("Render/UI")]
[Description("复活界面, 目前是直接用节点调用的, \n 也可以改成结算界面那样用lua去调用\n 如果以后有复杂逻辑的话, 比如 金币不够跳到钻石换金币界面")]
public class ResurrectUI : FlowNode
{
	public string prefabPath = "Widget/Common/Pop/ResurrectionpopupUI.prefab";

	public string trueButtonPath = "CompopUI02/panel/btncontent/btn_yes";

	public string falseButtonPath = "CompopUI02/panel/btncontent/btn_no";

	public string contentTextPath = "CompopUI02/panel/content/tiptext";

	public string currentCoinPath = "CompopUI02/root/currencyList/currencyItem/root/Text";

	public string contentFormat = "是否消耗 <color=#FF9500>{0}艾因索菲币</color>复活？";

	public string currentCoinFormat = "{0}";

	public int tipsCode = 2100;

	public const int CONTENT_FORMAT_ID = 106;

	private GameObject go;

	private int entityId;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		prefabPath = reader.ReadString();
		trueButtonPath = reader.ReadString();
		falseButtonPath = reader.ReadString();
		contentTextPath = reader.ReadString();
		currentCoinPath = reader.ReadString();
		contentFormat = reader.ReadString();
		currentCoinFormat = reader.ReadString();
		tipsCode = reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(prefabPath);
		writer.Write(trueButtonPath);
		writer.Write(falseButtonPath);
		writer.Write(contentTextPath);
		writer.Write(currentCoinPath);
		writer.Write(contentFormat);
		writer.Write(currentCoinFormat);
		writer.Write(tipsCode);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> coinNumberInput = AddValueInput<int>("剩余金币数量");
		ValueInput<int> coinConsumeInput = AddValueInput<int>("每次复活消耗金币数量");
		AddValueInput<int>("已经复活了几次");
		ValueInput<int> idFormatInput = AddValueInput<int>("提示路径模板");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityId);
		FlowOutput output = AddFlowOutput("");
		FlowOutput trueOut = AddFlowOutput("选择复活");
		FlowOutput falseOut = AddFlowOutput("不复活");
		AddValueOutput("UI界面", () => go);
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				falseOut.Call(f);
			}
			else
			{
				int value = coinConsumeInput.value;
				int value2 = coinNumberInput.value;
				entityId = entityIDInput.value;
				if (battleScene.resurrectImmediately)
				{
					if (value >= 0 && value2 >= 0 && value2 >= value)
					{
						f.Call(trueOut);
					}
					else
					{
						f.Call(falseOut);
					}
				}
				else
				{
					if (go == null)
					{
						go = Asset.InstantiateWithoutCache(prefabPath, battleScene.battlePanelGameObject.transform.parent);
					}
					else
					{
						go.SetActive(value: true);
					}
					Button buttonTrue = go.transform.Find(trueButtonPath).GetComponent<Button>();
					Button buttonFalse = go.transform.Find(falseButtonPath).GetComponent<Button>();
					Text component = go.transform.Find(contentTextPath).GetComponent<Text>();
					Text component2 = go.transform.Find(currentCoinPath).GetComponent<Text>();
					if (idFormatInput.value != 0)
					{
						component.text = string.Format(WorldStateManager.GetTipsContent(idFormatInput.value), value);
					}
					else
					{
						component.text = string.Format(WorldStateManager.GetTipsContent(106), value);
					}
					component2.text = string.Format(currentCoinFormat, value2);
					f.Call(output);
					if (value >= 0 && value2 >= 0 && value2 >= value)
					{
						buttonTrue.onClick.AddListener(delegate
						{
							f.Call(trueOut);
							buttonTrue.onClick.RemoveAllListeners();
							buttonFalse.onClick.RemoveAllListeners();
							go.SetActive(value: false);
						});
					}
					else
					{
						buttonTrue.onClick.AddListener(delegate
						{
							LuaHelper.CallFunction("ShowTips", tipsCode);
						});
					}
					buttonFalse.onClick.AddListener(delegate
					{
						f.Call(falseOut);
						buttonTrue.onClick.RemoveAllListeners();
						buttonFalse.onClick.RemoveAllListeners();
						go.SetActive(value: false);
					});
				}
			}
		});
	}
}
