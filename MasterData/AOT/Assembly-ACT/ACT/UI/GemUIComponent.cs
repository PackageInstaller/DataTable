using ACT.Game.Data;
using ACT.UI.DataProxy;
using ACT.Utility;
using Runtime.UI.CommonComponent;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.UI;

public class GemUIComponent : ItemUIComponentBase
{
	[SerializeField]
	private CommonCharacterEquipComponent m_CharacterHeadComponent;

	[FormerlySerializedAs("m_LockRoot")]
	[SerializeField]
	private EquipGemIsLockBtn m_LockComponent;

	[SerializeField]
	private ActButton m_ReduceBtn;

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

	public override void SetData(ItemUnifierProxy item, long leftCount = 0L, InitType initType = InitType.BagItem, ItemCountShowType itemCountShowType = ItemCountShowType.Hide, bool autoReleaseData = false)
	{
		base.SetData(item, leftCount, initType, itemCountShowType, autoReleaseData);
	}

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		Gem gem = m_ItemUnifier?.As<Gem>();
		m_LockComponent?.gameObject.SetActive(value: false);
		Character character = GameUtility.FindEquipEquipCharacter(gem?.InlayEquip ?? 0);
		m_CharacterHeadComponent.Character = character;
		m_ItemNameRoot.SetActive(gem != null);
	}

	protected override long GetCount()
	{
		return 1L;
	}
}
