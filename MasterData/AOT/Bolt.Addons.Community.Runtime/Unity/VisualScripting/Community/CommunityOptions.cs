namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.CommunityOptions")]
public class CommunityOptions
{
	public virtual bool DefinedEvent_ForceOptimizedInEditor { get; }

	public virtual bool DefinedEvent_RestrictEventTypes { get; }

	public virtual bool SilenceLogMessages { get; } = true;
}
