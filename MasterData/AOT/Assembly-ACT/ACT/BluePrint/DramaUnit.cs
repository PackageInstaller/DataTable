using System.Collections.Generic;
using ACT.Core;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;
using Unity.VisualScripting;

namespace ACT.BluePrint;

[UnitCategory("ACT")]
public class DramaUnit : Unit
{
	[DoNotSerialize]
	public ControlInput input;

	[DoNotSerialize]
	public ControlOutput exit;

	[DoNotSerialize]
	public ValueInput dramaIds;

	[DoNotSerialize]
	private GraphReference graphReference;

	protected override void Definition()
	{
		input = ControlInput("input", (Flow x) => Enter(x));
		exit = ControlOutput("exit");
		dramaIds = ValueInput<List<int>>("dramaIds", null);
		Succession(input, exit);
	}

	private ControlOutput Enter(Flow flow)
	{
		graphReference = flow.stack.ToReference();
		List<int> value = flow.GetValue<List<int>>(dramaIds);
		Drama(value).Forget();
		return null;
	}

	private async UniTaskVoid Drama(List<int> dramaId)
	{
		int key = dramaId[0];
		switch (RuntimeConfigs.data.dramaDatas[key].type)
		{
		case 1:
		case 2:
		case 3:
			AsideManager.instance.BeginAsideBatch(dramaId);
			break;
		case 4:
			Fundamental.Singleton<ConversationManager>.instance.ConversationStart(dramaId[0]);
			await UniTask.WaitUntil(() => Fundamental.Singleton<ConversationManager>.instance.isOver);
			break;
		}
		Flow.New(graphReference).Run(exit);
	}
}
