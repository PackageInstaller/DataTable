using UnityEngine;
using UnityEngine.UI;

namespace ACT;

public class LargeMapMaterial : MonoBehaviour
{
	public int Type;

	public void Start()
	{
		Material material = ((Type == 0) ? GameLoader.meta.mapConfig.largeMapRoomMaterial : GameLoader.meta.mapConfig.largeMapDetailMaterial);
		Image[] componentsInChildren = GetComponentsInChildren<Image>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].material = material;
		}
	}
}
