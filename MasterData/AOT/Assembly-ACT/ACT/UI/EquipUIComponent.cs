using ACT.Game;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.UI;

public class EquipUIComponent : ItemUIComponentBase
{
	[SerializeField]
	private BImage m_EquipTypeIcon;

	[SerializeField]
	private GameObject m_LockIcon;

	[Space]
	[SerializeField]
	private GameObject m_CharacterEquipped;

	[SerializeField]
	private BImage m_CharacterEquipIcon;

	[Space]
	[SerializeField]
	private ActButton m_ReduceBtn;

	[FormerlySerializedAs("m_redTipRoot")]
	[SerializeField]
	private GemHoleItems m_GemHoles;

	private bool isTrialCharacter;

	public bool IsTrialCharacter
	{
		get
		{
			return isTrialCharacter;
		}
		set
		{
			isTrialCharacter = value;
		}
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

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		if (m_ItemUnifier?.Source == null)
		{
			m_ItemCountRoot.gameObject.SetActive(value: false);
			m_GemHoles.gameObject.SetActive(value: false);
			m_CharacterEquipped.SetActive(value: false);
			IsChosen = false;
			SetSelect();
			return;
		}
		Equip equip = m_ItemUnifier.As<Equip>();
		SetSelect();
		Station.LoadImageAsync(135, equip.TypeIndex, m_EquipTypeIcon).Forget();
		m_ItemCountRoot.gameObject.SetActive(value: true);
		if (m_InitType != InitType.CharacterOverViewEquipSlot)
		{
			Character character = G.localPlayer.GetCharacter(equip.WearCharacter);
			if (character != null)
			{
				m_CharacterEquipped.SetActive(value: true);
				Station.LoadImageAsync(126, character.Id, m_CharacterEquipIcon).Forget();
			}
			else
			{
				m_CharacterEquipped.SetActive(value: false);
			}
			m_LockIcon.SetActive(equip.IsLock);
		}
		else
		{
			m_CharacterEquipped.SetActive(value: false);
			m_LockIcon.SetActive(value: false);
		}
		m_GemHoles.gameObject.SetActive(value: true);
		m_GemHoles.Station = Station;
		m_GemHoles.Init(equip, IsTrialCharacter);
	}

	protected override void UpdateName()
	{
		base.UpdateName();
		if (ItemUnifier != null && ItemUnifier != ItemUnifierProxy.Empty)
		{
			m_NumberComponent?.UpdateNumber(ItemUnifier.As<Equip>().Level);
			m_NumberComponent?.totalText.gameObject.SetActive(value: false);
			m_NumberComponent?.slashText.gameObject.SetActive(value: false);
		}
	}

	protected override long GetCount()
	{
		return 1L;
	}
}
