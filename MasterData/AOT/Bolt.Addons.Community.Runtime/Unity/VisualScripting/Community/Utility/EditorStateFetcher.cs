namespace Unity.VisualScripting.Community.Utility;

[RenamedFrom("Bolt.Addons.Community.Utility.Editor.EditorStateFetcher")]
public class EditorStateFetcher : IEditorStateFetcher
{
	public bool IsEditorPaused()
	{
		return false;
	}
}
