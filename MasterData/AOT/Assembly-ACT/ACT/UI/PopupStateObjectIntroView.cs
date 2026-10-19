using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopupStateObjectIntroView : BaseUIView<PopupStateObjectIntroViewController>
{
	public ActButton closeBtn;

	public LocalizeStringEvent title;

	public LocalizeStringEvent content;

	public GameObject stateObjectTypeCell;

	public Transform typeContent;

	public ViewControlLayer layer;

	public BImage imageAddress;

	private PopupStateObjectIntroViewData m_data;

	private int m_groupId;

	private const int TitleLocalization = 2841;

	private const int CellShowIntervalMilliseconds = 30;

	private readonly List<ExploreStateObjectTabCell> _stateObjectCells = new List<ExploreStateObjectTabCell>();

	private int _cellShowAnimationVersion;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		InitCell();
		layer.Focus();
	}

	public void InitCell()
	{
		_stateObjectCells.Clear();
		m_data = uiViewData as PopupStateObjectIntroViewData;
		if (m_data == null || m_data.groupId == 0)
		{
			return;
		}
		title.StringReference.TableEntryReference = 2841L;
		foreach (StateObjectGroup value in RuntimeConfigs.data.stateObjectGroups.Values)
		{
			if (value.weight != 0)
			{
				int id = value.id;
				ExploreStateObjectTabCell component = Object.Instantiate(stateObjectTypeCell, typeContent).GetComponent<ExploreStateObjectTabCell>();
				component.Init(id, m_data.mapArea, RefreshData);
				component.GotoShow();
				_stateObjectCells.Add(component);
				component.select.SetActive(id == m_data.groupId);
				if (id == m_data.groupId)
				{
					InitData(id);
					layer.DefaultSelect = component.GetComponent<ACT.ViewControl.SelectableEx>();
				}
			}
		}
	}

	private async UniTask PlayCellShowAnimation(int version)
	{
		for (int i = 0; i < _stateObjectCells.Count; i++)
		{
			if (i > 0)
			{
				await UniTask.Delay(30);
			}
			if (version != _cellShowAnimationVersion || IsClosing())
			{
				break;
			}
			_stateObjectCells[i]?.PlayAnim("Show");
		}
	}

	private bool IsClosing()
	{
		if (UIController != null)
		{
			return UIController.ExpectedState == UIExpectedState.Close;
		}
		return false;
	}

	private void RefreshData(int groupId)
	{
		for (int i = 0; i < typeContent.childCount; i++)
		{
			ExploreStateObjectTabCell component = typeContent.GetChild(i).GetComponent<ExploreStateObjectTabCell>();
			if (component != null)
			{
				component.SetSelected(groupId == component.GroupId);
			}
		}
		InitData(groupId);
	}

	private void InitData(int groupId)
	{
		m_data = uiViewData as PopupStateObjectIntroViewData;
		if (groupId == 0)
		{
			return;
		}
		m_groupId = groupId;
		StateObjectGroup data = CoreUtils.GetData(groupId, RuntimeConfigs.data.stateObjectGroups);
		if (data == null)
		{
			return;
		}
		if (data.id == 4)
		{
			MapArea data2 = CoreUtils.GetData(m_data.mapArea, RuntimeConfigs.data.mapAreas);
			if (data2 != null)
			{
				ExploreType data3 = CoreUtils.GetData(data2.exploreType, RuntimeConfigs.data.exploreTypes);
				if (data3 != null)
				{
					Station.LoadImage(239, data3.imageAddress, imageAddress);
					content.StringReference.TableEntryReference = data3.ObjectDesc;
				}
			}
		}
		else
		{
			Station.LoadImage(239, data.imageAddress, imageAddress);
			content.StringReference.TableEntryReference = data.ObjectDesc;
		}
	}

	protected override void Init()
	{
		base.Init();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show").Play();
		PlayCellShowAnimation(++_cellShowAnimationVersion).Forget();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		_cellShowAnimationVersion++;
		base.UnInit();
		DestroyStageGroup();
	}

	private void DestroyStageGroup()
	{
		for (int num = typeContent.childCount - 1; num >= 0; num--)
		{
			Object.Destroy(typeContent.GetChild(num).gameObject);
		}
		_stateObjectCells.Clear();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide").Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		_cellShowAnimationVersion++;
		base.Close();
	}
}
