using ACT.Model;

namespace ACT.Event;

public class RogueRemoveArtifactEvent : BaseEventContent
{
	public RogueArtifactCard artifact;
}
