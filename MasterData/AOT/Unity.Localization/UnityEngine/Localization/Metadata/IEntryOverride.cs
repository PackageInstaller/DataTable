using UnityEngine.Localization.Tables;

namespace UnityEngine.Localization.Metadata;

public interface IEntryOverride : IMetadata
{
	EntryOverrideType GetOverride(out TableReference tableReference, out TableEntryReference tableEntryReference);
}
