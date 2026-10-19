using ACT.Model;
using Runtime.UI.CommonComponent;
using UnityEngine;

namespace ACT.UI;

public class BloodBottleUIComponent : ItemUIComponentBase
{
	[SerializeField]
	private CommonTeamIndexComponent m_TeamIndexer;

	[SerializeField]
	private StartList m_BottleSlots;

	[SerializeField]
	private ActButton m_ReduceBtn;

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		BloodBottleData bloodBottleData = ItemUnifier.As<BloodBottleData>();
		m_TeamIndexer.Station = Station;
		m_TeamIndexer.Index = ((!bloodBottleData.isEquip) ? (-1) : 0);
		m_BottleSlots.SoltInit(bloodBottleData, Station);
	}

	protected override void OnGameObjectAwake()
	{
		base.OnGameObjectAwake();
		if ((bool)m_ReduceBtn)
		{
			m_ReduceBtn.OnClick.AddListener(OnInvertClick);
		}
	}

	protected override void OnGameObjectDestroy()
	{
		base.OnGameObjectDestroy();
		if ((bool)m_ReduceBtn)
		{
			m_ReduceBtn.OnClick.RemoveListener(OnInvertClick);
		}
	}
}
