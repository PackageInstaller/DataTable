using UnityEngine;

public class RoleUI1084 : MonoBehaviour
{
	private const int NORMAL_START_COUNT_FRAME = 8;

	private const int CRITICAL_START_COUNT_FRAME = 8;

	private const int NORMAL_ABILITY_ID = 1084201;

	private const int CRITICAL_ABILITY_ID = 1084211;

	[SerializeField]
	private GameObject _item1;

	[SerializeField]
	private GameObject _item2;

	private NAgent _agent;

	private BBHumanoid _blackboard;

	private int _skillCount;

	private int _normalRecordFrameId;

	private bool _isSelf;

	private void Start()
	{
		_agent = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetPlayerAgent();
		_blackboard = _agent.Blackboard as BBHumanoid;
		_isSelf = _agent.AgentConfigID == 1084;
	}

	private void Update()
	{
		if (!_isSelf || _blackboard == null || _blackboard.m_NextSimFrameData == null || _blackboard.m_LastSimFrameData == null)
		{
			return;
		}
		int abilityFrame = _blackboard.m_LastSimFrameData.AbilityFrame;
		switch (_blackboard.m_LastSimFrameData.mAbilityID)
		{
		case 1084201:
			if (abilityFrame >= 8 && _normalRecordFrameId == 0)
			{
				_skillCount++;
				_normalRecordFrameId = abilityFrame;
			}
			else if (abilityFrame < 8)
			{
				_normalRecordFrameId = 0;
			}
			break;
		case 1084211:
			_normalRecordFrameId = 0;
			if (abilityFrame >= 8)
			{
				_skillCount = 0;
			}
			break;
		default:
			_normalRecordFrameId = 0;
			break;
		}
		UpdatePoint();
	}

	public void SetSkillCount(int value)
	{
		value = Mathf.Min(2, value);
		value = Mathf.Max(0, value);
		_skillCount = value;
		UpdatePoint();
	}

	private void UpdatePoint()
	{
		_item1.SetActive(_skillCount > 0);
		_item2.SetActive(_skillCount > 1);
	}
}
