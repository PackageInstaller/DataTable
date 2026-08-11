using GameFramework;
using UnityEngine;

public class ChangeShaderParam : IReference
{
	public float _currentValue;

	public float _targetValue;

	public float _delta;

	public float _executeTime;

	public string _currentVariableName;

	public Material _currentDissolveMaterial;

	public bool _isEndShader;

	public string _boneName;

	public int _materialRuntimeId;

	public bool _useMaterialRuntimeId;

	public bool _isRuntimeMaterialInitialized;

	public void Clear()
	{
		_currentValue = 0f;
		_targetValue = 0f;
		_delta = 0f;
		_executeTime = 0f;
		_currentVariableName = null;
		_currentDissolveMaterial = null;
		_isEndShader = false;
		_boneName = null;
		_materialRuntimeId = 0;
		_useMaterialRuntimeId = false;
		_isRuntimeMaterialInitialized = false;
	}
}
