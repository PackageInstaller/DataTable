using UnityEngine;

[AddComponentMenu("游戏/场景/物件对齐主光源方向")]
public class AdventureLevelObjectRotationAlign : MonoBehaviour
{
	public void AlignWith(Transform alignNode)
	{
		Vector3 eulerAngles = transform.rotation.eulerAngles;
		eulerAngles.y = alignNode.rotation.eulerAngles.y;
		transform.rotation = Quaternion.Euler(eulerAngles);
	}
}
