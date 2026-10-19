using ACT.Config;
using ACT.Utility;
using ACT.World;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class ExploreRatioSidebar : MonoBehaviour, ILifeCycleUIComponent
{
	public LargeMapView view;

	public AreaExploreSideGroup areaExploreGroup;

	public SubAreaExploreSideGroup subAreaExploreGroup;

	public Transform root;

	public BetterAnimation betterAnimation;

	public CommonUILifeCycle lifeCycle;

	private MapConfig mapConfig => view.mapConfig;

	public bool IsOperating
	{
		get
		{
			CommonUILifeCycle commonUILifeCycle = lifeCycle;
			return commonUILifeCycle == CommonUILifeCycle.Opening || commonUILifeCycle == CommonUILifeCycle.Closing;
		}
	}

	public bool IsOpening => lifeCycle == CommonUILifeCycle.Opening;

	public bool IsClosing => lifeCycle == CommonUILifeCycle.Closing;

	public bool IsNormal => lifeCycle == CommonUILifeCycle.Normal;

	public bool IsHidden => lifeCycle == CommonUILifeCycle.Hidden;

	public bool IsAreaType => areaExploreGroup.gameObject.activeSelf;

	public void Show(AreaTabType areaTabType)
	{
		if (IsHidden)
		{
			if (areaTabType == AreaTabType.Area)
			{
				areaExploreGroup.gameObject.SetActive(value: true);
				subAreaExploreGroup.gameObject.SetActive(value: false);
				areaExploreGroup.Init(view.CurShowArea, view.Station);
			}
			else
			{
				areaExploreGroup.gameObject.SetActive(value: false);
				subAreaExploreGroup.gameObject.SetActive(value: true);
				subAreaExploreGroup.Init(view.CurShowArea, Singleton<GameManager>.instance.worldManager.ActiveAreaId, view.Station);
			}
			PlayShowAnimation();
		}
	}

	public void ToShowArea()
	{
		UnInit();
		areaExploreGroup.gameObject.SetActive(value: true);
		subAreaExploreGroup.gameObject.SetActive(value: false);
		areaExploreGroup.Init(view.CurShowArea, view.Station);
	}

	public void ToShowSubArea(int mapArea, int areaId)
	{
		UnInit();
		areaExploreGroup.gameObject.SetActive(value: false);
		subAreaExploreGroup.gameObject.SetActive(value: true);
		subAreaExploreGroup.Init((ACT.World.MapArea)mapArea, areaId, view.Station);
	}

	public void Show()
	{
	}

	public void PlayShowAnimation()
	{
		betterAnimation.GetSequence("Show").OnPlay((AnimationBuilder _) =>
		{
			gameObject.SetActive(value: true);
			lifeCycle = CommonUILifeCycle.Opening;
		}).OnComplete((AnimationBuilder _) =>
		{
			lifeCycle = CommonUILifeCycle.Normal;
		})
			.Play();
	}

	public void Hide()
	{
		if (IsNormal)
		{
			PlayHideAnimation();
		}
	}

	public void PlayHideAnimation()
	{
		betterAnimation.GetSequence("Hide").OnPlay((AnimationBuilder _) =>
		{
			lifeCycle = CommonUILifeCycle.Closing;
		}).OnComplete((AnimationBuilder _) =>
		{
			lifeCycle = CommonUILifeCycle.Hidden;
			UnInit();
			gameObject.SetActive(value: false);
		})
			.Play();
	}

	public void HideImmediately()
	{
		UnInit();
		gameObject.SetActive(value: false);
		lifeCycle = CommonUILifeCycle.Hidden;
	}

	void ILifeCycleUIComponent.ShowStart()
	{
		lifeCycle = CommonUILifeCycle.Opening;
	}

	void ILifeCycleUIComponent.ShowEnd()
	{
		lifeCycle = CommonUILifeCycle.Normal;
	}

	void ILifeCycleUIComponent.HideStart()
	{
		lifeCycle = CommonUILifeCycle.Closing;
	}

	void ILifeCycleUIComponent.HideEnd()
	{
		lifeCycle = CommonUILifeCycle.Hidden;
		UnInit();
		gameObject.SetActive(value: false);
	}

	private void UnInit()
	{
		areaExploreGroup.UnInit();
		subAreaExploreGroup.UnInit();
	}
}
