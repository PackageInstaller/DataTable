using ACT.Game;
using ACT.Model;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class VideoWidget : GuideWidget
{
	[SerializeReference]
	private VideoPlayerRawImage videoImage;

	public override void Init(GuideStepData stepData)
	{
		if (stepData is VideoStepData videoStepData)
		{
			G.service.TriggerTutorial(videoStepData.GuideTableId, null);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
			{
				tutorialId = videoStepData.GuideTableId
			});
		}
	}
}
