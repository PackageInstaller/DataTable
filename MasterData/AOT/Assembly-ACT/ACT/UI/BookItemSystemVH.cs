using System;
using Bamboo.ImageCenter;
using UnityEngine.UI;

namespace ACT.UI;

public class BookItemSystemVH : BookViewBaseVH
{
	public BookItemSystem bookItemSystem;

	public Slider valueSlider;

	public override void CollectViews()
	{
		base.CollectViews();
		bookItemSystem = root.GetComponent<BookItemSystem>();
	}

	public override bool CanPresentModelType(Type modelType)
	{
		return modelType == typeof(BookItemSystemModel);
	}

	public override void UpdateViews(BookViewBaseModel model, ImageAssetStation station, bool canPlayAnimation)
	{
		base.UpdateViews(model, station, canPlayAnimation);
		if (model is BookItemSystemModel bookItemSystemModel)
		{
			bookItemSystem.Init(bookItemSystemModel.Id, station, bookItemSystemModel.Unlock, canPlayAnimation);
		}
	}

	public void BindClickAction(Action<BookItemSystemVH> clicked)
	{
		bookItemSystem.btn.OnClick.RemoveAllListeners();
		bookItemSystem.btn.OnClick.AddListener(() =>
		{
			clicked?.Invoke(this);
		});
	}

	public override void SetSelect(bool isSelect)
	{
		base.SetSelect(isSelect);
		bookItemSystem.SetSelect(isSelect);
	}
}
