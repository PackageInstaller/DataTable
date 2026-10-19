using System;
using Bamboo.ImageCenter;
using UnityEngine.UI;

namespace ACT.UI;

public class BookItemLevelVH : BookViewBaseVH
{
	public BookItemLevel bookItemLevel;

	public Slider valueSlider;

	public Action<BookItemLevelVH> Clicked;

	public override void CollectViews()
	{
		base.CollectViews();
		bookItemLevel = root.GetComponent<BookItemLevel>();
	}

	public override bool CanPresentModelType(Type modelType)
	{
		return modelType == typeof(BookItemLevelModel);
	}

	public override void UpdateViews(BookViewBaseModel model, ImageAssetStation station, bool canPlayAnimation)
	{
		base.UpdateViews(model, station, canPlayAnimation);
		if (model is BookItemLevelModel bookItemLevelModel)
		{
			bookItemLevel.Init(model.Id, station, bookItemLevelModel.Unlock, canPlayAnimation);
		}
	}

	public void BindClickAction(Action<BookItemLevelVH> clicked)
	{
		bookItemLevel.btn.OnClick.RemoveAllListeners();
		bookItemLevel.btn.OnClick.AddListener(() =>
		{
			clicked?.Invoke(this);
		});
	}
}
