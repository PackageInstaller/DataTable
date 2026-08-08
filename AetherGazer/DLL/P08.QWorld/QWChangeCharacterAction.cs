public class QWChangeCharacterAction : QWAgentAction
{
	public int charId;

	public bool isLoad;

	public QWChangeCharacterAction()
		: base(E_Type.ChangeCharacter)
	{
	}
}
