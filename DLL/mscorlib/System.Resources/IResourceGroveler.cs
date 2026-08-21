using System.Collections.Generic;
using System.Globalization;
using System.Threading;

namespace System.Resources;

internal interface IResourceGroveler
{
	ResourceSet GrovelForResourceSet(CultureInfo culture, Dictionary<string, ResourceSet> localResourceSets, bool tryParents, bool createIfNotExists, ref StackCrawlMark stackMark);
}
