using System;
using ACT.Battle;
using UnityEngine;

namespace Runtime.World.StateObject.Behave;

public class ConveyorBeltModel : MonoBehaviour
{
	[SerializeField]
	private MeshRenderer _meshRenderer;

	[SerializeField]
	private Transform _signRoot;

	[SerializeField]
	private Animator _animator;

	private MaterialPropertyBlock _block;

	private readonly Vector3 _leftScale = new Vector3(1f, 1f, 1f);

	private readonly Vector3 _rightScale = new Vector3(-1f, 1f, 1f);

	private Vector4 _uvOffset = new Vector4(1f, 1f, 0f, 0f);

	public void Init()
	{
		_block = new MaterialPropertyBlock();
	}

	public void OnChangeState(int currentStateId)
	{
		_animator.enabled = currentStateId == 0 || currentStateId == 1;
	}

	public void UpdateValue(float velocity, bool left)
	{
		_uvOffset.z += velocity * Time.deltaTime / 2f;
		_uvOffset.z -= MathF.Floor(_uvOffset.z);
		_block?.SetVector(BattleConsts.SHAER_EFFECT_BELTOFFSET, _uvOffset);
		if (_meshRenderer != null)
		{
			_meshRenderer.SetPropertyBlock(_block);
		}
		if (_signRoot != null)
		{
			_signRoot.localScale = (left ? _leftScale : _rightScale);
		}
	}

	private void OnDestroy()
	{
		_block?.Clear();
	}
}
