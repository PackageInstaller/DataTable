using ACT.Model;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class ImageWidget : GuideWidget
{
	[SerializeReference]
	private BImage image;

	public override void Init(GuideStepData stepData)
	{
		_ = stepData is ImageStepData;
	}
}
