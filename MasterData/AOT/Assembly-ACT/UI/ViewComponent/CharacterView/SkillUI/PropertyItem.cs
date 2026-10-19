using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using Fundamental;

namespace UI.ViewComponent.CharacterView.SkillUI;

public class PropertyItem : SkillItemBase
{
	public override bool ShowPreview => false;

	public override void Init()
	{
		base.Init();
		SetData(null);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Skill_Change, SetData);
		skillItemAnimation?.GetSequence("Normal").Play();
		if (toggle != null)
		{
			toggle.onValueChanged.RemoveListener(OnValueChanged);
			toggle.onValueChanged.AddListener(OnValueChanged);
		}
	}

	private void OnValueChanged(bool isOn)
	{
		if (isOn)
		{
			skillItemAnimation?.GetSequence("Selected").Play();
		}
		else
		{
			skillItemAnimation?.GetSequence("Normal").Play();
		}
	}

	private void SetData(BaseEventContent obj)
	{
		GameUtility.CanSkillGroupLevelUp(Character, skillGroupId, out m_LockReason);
		UpdatePerformance();
	}

	public override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Skill_Change, SetData);
	}

	protected override bool CheckUnLock()
	{
		return GameUtility.CanSkillGroupLevelUp(Character, skillGroupId, out m_LockReason);
	}

	public override void UpdatePerformance()
	{
	}

	private SkillGroupLevelData GetSkillGroupLvData()
	{
		return CoreUtils.GetData(new MPSkill
		{
			id = skillGroupId,
			level = 1
		}.GetSkillIdWithLevel(), RuntimeConfigs.data.skillGroupLevelDatas);
	}

	public override SkillGroupLevelData GetSkillGroupNextLvData()
	{
		return null;
	}
}
