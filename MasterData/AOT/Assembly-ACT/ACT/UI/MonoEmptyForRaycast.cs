using ACT.Battle;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.UI;
using UnityEngine.UI;

namespace ACT.UI;

[RequireComponent(typeof(CanvasRenderer))]
public class MonoEmptyForRaycast : MaskableGraphic
{
	private InputSystemUIInputModule _inputModule;

	[SerializeField]
	private UnityEvent _onSubmit;

	protected MonoEmptyForRaycast()
	{
		useLegacyMeshGeneration = false;
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (Application.isPlaying)
		{
			_inputModule = MonoECS.instance.inputModule;
			if (_inputModule != null && _inputModule.submit != null)
			{
				_inputModule.submit.action.performed -= OnSubmit;
				_inputModule.submit.action.performed += OnSubmit;
			}
		}
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		if (_inputModule != null && _inputModule.submit != null)
		{
			_inputModule.submit.action.performed -= OnSubmit;
		}
	}

	private void OnSubmit(InputAction.CallbackContext callbackContext)
	{
		_onSubmit?.Invoke();
	}

	protected override void OnPopulateMesh(VertexHelper toFill)
	{
		toFill.Clear();
	}
}
