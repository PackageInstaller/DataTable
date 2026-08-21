using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapAreaListView : UGuiView
{
	[SerializeField]
	private Button btnHide;

	[SerializeField]
	private TabItem areaListToggle;

	[SerializeField]
	private TextMeshProUGUI sectionName;

	[SerializeField]
	private TextMeshProUGUI levelName;

	[SerializeField]
	private ScrollRect sectionRect;

	[SerializeField]
	private VerticalLayoutGroup sectionGroup;

	[SerializeField]
	private ContentSizeFitter sectionContent;

	[SerializeField]
	private MapAreaTabItem sectionItemTpl;

	[SerializeField]
	private GameObject sectionUpArrow;

	[SerializeField]
	private GameObject sectionDownArrow;

	[SerializeField]
	private ScrollRect levelRect;

	[SerializeField]
	private VerticalLayoutGroup levelGroup;

	[SerializeField]
	private ContentSizeFitter levelContent;

	[SerializeField]
	private MapAreaTabItem levelItemTpl;

	[SerializeField]
	private GameObject levelUpArrow;

	[SerializeField]
	private GameObject levelDownArrow;

	[SerializeField]
	private Animator animator;

	[SerializeField]
	private string showAniName = "";

	[SerializeField]
	private string hideAniName = "";

	private GameObjectPool secitonItemPool;

	private GameObjectPool levelItemPool;

	private MapAreaListViewModel _viewModel;

	private float sectionViewportHeight;

	private float sectionItemHeight;

	private int sectionDisplayTabCount;

	private float levelViewportHeight;

	private float levelItemHeight;

	private int levelDisplayTabCount;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<MapAreaListViewModel>(userData);
		BindingSet<MapAreaListView, MapAreaListViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((MapAreaListView v) => ((UGuiView)v).OnVisibleChanged).To((MapAreaListViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind().For((MapAreaListView v) => v.OnWorldDataChanged).To((MapAreaListViewModel vm) => vm.OnWorldDataChanged);
		bindingSet.Bind().For((MapAreaListView v) => v.OnSectionDataChanged).To((MapAreaListViewModel vm) => vm.OnSectionDataChanged);
		bindingSet.Bind().For((MapAreaListView v) => v.UpdateTabItemsTags).To((MapAreaListViewModel vm) => vm.UpdateTabItemsTags);
		bindingSet.Bind<TextMeshProUGUI>(sectionName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapAreaListViewModel vm) => vm.SectionName);
		bindingSet.Bind<TextMeshProUGUI>(levelName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapAreaListViewModel vm) => vm.LevelName);
		bindingSet.Build();
		secitonItemPool = new GameObjectPool(sectionItemTpl.gameObject, sectionRect.content);
		levelItemPool = new GameObjectPool(levelItemTpl.gameObject, levelRect.content);
		InitParams();
		btnHide.onClick.AddListener(Hide);
		areaListToggle.Init(_viewModel.TabToggleItemData);
		sectionRect.onValueChanged.AddListener(OnSectionScrollChanged);
		levelRect.onValueChanged.AddListener(OnLevelScrollChanged);
	}

	private void InitParams()
	{
		sectionViewportHeight = sectionRect.viewport.rect.size.y;
		sectionItemHeight = sectionItemTpl.GetComponent<LayoutElement>().preferredHeight;
		sectionDisplayTabCount = Mathf.FloorToInt((sectionViewportHeight - (float)sectionGroup.padding.top + sectionGroup.spacing) / (sectionItemHeight + sectionGroup.spacing));
		levelViewportHeight = levelRect.viewport.rect.size.y;
		levelItemHeight = levelItemTpl.GetComponent<LayoutElement>().preferredHeight;
		levelDisplayTabCount = Mathf.FloorToInt((levelViewportHeight - (float)levelGroup.padding.top + levelGroup.spacing) / (levelItemHeight + levelGroup.spacing));
	}

	private void OnSectionScrollChanged(Vector2 vector2)
	{
		sectionUpArrow.SetActive(sectionRect.content.anchoredPosition.y - (float)sectionGroup.padding.top > sectionItemHeight);
		sectionDownArrow.SetActive(0f - sectionViewportHeight - (sectionRect.content.anchoredPosition.y - sectionRect.content.rect.size.y) > sectionItemHeight);
	}

	private void OnLevelScrollChanged(Vector2 vector2)
	{
		levelUpArrow.SetActive(levelRect.content.anchoredPosition.y - (float)levelGroup.padding.top > levelItemHeight);
		levelDownArrow.SetActive(0f - levelViewportHeight - (levelRect.content.anchoredPosition.y - levelRect.content.rect.size.y) > levelItemHeight);
	}

	private void OnWorldDataChanged(object sender, InteractionEventArgs e)
	{
		int autoSelectId = (int)e.Context;
		RefreshSections(autoSelectId);
	}

	public void RefreshSections(int autoSelectId)
	{
		secitonItemPool.RecycleAll();
		_viewModel.SectionTabDatas.Clear();
		if (_viewModel.SectionDatas != null && _viewModel.SectionDatas.Count > 0)
		{
			int num = -1;
			for (int i = 0; i < _viewModel.SectionDatas.Count; i++)
			{
				GameObject obj = secitonItemPool.Allocate(out var newCreate);
				MapAreaTabItem component = obj.GetComponent<MapAreaTabItem>();
				MapAreaTabItemData mapAreaTabItemData = new MapAreaTabItemData(_viewModel, _viewModel.SectionDatas[i], i);
				if (newCreate)
				{
					component.Init(mapAreaTabItemData);
				}
				else
				{
					component.RefreshData(mapAreaTabItemData);
				}
				obj.transform.SetAsLastSibling();
				_viewModel.SectionTabDatas.Add(mapAreaTabItemData);
				if (autoSelectId > 0)
				{
					if (mapAreaTabItemData.Id == autoSelectId)
					{
						num = mapAreaTabItemData.TabIndex;
						_viewModel.SetSectionTabSelected(mapAreaTabItemData);
					}
				}
				else if (i == 0)
				{
					num = mapAreaTabItemData.TabIndex;
					_viewModel.SetSectionTabSelected(mapAreaTabItemData);
				}
			}
			if (_viewModel.SectionDatas.Count > sectionDisplayTabCount)
			{
				sectionContent.enabled = true;
				sectionRect.enabled = true;
			}
			else
			{
				sectionContent.enabled = false;
				sectionRect.content.sizeDelta = new Vector2(sectionRect.content.sizeDelta.x, sectionViewportHeight);
				sectionRect.enabled = false;
			}
			if (num < 0 || num < sectionDisplayTabCount)
			{
				sectionRect.content.SetLocalPositionY(0f);
			}
			else
			{
				float newValue = (float)sectionGroup.padding.top + (sectionItemHeight + sectionGroup.spacing) * (float)num + sectionItemHeight / 2f - sectionViewportHeight / 2f;
				sectionRect.content.SetLocalPositionY(newValue);
			}
		}
		OnSectionScrollChanged(Vector2.zero);
	}

	private void OnSectionDataChanged(object sender, InteractionEventArgs e)
	{
		int autoSelectId = (int)e.Context;
		RefreshLevels(autoSelectId);
	}

	public void RefreshLevels(int autoSelectId)
	{
		levelItemPool.RecycleAll();
		_viewModel.LevelTabDatas.Clear();
		if (_viewModel.LevelDatas != null && _viewModel.LevelDatas.Count > 0)
		{
			int num = -1;
			for (int i = 0; i < _viewModel.LevelDatas.Count; i++)
			{
				GameObject obj = levelItemPool.Allocate(out var newCreate);
				MapAreaTabItem component = obj.GetComponent<MapAreaTabItem>();
				MapAreaTabItemData mapAreaTabItemData = new MapAreaTabItemData(_viewModel, _viewModel.LevelDatas[i], i);
				if (newCreate)
				{
					component.Init(mapAreaTabItemData);
				}
				else
				{
					component.RefreshData(mapAreaTabItemData);
				}
				obj.transform.SetAsLastSibling();
				_viewModel.LevelTabDatas.Add(mapAreaTabItemData);
				if (autoSelectId > 0)
				{
					if (mapAreaTabItemData.Id == autoSelectId)
					{
						num = mapAreaTabItemData.TabIndex;
						_viewModel.SetLevelTabSelected(mapAreaTabItemData);
					}
				}
				else if (i == 0)
				{
					num = mapAreaTabItemData.TabIndex;
					_viewModel.SetLevelTabSelected(mapAreaTabItemData);
				}
			}
			if (_viewModel.LevelDatas.Count > levelDisplayTabCount)
			{
				levelContent.enabled = true;
				levelRect.enabled = true;
			}
			else
			{
				levelContent.enabled = false;
				levelRect.content.sizeDelta = new Vector2(levelRect.content.sizeDelta.x, levelViewportHeight);
				levelRect.enabled = false;
			}
			if (num < 0 || num < levelDisplayTabCount)
			{
				levelRect.content.SetLocalPositionY(0f);
			}
			else
			{
				float newValue = (float)levelGroup.padding.top + (levelItemHeight + levelGroup.spacing) * (float)num + levelItemHeight / 2f - levelViewportHeight / 2f;
				levelRect.content.SetLocalPositionY(newValue);
			}
		}
		OnLevelScrollChanged(Vector2.zero);
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		if ((bool)e.Context)
		{
			Show();
		}
		else
		{
			Hide();
		}
	}

	public void UpdateTabItemsTags(object sender = null, InteractionEventArgs e = null)
	{
		levelItemPool?.GetAll().ForEach(delegate(GameObject p)
		{
			p.GetComponent<MapAreaTabItem>()?.ViewModel.UpdateTags();
		});
		secitonItemPool?.GetAll().ForEach(delegate(GameObject p)
		{
			p.GetComponent<MapAreaTabItem>()?.ViewModel.UpdateTags();
		});
	}

	private void Hide()
	{
		areaListToggle.ViewModel.IsSelected = false;
		Animator obj = animator;
		if (obj != null)
		{
			obj.SetTrigger(hideAniName);
		}
	}

	private void Show()
	{
		areaListToggle.ViewModel.IsSelected = true;
		Animator obj = animator;
		if (obj != null)
		{
			obj.SetTrigger(showAniName);
		}
	}

	protected override void OnDestroy()
	{
		secitonItemPool?.Dispose();
		secitonItemPool = null;
		levelItemPool?.Dispose();
		levelItemPool = null;
		base.OnDestroy();
	}
}
