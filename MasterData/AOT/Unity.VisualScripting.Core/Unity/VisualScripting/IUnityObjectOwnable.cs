using UnityEngine;

namespace Unity.VisualScripting;

public interface IUnityObjectOwnable
{
	Object owner { get; set; }
}
