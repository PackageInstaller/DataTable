using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;
using UnityEngine.Rendering;

public class QWCharacterProxy : MonoBehaviour
{
	public int charId;

	public const string ATTACH_POINT_PREFIX = "gua_";

	public SDCharacter renderEffect;

	public Transform head;

	public Dictionary<string, Transform> attachPoints;

	public SkinnedMeshRenderer[] smrs;

	public Animator animator;

	public Transform CameraFocus;

	public Transform DefaultCamPos;

	public CapsuleCollider BodyCollider;

	public QWNPCMoveComponent moveComponent;

	[NonSerialized]
	public Action animatorMoveDelgate;

	[NonSerialized]
	public QWAgent agent;

	private bool shadowEnabled;

	public List<string> IdleAnim;

	public void EnableShadow(bool enable)
	{
		if (shadowEnabled == enable)
		{
			return;
		}
		shadowEnabled = enable;
		for (int i = 0; i < smrs.Length; i++)
		{
			if (!(smrs[i] == null))
			{
				smrs[i].shadowCastingMode = (enable ? ShadowCastingMode.On : ShadowCastingMode.Off);
			}
		}
	}

	private void CollectAttachPoints(Dictionary<string, Transform> attachPoints, Transform trans)
	{
		if (trans.name.StartsWith("gua_"))
		{
			attachPoints.Add(trans.name, trans);
		}
		foreach (Transform tran in trans)
		{
			CollectAttachPoints(attachPoints, tran);
		}
	}

	internal Transform FindAttachPoint(string path)
	{
		if (attachPoints == null)
		{
			attachPoints = new Dictionary<string, Transform>();
			CollectAttachPoints(attachPoints, base.transform);
		}
		if (!string.IsNullOrEmpty(path) && attachPoints.TryGetValue(path, out var value))
		{
			return value;
		}
		return base.transform;
	}

	public void BackWait()
	{
		base.gameObject.transform.localScale = Vector3.zero;
		moveComponent.animatorMoveDelgate = null;
		animator.SetActive(bActive: false);
		EnableShadow(enable: false);
	}

	public void EnterActive()
	{
		base.gameObject.transform.localScale = Vector3.one;
		moveComponent.animatorMoveDelgate = OnAnimatorMove;
		animator.SetActive(bActive: true);
		EnableShadow(enable: true);
	}

	private void OnAnimatorMove()
	{
		animatorMoveDelgate?.Invoke();
	}
}
