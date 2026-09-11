using System.Collections;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class SerObjectInfoInit
{
	internal Hashtable seenBeforeTable = new Hashtable();

	internal int objectInfoIdCount = 1;

	internal SerStack oiPool = new SerStack("SerObjectInfo Pool");
}
