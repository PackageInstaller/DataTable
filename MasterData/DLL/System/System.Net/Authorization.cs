namespace System.Net;

public class Authorization
{
	private string m_Message;

	private bool m_Complete;

	internal string ModuleAuthenticationType;

	public string Message => m_Message;

	public bool Complete => m_Complete;

	public Authorization(string token)
	{
		m_Message = ValidationHelper.MakeStringNull(token);
		m_Complete = true;
	}

	public Authorization(string token, bool finished)
	{
		m_Message = ValidationHelper.MakeStringNull(token);
		m_Complete = finished;
	}
}
