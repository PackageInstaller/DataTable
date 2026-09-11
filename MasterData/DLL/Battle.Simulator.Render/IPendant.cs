public interface IPendant
{
	void Initialize(NAgent parent);

	void Finish();

	void ActionHandler(AgentAction agentAction);
}
