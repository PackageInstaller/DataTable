using System;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

[Serializable]
public class DeviceInfo
{
	[FormerlySerializedAs("icon")]
	public Image mainImage;

	public int value { get; private set; }

	public virtual void SetValue(int value)
	{
		this.value = value;
	}
}
