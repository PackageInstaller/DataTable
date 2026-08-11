using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CampaignMapWindow : UGuiWindow
{
	[SerializeField]
	private List<CampaignMatItem> matItems;

	[SerializeField]
	private GameObject matRow1;

	[SerializeField]
	private GameObject matRow2;

	[SerializeField]
	private TextMeshProUGUI curSideTaskInfo;

	[SerializeField]
	private TextMeshProUGUI pushTime;

	[SerializeField]
	private RectTransform mapRoot;

	[SerializeField]
	private RectTransform areaCacheRoot;

	[SerializeField]
	private CampaignBuildingArea buildingAreaTpl;

	[SerializeField]
	private CampaignTaskArea taskAreaTpl;

	[SerializeField]
	private CampaignMonsterArea monsterAreaTpl;

	[SerializeField]
	private CampaignBuildingInfoView buildingInfoView;

	[SerializeField]
	private CampaignCopyInfoView copyInfoView;

	[SerializeField]
	private GameObject searchEffect;

	[SerializeField]
	private float searchEffectDuration = 3f;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnRule;

	[SerializeField]
	private Button btnSearch;

	[SerializeField]
	private ChatBarView chatBarView;

	private CampaignMapViewModel _viewModel;

	private Dictionary<int, CampaignPosition> _areaPositions = new Dictionary<int, CampaignPosition>();

	private GameObjectPool _buildingAreaPool;

	private GameObjectPool _taskAreaPool;

	private GameObjectPool _monsterAreaPool;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<CampaignMapViewModel>();
		BindingSet<CampaignMapWindow, CampaignMapViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((CampaignMapWindow v) => v.OnDismissRequest).To((CampaignMapViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((CampaignMapWindow v) => v.OpenUguiWindow).To((CampaignMapViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CampaignMapViewModel vm) => vm.Close);
		bindingSet.Bind(btnRule).For((Button v) => v.onClick).To((CampaignMapViewModel vm) => vm.OpenWindowCmd)
			.CommandParameter("Rule");
		bindingSet.Bind<TextMeshProUGUI>(curSideTaskInfo).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMapViewModel vm) => vm.CurBranchTaskInfo);
		bindingSet.Bind<TextMeshProUGUI>(pushTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignMapViewModel vm) => vm.PushTimeText);
		bindingSet.Bind(searchEffect).For((GameObject v) => v.activeSelf).To((CampaignMapViewModel vm) => vm.ShowSearchEffect);
		bindingSet.Bind().For((CampaignMapWindow v) => v.RefreshAreaViews).To((CampaignMapViewModel vm) => vm.RefreshAreaRst);
		bindingSet.Bind().For((CampaignMapWindow v) => v.OnAreaClick).To((CampaignMapViewModel vm) => vm.ClickAreaRst);
		bindingSet.Bind().For((CampaignMapWindow v) => v.RefreshMatItems).To((CampaignMapViewModel vm) => vm.RefreshMatRst);
		bindingSet.Bind(this).For((CampaignMapWindow v) => v.OpenPropPopupRst).To((CampaignMapViewModel vm) => vm.OpenPropPopupRst);
		bindingSet.Bind(btnSearch).For((Button v) => v.onClick).To((CampaignMapViewModel vm) => vm.SearchMonsterCmd)
			.CommandParameter(searchEffectDuration);
		bindingSet.Build();
		InitChatBarView();
		_buildingAreaPool = new GameObjectPool(buildingAreaTpl.gameObject, areaCacheRoot);
		_taskAreaPool = new GameObjectPool(taskAreaTpl.gameObject, areaCacheRoot);
		_monsterAreaPool = new GameObjectPool(monsterAreaTpl.gameObject, areaCacheRoot);
		InitPositions();
		RefreshAreaViews();
		RefreshMatItems();
		buildingInfoView.Init(new CampaignBuildingInfoViewModel(_viewModel));
		copyInfoView.Init(new CampaignCopyInfoViewModel(_viewModel));
	}

	private void InitChatBarView()
	{
		if (!(chatBarView == null) && _viewModel.ChatBar != null)
		{
			chatBarView.Init(_viewModel.ChatBar);
		}
	}

	private void InitPositions()
	{
		_areaPositions.Clear();
		mapRoot.GetComponentsInChildren<CampaignPosition>()?.ToList().ForEach(delegate(CampaignPosition p)
		{
			if (!_areaPositions.ContainsKey(p.id))
			{
				_areaPositions.Add(p.id, p);
			}
		});
	}

	private void OnAreaClick(object sender, InteractionEventArgs e)
	{
		if (e != null && e.Context != null)
		{
			object context = e.Context;
			if (context is CampaignBuildingData areaData)
			{
				buildingInfoView.RefreshAreaData(areaData);
				copyInfoView.Hide();
				buildingInfoView.Show();
			}
			else if (context is CampaignTaskData areaData2)
			{
				copyInfoView.RefreshAreaData(areaData2);
				buildingInfoView.Hide();
				copyInfoView.Show();
			}
			else if (context is CampaignMonsterData areaData3)
			{
				copyInfoView.RefreshAreaData(areaData3);
				buildingInfoView.Hide();
				copyInfoView.Show();
			}
		}
	}

	private void RefreshAreaViews(object sender = null, InteractionEventArgs e = null)
	{
		buildingInfoView.Hide();
		copyInfoView.Hide();
		List<CampaignAreaType> list = null;
		if (e != null && e.Context != null)
		{
			list = (List<CampaignAreaType>)e.Context;
		}
		RecycleAreaView(list);
		if (_viewModel.AreaDataList == null)
		{
			return;
		}
		foreach (CampaignAreaData areaData in _viewModel.AreaDataList)
		{
			if (!_areaPositions.TryGetValue(areaData.PositionId, out var value) || (list != null && !list.Contains(areaData.Type)))
			{
				continue;
			}
			GameObjectPool areaPool = GetAreaPool(areaData.Type);
			if (areaPool != null)
			{
				GameObject obj = areaPool.AllocateNoActive(out var newCreate);
				CampaignAreaView component = obj.GetComponent<CampaignAreaView>();
				if (newCreate)
				{
					component.Init(areaData);
				}
				else
				{
					component.RefreshData(areaData);
				}
				component.SetParent(value);
				component.RectTransform.anchoredPosition = Vector2.zero;
				component.OnShow();
				obj.SetActive(value: true);
			}
		}
		Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.ResetBuildingUpgradeMark();
	}

	private GameObjectPool GetAreaPool(CampaignAreaType type)
	{
		return type switch
		{
			CampaignAreaType.Building => _buildingAreaPool, 
			CampaignAreaType.Task => _taskAreaPool, 
			CampaignAreaType.EliteMonster => _monsterAreaPool, 
			CampaignAreaType.LordMonster => _monsterAreaPool, 
			CampaignAreaType.WorldBoss => _monsterAreaPool, 
			_ => null, 
		};
	}

	private void RecycleAreaView(List<CampaignAreaType> list)
	{
		if (list == null)
		{
			_buildingAreaPool.RecycleAll();
			_buildingAreaPool.GetAll().ForEach(delegate(GameObject p)
			{
				p.transform.SetParent(areaCacheRoot);
			});
			_taskAreaPool.RecycleAll();
			_taskAreaPool.GetAll().ForEach(delegate(GameObject p)
			{
				p.transform.SetParent(areaCacheRoot);
			});
			_monsterAreaPool.RecycleAll();
			_monsterAreaPool.GetAll().ForEach(delegate(GameObject p)
			{
				p.transform.SetParent(areaCacheRoot);
			});
			return;
		}
		if (list.Contains(CampaignAreaType.Building))
		{
			_buildingAreaPool.RecycleAll();
			_buildingAreaPool.GetAll().ForEach(delegate(GameObject p)
			{
				p.transform.SetParent(areaCacheRoot);
			});
		}
		if (list.Contains(CampaignAreaType.Task))
		{
			_taskAreaPool.RecycleAll();
			_taskAreaPool.GetAll().ForEach(delegate(GameObject p)
			{
				p.transform.SetParent(areaCacheRoot);
			});
		}
		if (list.Contains(CampaignAreaType.EliteMonster) || list.Contains(CampaignAreaType.LordMonster) || list.Contains(CampaignAreaType.WorldBoss))
		{
			_monsterAreaPool.RecycleAll();
			_monsterAreaPool.GetAll().ForEach(delegate(GameObject p)
			{
				p.transform.SetParent(areaCacheRoot);
			});
		}
	}

	private void RefreshMatItems(object sender = null, InteractionEventArgs e = null)
	{
		matItems?.RemoveAll((CampaignMatItem p) => p == null);
		matRow1.SetActive(value: false);
		matRow2.SetActive(value: false);
		if (matItems == null || matItems.Count <= 0)
		{
			return;
		}
		matItems.ForEach(delegate(CampaignMatItem p)
		{
			p.gameObject.SetActive(value: false);
		});
		if (_viewModel?.Materials == null)
		{
			return;
		}
		for (int num = 0; num < _viewModel.Materials.Count && matItems.Count > num; num++)
		{
			CampaignMatItemData userData = new CampaignMatItemData(_viewModel, _viewModel.Materials[num]);
			if (matItems[num].ViewModel == null)
			{
				matItems[num].Init(userData);
			}
			else
			{
				matItems[num].RefreshData(userData);
			}
			matItems[num].gameObject.SetActive(value: true);
		}
		foreach (Transform item in matRow1.transform)
		{
			if (item.gameObject.activeSelf)
			{
				matRow1.SetActive(value: true);
				break;
			}
		}
		foreach (Transform item2 in matRow2.transform)
		{
			if (item2.gameObject.activeSelf)
			{
				matRow2.SetActive(value: true);
				break;
			}
		}
	}

	private void OpenPropPopupRst(object sender, InteractionEventArgs e)
	{
		if (e != null && e.Context is KeyValuePair<RoleMoneyEnum, Vector3> keyValuePair)
		{
			OpenPropInfoWindow(keyValuePair.Key, keyValuePair.Value);
		}
	}

	private void OpenPropInfoWindow(RoleMoneyEnum moneyEnum, Vector3 iconWorldPos)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>((int)moneyEnum);
		if (dataRow != null)
		{
			Vector2 vector = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), iconWorldPos);
			Vector2 pos = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(RectTransform, vector, UIUtilly.GetUICamera(), ref pos);
			_viewModel.OpenPropPopupWindow(dataRow, pos);
		}
	}

	protected override void OnDestroy()
	{
		_buildingAreaPool?.Dispose();
		_taskAreaPool?.Dispose();
		_monsterAreaPool?.Dispose();
		base.OnDestroy();
	}
}
