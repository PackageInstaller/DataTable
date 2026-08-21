using System;

namespace Yarn.Unity;

[Serializable]
public class DialogueReference
{
	public YarnProject project;

	[YarnNode("project")]
	public string nodeName;

	public bool IsValid
	{
		get
		{
			if (project != null && !string.IsNullOrEmpty(nodeName))
			{
				return project.Program.Nodes.ContainsKey(nodeName);
			}
			return false;
		}
	}

	public DialogueReference()
	{
	}

	public DialogueReference(YarnProject project, string nodeName)
	{
		this.project = project;
		this.nodeName = nodeName;
	}

	public static implicit operator string(DialogueReference reference)
	{
		return reference.nodeName;
	}
}
