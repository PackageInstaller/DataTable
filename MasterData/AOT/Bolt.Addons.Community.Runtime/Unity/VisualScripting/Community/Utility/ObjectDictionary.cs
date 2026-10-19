using System;
using System.Collections.Generic;

namespace Unity.VisualScripting.Community.Utility;

[Serializable]
[IncludeInSettings(true)]
[Inspectable]
[RenamedFrom("Bolt.Addons.Community.Utility.ObjectDictionary")]
public sealed class ObjectDictionary : Dictionary<object, object>
{
}
