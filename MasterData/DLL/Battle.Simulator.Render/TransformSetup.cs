using UnityEngine;

public class TransformSetup : MonoBehaviour
{
	public Animator animator;

	public Transform upperBody;

	public Transform hips;

	public Transform rightHandHook;

	public Transform leftHandHook;

	public Transform Dummy_L_Foot;

	public Transform Dummy_R_Foot;

	public Transform Dummy_L_Clavice;

	public Transform Dummy_R_Clavice;

	public Transform Dummy_L_Crotch;

	public Transform Dummy_R_Crotch;

	public Transform Dummy_Chest;

	public Transform Dummy_Head;

	public Transform Dummy_Bottom;

	public Transform Dummy_Shadow;

	public Transform Dummy_Barrel;

	public Transform Dummy_Muzzle;

	public void HideDummy(bool isHide)
	{
		if ((bool)rightHandHook && rightHandHook.gameObject.activeSelf != isHide)
		{
			rightHandHook.gameObject.SetActive(isHide);
		}
		if ((bool)leftHandHook && leftHandHook.gameObject.activeSelf != isHide)
		{
			leftHandHook.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_L_Foot && Dummy_L_Foot.gameObject.activeSelf != isHide)
		{
			Dummy_L_Foot.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_R_Foot && Dummy_R_Foot.gameObject.activeSelf != isHide)
		{
			Dummy_R_Foot.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_L_Clavice && Dummy_L_Clavice.gameObject.activeSelf != isHide)
		{
			Dummy_L_Clavice.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_R_Clavice && Dummy_R_Clavice.gameObject.activeSelf != isHide)
		{
			Dummy_R_Clavice.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_L_Crotch && Dummy_L_Crotch.gameObject.activeSelf != isHide)
		{
			Dummy_L_Crotch.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_R_Crotch && Dummy_R_Crotch.gameObject.activeSelf != isHide)
		{
			Dummy_R_Crotch.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_Chest && Dummy_Chest.gameObject.activeSelf != isHide)
		{
			Dummy_Chest.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_Head && Dummy_Head.gameObject.activeSelf != isHide)
		{
			Dummy_Head.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_Bottom && Dummy_Bottom.gameObject.activeSelf != isHide)
		{
			Dummy_Bottom.gameObject.SetActive(isHide);
		}
		if ((bool)Dummy_Shadow && Dummy_Shadow.gameObject.activeSelf != isHide)
		{
			Dummy_Shadow.gameObject.SetActive(isHide);
		}
	}

	[ContextMenu("Auto Set Bone Dummy")]
	public void SetValue()
	{
		animator = GetComponent<Animator>();
		GameObject gameObject = FindHideChildGameObject(base.gameObject, "Hips");
		if (gameObject != null)
		{
			hips = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Bip001 Spine1");
		if (gameObject != null)
		{
			upperBody = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_R_Hand");
		if (gameObject != null)
		{
			rightHandHook = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_L_Hand");
		if (gameObject != null)
		{
			leftHandHook = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_L_Foot");
		if (gameObject != null)
		{
			Dummy_L_Foot = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_R_Foot");
		if (gameObject != null)
		{
			Dummy_R_Foot = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_L_Clavicle");
		if (gameObject != null)
		{
			Dummy_L_Clavice = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_R_Clavicle");
		if (gameObject != null)
		{
			Dummy_R_Clavice = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_L_Crotch");
		if (gameObject != null)
		{
			Dummy_L_Crotch = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_R_Crotch");
		if (gameObject != null)
		{
			Dummy_R_Crotch = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_Spine1");
		if (gameObject != null)
		{
			Dummy_Chest = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_Head");
		if (gameObject != null)
		{
			Dummy_Head = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Dummy_Origin");
		if (gameObject != null)
		{
			Dummy_Bottom = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Shoot");
		if (gameObject != null)
		{
			Dummy_Muzzle = gameObject.transform;
		}
		gameObject = FindHideChildGameObject(base.gameObject, "Shell");
		if (gameObject != null)
		{
			Dummy_Barrel = gameObject.transform;
		}
	}

	public static GameObject FindHideChildGameObject(GameObject parent, string childName)
	{
		if (parent.name == childName)
		{
			return parent;
		}
		if (parent.transform.childCount < 1)
		{
			return null;
		}
		GameObject gameObject = null;
		for (int i = 0; i < parent.transform.childCount; i++)
		{
			gameObject = FindHideChildGameObject(parent.transform.GetChild(i).gameObject, childName);
			if (gameObject != null)
			{
				break;
			}
		}
		return gameObject;
	}
}
