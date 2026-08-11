using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RollingView : UGuiView
{
	[SerializeField]
	private LoopListView2 pointList;

	[SerializeField]
	private Image img;

	[SerializeField]
	private RectTransform imgRect;

	[SerializeField]
	private float slidingDistance = 10f;

	[SerializeField]
	private Vector2 areaX = new Vector2(0f, 0f);

	[SerializeField]
	private Vector2 areaY = new Vector2(0f, 0f);

	[SerializeField]
	private bool AutoRolling;

	[SerializeField]
	private float DurationTime = 1f;

	private RollingViewModel viewModel;

	private Vector2 touchFirst = Vector2.zero;

	private Vector2 touchFinal = Vector2.zero;

	private string imgPath = "";

	private List<GameObject> objList = new List<GameObject>();

	private float areaX1;

	private float areaX2;

	private float areaY1;

	private float areaY2;

	public void Init(RollingViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<RollingView, RollingViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((RollingView v) => v.RefreshImg).To((RollingViewModel vm) => vm.RefreshImgRequest);
		bindingSet.Build();
		Vector3 lossyScale = RectTransform.lossyScale;
		areaX1 = areaX[0] * lossyScale.x;
		areaX2 = areaX[1] * lossyScale.x;
		areaY1 = areaY[0] * lossyScale.y;
		areaY2 = areaY[1] * lossyScale.y;
		if (viewModel.LoadType == 1)
		{
			RefreshImg();
		}
		else if (viewModel.LoadType == 2)
		{
			LoadObj();
		}
		if (pointList != null)
		{
			pointList.InitListView(viewModel.PointList.Count, OnGetPointItemByIndex);
		}
		if (AutoRolling)
		{
			viewModel.SetConfig(DurationTime);
			viewModel.StartTimer();
		}
	}

	private async void LoadObj()
	{
		if (imgRect == null)
		{
			return;
		}
		foreach (string image in viewModel.ImageList)
		{
			string uIItemAsset = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + image);
			GameObject gameObject = await InstantiateAsync(uIItemAsset, imgRect);
			if (!(gameObject == null))
			{
				GameObject gameObject2 = gameObject;
				gameObject2.SetActive(value: false);
				gameObject2.transform.SetLocalScaleX(viewModel.Scale);
				gameObject2.transform.SetLocalScaleY(viewModel.Scale);
				objList.Add(gameObject2);
			}
		}
		if (objList.Count > 0)
		{
			objList[0].SetActive(value: true);
		}
	}

	private async void RefreshImg(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel == null || viewModel.ImagePath.Equals(""))
		{
			return;
		}
		if (viewModel.LoadType == 1)
		{
			if (!(img == null))
			{
				string packageName = "DefaultPackage";
				if (viewModel.Type == 1)
				{
					imgPath = AssetUtility.GetUISprite("WeaponIcon/" + viewModel.ImagePath + ".png");
				}
				else if (viewModel.Type == 2)
				{
					imgPath = AssetUtility.GetStoryImageSprite(viewModel.ImagePath + ".png");
					packageName = "Story";
				}
				else if (viewModel.Type == 3)
				{
					imgPath = AssetUtility.GetStoryImageSprite(viewModel.ImagePath + ".png");
					packageName = "Story";
				}
				Image image = img;
				image.sprite = await LoadSpriteAsync(imgPath, packageName);
			}
		}
		else
		{
			if (viewModel.LoadType != 2)
			{
				return;
			}
			foreach (GameObject obj in objList)
			{
				obj.SetActive(value: false);
			}
			if (objList.Count >= viewModel.Index + 1)
			{
				objList[viewModel.Index].SetActive(value: true);
			}
		}
	}

	private void OnGUI()
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Invalid comparison between Unknown and I4
		if ((int)Event.current.type == 0)
		{
			if (Event.current.mousePosition.x < areaX1 || Event.current.mousePosition.x > areaX2 || Event.current.mousePosition.y < areaY1 || Event.current.mousePosition.y > areaY2)
			{
				return;
			}
			touchFirst = Event.current.mousePosition;
		}
		if ((int)Event.current.type == 1 && !(touchFirst.x < areaX1) && !(touchFirst.x > areaX2) && !(touchFirst.y < areaY1) && !(touchFirst.y > areaY2))
		{
			touchFinal = Event.current.mousePosition;
			Check();
		}
	}

	private void Check()
	{
		if (viewModel.CanSlider)
		{
			float x = (touchFinal - touchFirst).x;
			if (x > 0f && Math.Abs(x) >= slidingDistance)
			{
				viewModel.Left();
			}
			if (x < 0f && Math.Abs(x) >= slidingDistance)
			{
				viewModel.Right();
			}
			touchFirst = new Vector2(0f, 0f);
			touchFinal = new Vector2(0f, 0f);
		}
	}

	private LoopListViewItem2 OnGetPointItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PointList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("Point");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PointList[index]);
			}
			else
			{
				component.RefreshData(viewModel.PointList[index]);
			}
		}
		return loopListViewItem;
	}

	protected override void OnDestroy()
	{
		if (objList != null && objList.Count > 0)
		{
			for (int i = 0; i < objList.Count; i++)
			{
				UnityEngine.Object.Destroy(objList[i]);
			}
			objList.Clear();
		}
		base.OnDestroy();
	}
}
