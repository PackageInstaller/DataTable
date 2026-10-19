using System;
using Bamboo.ImageCenter;

namespace ACT.UI;

public class BookItemMissionVH : BookViewBaseVH
{
	public BookItemMission bookItemMission;

	public override void CollectViews()
	{
		base.CollectViews();
		bookItemMission = root.GetComponent<BookItemMission>();
	}

	public override bool CanPresentModelType(Type modelType)
	{
		return modelType == typeof(BookItemMissionModel);
	}

	public override void UpdateViews(BookViewBaseModel model, ImageAssetStation station, bool canPlayAnimation)
	{
		base.UpdateViews(model, station, canPlayAnimation);
		if (model is BookItemMissionModel bookItemMissionModel)
		{
			bookItemMission.Init(bookItemMissionModel.Id, station, bookItemMissionModel.Unlock, bookItemMissionModel.InProgress, canPlayAnimation);
		}
	}

	public void BindClickAction(Action<BookItemMissionVH> clicked)
	{
		bookItemMission.btn.OnClick.RemoveAllListeners();
		bookItemMission.btn.OnClick.AddListener(() =>
		{
			clicked?.Invoke(this);
		});
	}

	public override void SetSelect(bool isSelect)
	{
		base.SetSelect(isSelect);
		bookItemMission.SetSelect(isSelect);
	}
}
