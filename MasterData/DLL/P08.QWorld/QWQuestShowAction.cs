public class QWQuestShowAction : QWAgentAction
{
	public EQuestType questType;

	public bool isInTaskTracking;

	public QWQuestShowAction()
		: base(E_Type.ShowQuest)
	{
	}
}
