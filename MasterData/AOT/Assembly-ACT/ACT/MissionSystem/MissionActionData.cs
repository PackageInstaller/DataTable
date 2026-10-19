using ACT.Config;

namespace ACT.MissionSystem;

public class MissionActionData
{
	private readonly MissionConditionActionEnum m_DefInfo;

	private readonly ACT.Config.MissionAction m_Config;

	private object m_Param;

	public int Tags;

	public int Id => m_Config.id;

	public int Type => m_Config.enumID;

	public bool OnlyInMissionWorld => false;

	public object Param
	{
		get
		{
			if (m_Param == null)
			{
				m_Param = ActionDefine.DeserializeActionParam(m_Config.enumID, m_Config.param);
			}
			return m_Param;
		}
	}

	public MissionActionData(MissionConditionActionEnum defInfo, ACT.Config.MissionAction config)
	{
		m_DefInfo = defInfo;
		m_Config = config;
	}
}
