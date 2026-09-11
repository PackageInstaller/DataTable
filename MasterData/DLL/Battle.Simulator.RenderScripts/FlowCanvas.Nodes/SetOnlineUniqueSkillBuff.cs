using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("奥义增幅", 0)]
[Category("Render")]
[Description("奥义增幅")]
public class SetOnlineUniqueSkillBuff : FlowNode
{
	private Image imageBuffTime;

	private Image imageQTETime;

	private int qteTime;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		imageBuffTime = null;
		imageQTETime = null;
		qteTime = 0;
	}

	protected override void RegisterPorts()
	{
		FlowOutput flowOut = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<string> pathInput = AddValueInput<string>("GameObject路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/BattleButtons/QTEButton/Image");
		ValueInput<string> nameInput = AddValueInput<string>("Qte时间路径").SetDefaultAndSerializedValue("Image/Image");
		AddFlowInput("初始化", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				abnormalOut.Call(f);
				Debug.LogError("bs.battlePanelGameObject");
			}
			else
			{
				if (imageBuffTime == null || imageQTETime == null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
					if (transform == null)
					{
						abnormalOut.Call(f);
						return;
					}
					imageBuffTime = transform.GetComponent<Image>();
					imageBuffTime.enabled = false;
					transform = transform.Find(nameInput.value);
					if (transform == null)
					{
						abnormalOut.Call(f);
						return;
					}
					imageQTETime = transform.GetComponent<Image>();
					imageQTETime.enabled = false;
				}
				flowOut.Call(f);
			}
		});
		ValueInput<Color32> colorInput = AddValueInput<Color32>("颜色");
		ValueInput<Color32> color2Input = AddValueInput<Color32>("颜色2");
		ValueInput<int> qteTimeInput = AddValueInput<int>("响应时长");
		AddFlowInput("设置响应时长", delegate(Flow f)
		{
			qteTime = qteTimeInput.value;
			flowOut.Call(f);
		});
		ValueInput<int> curTimeInput = AddValueInput<int>("剩余时长");
		ValueInput<int> maxTimeInput = AddValueInput<int>("总时长");
		AddFlowInput("更新buff时长", delegate(Flow f)
		{
			if (imageQTETime == null || imageBuffTime == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				imageBuffTime.enabled = true;
				imageQTETime.enabled = true;
				imageQTETime.transform.parent.localRotation = Quaternion.identity;
				float num = 1f - (float)qteTime / (float)maxTimeInput.value;
				imageQTETime.transform.parent.Rotate(Vector3.forward, num * 360f);
				imageBuffTime.fillAmount = (float)curTimeInput.value / (float)maxTimeInput.value;
				if (imageBuffTime.fillAmount > num)
				{
					imageBuffTime.color = colorInput.value;
				}
				else
				{
					imageBuffTime.color = color2Input.value;
				}
				flowOut.Call(f);
			}
		});
		AddFlowInput("隐藏", delegate(Flow f)
		{
			if (imageQTETime == null || imageBuffTime == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				imageBuffTime.enabled = false;
				imageQTETime.enabled = false;
				flowOut.Call(f);
			}
		});
	}
}
