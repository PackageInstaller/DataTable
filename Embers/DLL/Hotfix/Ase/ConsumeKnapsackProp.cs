using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("消耗背包道具", 0)]
[Description("消耗背包中的某个道具。")]
[Category("✫ DragonLost/Interactive")]
public class ConsumeKnapsackProp : ActionTaskBase
{
	[Name("道具ID", 0)]
	[Description("道具ID。")]
	public BBParameter<int> PropId;

	protected override void OnExecute()
	{
		base.OnExecute();
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(PropId.value);
		if (Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().CheckEnough(new PropData(dataRow)))
		{
			C2H_ItemUserRequest c2H_ItemUserRequest = C2H_ItemUserRequest.Create();
			c2H_ItemUserRequest.ItemId = PropId.value;
			c2H_ItemUserRequest.Count = 1;
			Singleton<NetworkSystem>.Instance.Call<GetServerTimeResponse>(c2H_ItemUserRequest);
		}
		OnActionFinish();
	}
}
