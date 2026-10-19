using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

[RequireComponent(typeof(ActToggle))]
public abstract class SkillItemBase : BaseUIComponent
{
	public ActToggle toggle;

	public int skillGroupId;

	public BetterAnimation skillItemAnimation;

	protected CharacterViewConst.ReasonType m_LockReason;

	private SkillGroupData m_SkillGroupData;

	private SkillDetailData m_SkillDetailData;

	public SkillGroupData SkillGroupData => m_SkillGroupData ?? (m_SkillGroupData = CoreUtils.GetData(skillGroupId, RuntimeConfigs.data.skillGroupDatas));

	public virtual bool ShowPreview => true;

	public CharacterViewConst.ReasonType LockReason
	{
		get
		{
			return m_LockReason;
		}
		set
		{
			m_LockReason = value;
		}
	}

	public int NeedCoin { get; protected set; }

	public UnityAction OnSelectedCallBack { get; set; }

	public UnityAction OnClickCallBack { get; set; }

	public bool IsUnLock { get; protected set; }

	protected bool CanBeUnlocked
	{
		get
		{
			if (!IsUnLock)
			{
				return CheckUnLock();
			}
			return false;
		}
	}

	public Character Character { get; set; }

	private void OnValidate()
	{
		if (!toggle)
		{
			toggle = GetComponent<ActToggle>();
		}
	}

	protected virtual void Awake()
	{
		toggle.onToggleOn.AddListener(OnSelected);
		toggle.onToggleClick.AddListener(OnClick);
	}

	public virtual void Init()
	{
	}

	public virtual void UnInit()
	{
	}

	public virtual void UpdatePerformance()
	{
	}

	protected virtual bool CheckUnLock()
	{
		return false;
	}

	private void OnSelected()
	{
		OnSelectedCallBack?.Invoke();
	}

	private void OnClick()
	{
		OnClickCallBack?.Invoke();
	}

	public abstract SkillGroupLevelData GetSkillGroupNextLvData();
}
