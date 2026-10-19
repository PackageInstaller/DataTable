using System;
using System.Collections.Generic;

namespace ACT.UI;

[Serializable]
public class ObjectKeyframes
{
	public string ObjectKey;

	public List<TypeKeyframes> Types;

	public ObjectKeyframes(string objectKey)
	{
		ObjectKey = objectKey;
		Types = new List<TypeKeyframes>();
	}
}
