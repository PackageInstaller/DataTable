using System;
using Bamboo.ImageCenter;

namespace ACT.UI;

public class BookEmptyVH : BookViewBaseVH
{
	public override void CollectViews()
	{
		base.CollectViews();
	}

	public override bool CanPresentModelType(Type modelType)
	{
		return modelType == typeof(BookEmptyModel);
	}

	public override void UpdateViews(BookViewBaseModel model, ImageAssetStation station, bool canPlayAnimation)
	{
		base.UpdateViews(model, station, canPlayAnimation);
	}
}
