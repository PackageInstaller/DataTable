using MagicaCloth2;
using UnityEngine;

namespace T0World;

public class T0CaptureEntityBindMono : MonoBehaviour
{
	public Transform lookTarget;

	public Transform lookAtPoint;

	public Transform rotateModel;

	public GameObject faceBindObj;

	public Animator aniModel;

	public MagicaCapsuleCollider ditherCollider;
}
