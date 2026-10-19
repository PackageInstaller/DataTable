using System;

namespace UnityEngine.Localization.Metadata;

[Serializable]
[Metadata]
public class Comment : IMetadata
{
	[SerializeField]
	[TextArea(1, int.MaxValue)]
	private string m_CommentText = "Comment Text";

	public string CommentText
	{
		get
		{
			return m_CommentText;
		}
		set
		{
			m_CommentText = value;
		}
	}

	public override string ToString()
	{
		return CommentText;
	}
}
