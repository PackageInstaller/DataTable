namespace System.Security.AccessControl;

public sealed class SystemAcl : CommonAcl
{
	internal override void ApplyCanonicalSortToExplicitAces()
	{
		int canonicalExplicitAceCount = GetCanonicalExplicitAceCount();
		ApplyCanonicalSortToExplicitAces(0, canonicalExplicitAceCount);
	}

	internal override int GetAceInsertPosition(AceQualifier aceQualifier)
	{
		return 0;
	}
}
