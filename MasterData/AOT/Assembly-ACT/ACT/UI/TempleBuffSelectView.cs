using System.Collections.Generic;
using System.Linq;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TempleBuffSelectView : BaseUIView<TempleBuffSelectInputController>
{
	public LoopHorizontalScrollRect scrollRect;

	public ActButton confirmBtn;

	public ViewControlRoot viewControlRoot;

	public ViewControlLayer layer;

	private TempleBuffSelectViewData m_data;

	private List<TempleBuffNodeData> _buffs;

	private TempleBuffNodeData _curSelectBuff;

	public override UniTask PreInit()
	{
		_buffs = ListPool<TempleBuffNodeData>.Get();
		return UniTask.CompletedTask;
	}

	protected override void Init()
	{
		m_data = uiViewData as TempleBuffSelectViewData;
		confirmBtn?.SetBtnClick(ConfirmSelectCurBuff);
		RefreshDisplay();
	}

	protected override void UnInit()
	{
		if (_buffs != null)
		{
			ListPool<TempleBuffNodeData>.Release(_buffs);
		}
		_curSelectBuff = null;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	private void RefreshDisplay()
	{
		if (m_data == null)
		{
			return;
		}
		_buffs.Clear();
		_curSelectBuff = null;
		int[] array = CoreUtils.GetData(m_data.templeId, RuntimeConfigs.data.instanceDungeons).skillGroup[m_data.templeRoomIndex];
		if (array == null || array.Length <= 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"id 为{m_data.templeId}的战斗神庙，buffId没配！检查InstanceDungeons表");
			}
			return;
		}
		foreach (int num in array)
		{
			TempleBuffNodeData item = new TempleBuffNodeData
			{
				buffId = num,
				iconId = CoreUtils.GetData(num, RuntimeConfigs.data.instanceDungeonSkills).skillIcon
			};
			_buffs.Add(item);
		}
		_curSelectBuff = _buffs.First();
		scrollRect.OnItemLoad.RemoveAllListeners();
		scrollRect?.OnItemLoad.AddListener(SetTempleBuffNode);
		scrollRect?.OnItemUnload.RemoveAllListeners();
		scrollRect?.OnItemUnload.AddListener(OnTempleBuffNodeUnLoad);
		scrollRect?.ClearCells();
		if (scrollRect != null)
		{
			scrollRect.totalCount = _buffs.Count;
		}
		scrollRect?.RefillCells();
		confirmBtn?.Interactable(_buffs.Count > 0 && _curSelectBuff != null);
	}

	private void OnTempleBuffNodeUnLoad(ILoopScrollDataSource item)
	{
		if (item is TempleBuffNode templeBuffNode)
		{
			templeBuffNode.UnInit();
		}
	}

	private void SetTempleBuffNode(ILoopScrollDataSource item)
	{
		TempleBuffNode cell = item as TempleBuffNode;
		if ((object)cell == null)
		{
			return;
		}
		cell.Init(_buffs[cell.index], Station);
		if (cell.Data.buffId == _curSelectBuff.buffId)
		{
			cell.SetSelectedState(isSelected: true);
		}
		cell.btn?.SetBtnClick(() =>
		{
			if (_curSelectBuff != null)
			{
				int id = _buffs.IndexOf(_curSelectBuff);
				(scrollRect.GetItem(id) as TempleBuffNode)?.SetSelectedState(isSelected: false);
			}
			cell.SetSelectedState(isSelected: true);
			_curSelectBuff = _buffs[cell.index];
		});
	}

	private void ConfirmSelectCurBuff()
	{
		if (_curSelectBuff != null && m_data != null)
		{
			Model<TempleModel>.Interface.RecordBattleTempleBuffSelection(m_data.templeRoomIndex, _curSelectBuff.buffId);
			BattleTempleBuffSelectFinishEvt evt = Singleton<EventManager>.instance.GetEvt<BattleTempleBuffSelectFinishEvt>();
			evt.swid = m_data.swid;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.BattleTempleBuffSelectFinish, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			Close();
		}
	}

	public ACT.ViewControl.SelectableEx GetCurBuffCellSelectable()
	{
		List<TempleBuffNodeData> buffs = _buffs;
		if (buffs == null || buffs.Count <= 0 || _curSelectBuff == null)
		{
			return null;
		}
		int id = _buffs.IndexOf(_curSelectBuff);
		TempleBuffNode templeBuffNode = scrollRect.GetItem(id) as TempleBuffNode;
		if (!(templeBuffNode != null))
		{
			return null;
		}
		return templeBuffNode.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}
}
