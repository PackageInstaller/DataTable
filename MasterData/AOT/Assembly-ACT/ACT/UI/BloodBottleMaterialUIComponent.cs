using ACT.Model;
using Runtime.UI.CommonComponent;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.UI;

public class BloodBottleMaterialUIComponent : ItemUIComponentBase
{
	[SerializeField]
	public CommonBottleIconComponent m_BelongBottleIcon;

	[FormerlySerializedAs("m_BottleType")]
	[SerializeField]
	private CommonMaterialTypeComponent m_BottleMatType;

	[SerializeField]
	private GameObject m_curBottleEquiped;

	[SerializeField]
	private GameObject m_otherBottleEquiped;

	[SerializeField]
	private ActButton m_ReduceBtn;

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		BloodBottleMaterial bloodBottleMaterial = ItemUnifier.As<BloodBottleMaterial>();
		if (m_InitType == InitType.BloodBottleMaterial)
		{
			BloodBottleData bloodBottleById = Model<BloodBottleModel>.Interface.GetBloodBottleById(ItemUnifier.As<BloodBottleMaterial>().belongBottle);
			m_BelongBottleIcon.BloodBottleData = bloodBottleById;
		}
		m_BottleMatType.Station = Station;
		m_BottleMatType.BloodBottleMaterial = bloodBottleMaterial;
	}

	public void ChangeCurBottleEquipedDisplay(bool active)
	{
		m_curBottleEquiped.SetActive(active);
		m_otherBottleEquiped.SetActive(!active);
	}

	public void HideAllEquipedDisplay()
	{
		m_curBottleEquiped.SetActive(value: false);
		m_otherBottleEquiped.SetActive(value: false);
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
