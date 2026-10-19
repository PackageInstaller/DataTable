using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class EquipGemSlot : BaseUIComponent
{
	[SerializeField]
	private ActToggle m_Toggle;

	[SerializeField]
	private BImage m_GemIcon;

	[SerializeField]
	private ActButton m_EmptyButton;

	[SerializeField]
	private GameObject[] m_Quality;

	[SerializeField]
	private GameObject[] m_GemLevelStyle;

	[SerializeField]
	private GameObject m_LockStyle;

	[SerializeField]
	private BetterAnimation m_Animation;

	private ImageAssetStation m_ImageAssetStation;

	public UnityAction<EquipGemSlot> OnSlotSelected;

	public UnityAction<EquipGemSlot> OnSlotClick;

	public UnityAction<EquipGemSlot> OnEmptyButtonClick;

	public Gem Gem { get; private set; }

	public int GemSlotLevel { get; private set; }

	public int Index { get; private set; }

	public bool IsOn
	{
		get
		{
			return m_Toggle?.IsOn ?? false;
		}
		set
		{
			if (!(m_Toggle == null))
			{
				if (value)
				{
					m_Toggle.Group.SetToggleOn(m_Toggle);
				}
				else
				{
					m_Toggle.SetIsOn(val: false);
				}
			}
		}
	}

	public void Register(int index)
	{
		Index = index;
		if ((bool)m_Toggle)
		{
			m_Toggle.onToggleOn.AddListener(OnSelected);
			m_Toggle.onToggleClick.AddListener(OnClick);
			m_Toggle.onValueChanged.AddListener(OnValueChanged);
		}
		if ((bool)m_EmptyButton)
		{
			m_EmptyButton.OnClick.AddListener(OnEmptyClick);
		}
	}

	private void OnDestroy()
	{
		Index = -1;
		if ((bool)m_Toggle)
		{
			m_Toggle.onToggleOn.RemoveListener(OnSelected);
			m_Toggle.onToggleClick.AddListener(OnClick);
		}
		if ((bool)m_EmptyButton)
		{
			m_EmptyButton.OnClick.RemoveListener(OnEmptyClick);
		}
	}

	public void SetGem(Gem gem)
	{
		if (GemSlotLevel == 0)
		{
			return;
		}
		Gem gem2 = Gem;
		Gem = gem;
		if (gem == null || gem.Id == 0)
		{
			SetEmptyButtonVisible(visible: true);
			SetGemIconVisible(visible: false);
			if ((bool)m_GemIcon.icon)
			{
				m_GemIcon.icon.sprite = null;
			}
			m_Animation?.GetSequence("Normal")?.Play();
			return;
		}
		if (gem2 == null || !gem2.Equals(gem))
		{
			m_Animation?.GetSequence("Equip")?.Play();
		}
		ItemData data = CoreUtils.GetData(gem.Id, RuntimeConfigs.data.itemDatas);
		EquipGemData data2 = CoreUtils.GetData(gem.Id, RuntimeConfigs.data.equipGemDatas);
		if (data == null || data2 == null)
		{
			return;
		}
		m_ImageAssetStation.LoadItemIconAsync(data.iconAddress, m_GemIcon).Forget();
		SetGemIconVisible(visible: true);
		SetEmptyButtonVisible(visible: false);
		if (data2.quality > GemSlotLevel)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("高等级宝石放到低级宝石槽？");
			}
		}
		else
		{
			for (int i = 0; i < m_GemLevelStyle.Length; i++)
			{
				SetArrayElementVisible(m_GemLevelStyle, i, i == data2.quality - 1);
			}
		}
	}

	public void ResetGemSlot()
	{
		Gem = null;
		if (m_Toggle != null && m_Toggle.IsOn)
		{
			m_Toggle.SetIsOn(val: false);
		}
		if (GemSlotLevel != 0)
		{
			SetEmptyButtonVisible(visible: true);
			SetGemIconVisible(visible: false);
			for (int i = 0; i < m_GemLevelStyle.Length; i++)
			{
				SetArrayElementVisible(m_GemLevelStyle, i, visible: false);
			}
		}
	}

	public void ApplyStyle(int level, ImageAssetStation station)
	{
		m_ImageAssetStation = station ?? GetComponentInParent<IBaseUIView>().Station;
		GemSlotLevel = level;
		for (int i = 0; i < m_Quality.Length; i++)
		{
			SetArrayElementVisible(m_Quality, i, GemSlotLevel - 1 == i);
		}
		for (int j = 0; j < m_GemLevelStyle.Length; j++)
		{
			SetArrayElementVisible(m_GemLevelStyle, j, visible: false);
		}
		SetLockStyleVisible(level == 0);
		if ((bool)m_Toggle)
		{
			m_Toggle.Interactable(level > 0);
		}
		SetGemIconVisible(visible: false);
		SetEmptyButtonVisible(visible: false);
	}

	private void SetArrayElementVisible(GameObject[] gameObjects, int index, bool visible)
	{
		if (gameObjects != null && index >= 0 && index < gameObjects.Length)
		{
			SetVisible(gameObjects[index], visible);
		}
	}

	private void SetVisible(GameObject gameObject, bool visible)
	{
		if ((bool)gameObject && gameObject.activeSelf != visible)
		{
			gameObject.SetActive(visible);
		}
	}

	private void SetGemIconVisible(bool visible)
	{
		if (m_GemIcon != null && (bool)m_GemIcon.icon)
		{
			SetVisible(m_GemIcon.icon.gameObject, visible);
		}
	}

	private void SetEmptyButtonVisible(bool visible)
	{
		if ((bool)m_EmptyButton)
		{
			SetVisible(m_EmptyButton.gameObject, visible);
		}
	}

	private void SetLockStyleVisible(bool visible)
	{
		if ((bool)m_LockStyle)
		{
			SetVisible(m_LockStyle, visible);
		}
	}

	public void PlayShowAnimation()
	{
		if (IsOn)
		{
			m_Animation?.GetSequence("SelectedShow")?.Play();
		}
		else
		{
			m_Animation?.GetSequence("NormalShow")?.Play();
		}
	}

	private void OnSelected()
	{
		OnSlotSelected?.Invoke(this);
	}

	private void OnClick()
	{
		OnSlotClick?.Invoke(this);
	}

	private void OnEmptyClick()
	{
		OnEmptyButtonClick?.Invoke(this);
	}

	private void OnValueChanged(bool arg0)
	{
		if (arg0)
		{
			m_Animation?.GetSequence("Select")?.Play();
		}
		else
		{
			m_Animation?.GetSequence("Normal")?.Play();
		}
	}
}
