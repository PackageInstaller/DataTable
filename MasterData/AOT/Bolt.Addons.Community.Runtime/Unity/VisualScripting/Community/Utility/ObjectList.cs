using System;
using System.Collections.Generic;

namespace Unity.VisualScripting.Community.Utility;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Utility.ObjectList")]
[IncludeInSettings(true)]
[Inspectable]
public sealed class ObjectList : List<object>
{
}
