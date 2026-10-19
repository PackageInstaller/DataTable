using ACT.Battle;
using ACT.Battle.Configs;
using ACT.UI;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class OpenPropsSubmissionView : InteractAction
{
	public bool readPropsSubmissionData;

	public int submissionId;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		int num = 0;
		if (readPropsSubmissionData)
		{
			CompStateObject compStateObject = stateObjectBase.entity.GetCompStateObject();
			if (compStateObject != null && compStateObject.StateWorldAssetData is PropsSubmissionData propsSubmissionData)
			{
				num = propsSubmissionData.missionId;
			}
		}
		else
		{
			num = submissionId;
		}
		if (num != 0)
		{
			UIOpenResult openUIResult = Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_PROPSSUBMISSON, new PropsSubmissonViewData
			{
				id = num
			});
			return Singleton<NewUIManager>.instance.WaitUICloseAsync(openUIResult);
		}
		return UniTask.CompletedTask;
	}
}
