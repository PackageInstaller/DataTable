using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using Bamboo.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.DialogueSystem;

public class DialogueEnvironment : MonoBehaviour
{
	[Serializable]
	public class BindingValue
	{
		public string key;

		public BindingValueType valueType;

		public UnityEngine.Object unityObjectValue;

		public bool boolValue;

		public int intValue;

		public float floatValue;

		public string stringValue;

		public Vector2 vector2Value;

		public Vector3 vector3Value;
	}

	public enum BindingValueType
	{
		UnityObject,
		Bool,
		Int,
		Float,
		String,
		Vector2,
		Vector3
	}

	[SerializeField]
	private LuminDialogueFlowAsset m_flowAsset;

	[SerializeField]
	private CinemachineVirtualCameraBase freeCamera;

	[SerializeField]
	private List<BindingValue> m_bindingValues = new List<BindingValue>();

	[SerializeField]
	private bool m_CouldLoadScene;

	public bool CouldLoadScene => m_CouldLoadScene;

	public LuminDialogueFlowAsset FlowAsset
	{
		get
		{
			return m_flowAsset;
		}
		set
		{
			SetFlowAsset(value);
		}
	}

	private void Awake()
	{
		DisableAllCamera();
	}

	private void OnDestroy()
	{
		DisableAllCamera();
	}

	private void DisableAllCamera()
	{
		if ((bool)freeCamera)
		{
			freeCamera.LookAt = null;
			freeCamera.Follow = null;
		}
		CinemachineVirtualCameraBase[] componentsInChildren = transform.GetComponentsInChildren<CinemachineVirtualCameraBase>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.SetActive(value: false);
		}
	}

	private void SetFlowAsset(LuminDialogueFlowAsset newFlowAsset)
	{
		if (!(m_flowAsset == newFlowAsset))
		{
			DisableAllCamera();
			m_flowAsset = newFlowAsset;
		}
	}

	public async UniTask PlayAsync(LuminDialogueContext context, CancellationToken token)
	{
		if (FlowAsset == null || FlowAsset.data == null)
		{
			return;
		}
		DisableAllCamera();
		LuminDialogueFlowProcessor luminDialogueFlowProcessor = new LuminDialogueFlowProcessor(FlowAsset.data);
		try
		{
			await luminDialogueFlowProcessor.Play(context, token);
		}
		finally
		{
			if ((bool)this)
			{
				DisableAllCamera();
			}
		}
	}

	public void SetCameraState(DialogueEnvironmentCameraState state)
	{
		switch (state.type)
		{
		case DialogueEnvironmentCameraStateType.None:
			DisableAllCamera();
			break;
		case DialogueEnvironmentCameraStateType.MainRole:
			DisableAllCamera();
			if (freeCamera != null)
			{
				freeCamera.gameObject.SetActive(value: true);
				Transform rootTransform = MonoECS.instance.mainEntity.GetRootTransform();
				freeCamera.LookAt = rootTransform;
				freeCamera.Follow = rootTransform;
			}
			break;
		case DialogueEnvironmentCameraStateType.Camera:
		{
			DisableAllCamera();
			BindingValue bindingValue2 = GetBindingValue(state.key, BindingValueType.UnityObject);
			if (bindingValue2 == null)
			{
				break;
			}
			CinemachineVirtualCameraBase[] componentsInChildren = transform.GetComponentsInChildren<CinemachineVirtualCameraBase>(includeInactive: true);
			foreach (CinemachineVirtualCameraBase cinemachineVirtualCameraBase in componentsInChildren)
			{
				if (!(cinemachineVirtualCameraBase == freeCamera))
				{
					cinemachineVirtualCameraBase.gameObject.SetActive(cinemachineVirtualCameraBase.gameObject == bindingValue2.unityObjectValue as GameObject);
				}
			}
			break;
		}
		case DialogueEnvironmentCameraStateType.NPC:
		{
			DisableAllCamera();
			if (!(freeCamera != null))
			{
				break;
			}
			BindingValue bindingValue3 = GetBindingValue(state.key, BindingValueType.Int);
			if (bindingValue3 != null)
			{
				freeCamera.gameObject.SetActive(value: true);
				if (Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary.TryGetValue(bindingValue3.intValue, out var value))
				{
					Transform modelTrans = value.GetModelTrans();
					freeCamera.LookAt = modelTrans;
					freeCamera.Follow = modelTrans;
				}
			}
			break;
		}
		case DialogueEnvironmentCameraStateType.Interact:
		{
			DisableAllCamera();
			if (!(freeCamera != null))
			{
				break;
			}
			BindingValue bindingValue = GetBindingValue(state.key, BindingValueType.Int);
			if (bindingValue != null)
			{
				freeCamera.gameObject.SetActive(value: true);
				if (MonoECS.instance.ruleManager.TryGetWorldStateAsset(bindingValue.intValue, out var asset))
				{
					freeCamera.LookAt = asset.stateObjectBase.transform;
					freeCamera.Follow = asset.stateObjectBase.transform;
				}
			}
			break;
		}
		}
	}

	public BindingValue GetBindingValue(string key)
	{
		return m_bindingValues.FirstOrDefault((BindingValue item) => item.key == key);
	}

	public BindingValue GetBindingValue(string key, BindingValueType valueType)
	{
		return m_bindingValues.FirstOrDefault((BindingValue item) => item.key == key && item.valueType == valueType);
	}
}
