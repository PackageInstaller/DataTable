using Spine;
using Spine.Unity;
using UnityEngine;

namespace Ase;

public class BoardpartFollower : MonoBehaviour
{
	[HideInInspector]
	public GameObject FollowRoot;

	[SerializeField]
	[HideInInspector]
	private string partId;

	[SerializeField]
	private bool followBoneScale = true;

	private SkeletonGraphic skeletonGraphic;

	private Bone bone;

	private Vector3 scaleOffset = Vector3.one;

	[SerializeField]
	private Quaternion quaternionOffset = Quaternion.identity;

	private Vector3 positionOffset = Vector3.zero;

	public string PartId => partId;

	public void AssginPartId(string partId)
	{
		this.partId = partId;
	}

	public void AssignSkeletonRoot(GameObject root)
	{
		if (root != null)
		{
			FollowRoot = root;
		}
	}

	private void Start()
	{
		ResolveFollowTarget();
	}

	private void ResolveFollowTarget()
	{
		if (FollowRoot != null)
		{
			skeletonGraphic = FollowRoot.GetComponent<SkeletonGraphic>();
			if ((Object)(object)skeletonGraphic != null && skeletonGraphic.Skeleton != null)
			{
				bone = skeletonGraphic.Skeleton.FindBone(partId);
			}
		}
	}

	private bool TryGetFollowPose(out Vector3 position, out Quaternion rotation, out Vector3 localScale)
	{
		if ((Object)(object)skeletonGraphic == null || bone == null)
		{
			ResolveFollowTarget();
		}
		if ((Object)(object)skeletonGraphic == null || bone == null)
		{
			position = base.transform.position;
			rotation = base.transform.rotation;
			localScale = base.transform.localScale;
			return false;
		}
		float meshScale = skeletonGraphic.MeshScale;
		Vector3 vector = ((Component)(object)skeletonGraphic).transform.TransformPoint(new Vector3(bone.WorldX * meshScale, bone.WorldY * meshScale, 0f));
		float worldRotationX = bone.WorldRotationX;
		Vector3 eulerAngles = ((Component)(object)skeletonGraphic).transform.rotation.eulerAngles;
		Vector3 eulerAngles2 = quaternionOffset.eulerAngles;
		position = vector + positionOffset;
		rotation = Quaternion.Euler(eulerAngles.x + eulerAngles2.x, eulerAngles.y + eulerAngles2.y, eulerAngles.z + worldRotationX + eulerAngles2.z);
		localScale = (followBoneScale ? new Vector3(scaleOffset.x * bone.WorldScaleX, scaleOffset.y * bone.WorldScaleY, scaleOffset.z) : scaleOffset);
		return true;
	}

	private void LateUpdate()
	{
		if (TryGetFollowPose(out var position, out var rotation, out var localScale))
		{
			base.transform.SetPositionAndRotation(position, rotation);
			base.transform.localScale = localScale;
		}
	}
}
