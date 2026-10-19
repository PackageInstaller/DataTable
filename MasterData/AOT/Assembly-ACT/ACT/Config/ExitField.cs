using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class ExitField
{
	[SerializeField]
	private Vector3 _size;

	[SerializeField]
	private Vector3 _center;

	[SerializeField]
	private string _name;

	[SerializeField]
	private Vector3 _localPos;

	[SerializeField]
	private Quaternion _localRot;

	[SerializeField]
	private Vector3 _localScale;

	public Vector3 Size => _size;

	public Vector3 Center => _center;

	public string Name => _name;

	public Vector3 LocalPos => _localPos;

	public Quaternion LocalRot => _localRot;

	public Vector3 LocalScale => _localScale;

	public void CopyTo(BoxCollider boxCollider, Transform transform)
	{
		boxCollider.center = _center;
		boxCollider.size = _size;
		boxCollider.name = _name;
		transform.localPosition = _localPos;
		transform.localRotation = _localRot;
		transform.localScale = _localScale;
	}
}
