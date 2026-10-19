using ACT.Config;

namespace ACT.MissionSystem;

public class MissionConditionData
{
	private readonly MissionConditionActionEnum m_DefInfo;

	private readonly ACT.Config.MissionCondition m_Config;

	private object m_Param;

	public int Tags;

	public int Id => m_Config.id;

	public int Type => m_Config.enumID;

	public int Desc => m_Config.desc;

	public object Param
	{
		get
		{
			if (m_Param == null)
			{
				m_Param = ConditionDefine.DeserializeConditionParam(m_Config.enumID, m_Config.param);
			}
			return m_Param;
		}
	}

	public MissionConditionData(MissionConditionActionEnum defInfo, ACT.Config.MissionCondition config)
	{
		m_DefInfo = defInfo;
		m_Config = config;
	}
}
