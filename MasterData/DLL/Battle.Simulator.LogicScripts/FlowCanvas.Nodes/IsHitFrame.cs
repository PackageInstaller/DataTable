using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断当前帧是否是判定帧", 0)]
[Category("Logic/Abilities")]
[Description("判断当前帧是否是判定帧")]
[ExposeAsDefinition]
public class IsHitFrame : FlowControlNode
{
	private int mAblityID;

	private int mHitIndex;

	private bool mIsLastHit;

	private int mCasterID;

	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("false");
		ValueInput<int> p1 = AddValueInput<int>("释放者");
		ValueInput<int> p2 = AddValueInput<int>("技能ID");
		ValueInput<int> p3 = AddValueInput<int>("帧号");
		AddFlowInput(" ", delegate(Flow f)
		{
			if (Invoke(p1.value, p2.value, p3.value))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("释放者: ", () => mCasterID);
		AddValueOutput("技能ID: ", () => mAblityID);
		AddValueOutput("第几次判定：", () => mHitIndex);
		AddValueOutput("是否是最后一判定：", () => mIsLastHit);
	}

	private bool Invoke(int casterID, int ablityID, int logicTime)
	{
		mAblityID = ablityID;
		mCasterID = casterID;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(ablityID);
		if (config != null)
		{
			IEnumerator<HitCheckInfo> enumerator = config.HitTimeList.GetEnumerator();
			int num = 0;
			while (enumerator.MoveNext())
			{
				if (logicTime >= enumerator.Current.Start && logicTime <= enumerator.Current.Start + enumerator.Current.Duration)
				{
					mIsLastHit = num >= config.HitTimeList.Count - 1;
					mHitIndex = num + 1;
					return true;
				}
				num++;
			}
		}
		return false;
	}
}
