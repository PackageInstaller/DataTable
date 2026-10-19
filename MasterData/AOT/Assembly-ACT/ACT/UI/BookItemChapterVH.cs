using System;
using Bamboo.ImageCenter;

namespace ACT.UI;

public class BookItemChapterVH : BookViewBaseVH
{
	public BookItemChapter bookItemChapter;

	public override void CollectViews()
	{
		base.CollectViews();
		bookItemChapter = root.GetComponent<BookItemChapter>();
	}

	public override bool CanPresentModelType(Type modelType)
	{
		return modelType == typeof(BookItemChapterModel);
	}

	public override void UpdateViews(BookViewBaseModel model, ImageAssetStation station, bool canPlayAnimation)
	{
		base.UpdateViews(model, station, canPlayAnimation);
		if (model is BookItemChapterModel bookItemChapterModel)
		{
			bookItemChapter.Init(model.Id, station, bookItemChapterModel.Unlock, canPlayAnimation);
		}
	}
}
