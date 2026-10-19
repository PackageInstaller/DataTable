using System.Collections.Generic;
using UnityEngine;

[DefaultExecutionOrder(200)]
[ExecuteInEditMode]
public class FaceDirect : MonoBehaviour
{
	public GameObject targetBone;

	public GameObject Face;

	public GameObject Hair;

	private MaterialPropertyBlock m_Block;

	private Renderer faceRenderer;

	private Transform trans;

	private Transform m_trans;

	private RendererBlockControl control;

	private RendererBlockContorlData.ShaderProperty m_ForwardProperty;

	private RendererBlockContorlData.ShaderProperty m_RightProperty;

	private RendererBlockContorlData.ShaderProperty m_PosProperty;

	private GameObject[] goList;

	private List<Renderer> renderList;

	public bool IsMainCharacter;

	private bool m_HasBlockOverride;

	private void EnsureMaterialPropertyBlock()
	{
		if (m_Block == null)
		{
			m_Block = new MaterialPropertyBlock();
		}
	}

	public void setControl(RendererBlockControl blockControl)
	{
		control = blockControl;
	}

	public void removeControl()
	{
		control = null;
		m_ForwardProperty = null;
		m_RightProperty = null;
		m_PosProperty = null;
	}

	private void Awake()
	{
		EnsureMaterialPropertyBlock();
		if (targetBone != null)
		{
			trans = targetBone.GetComponent<Transform>();
		}
		m_trans = GetComponent<Transform>();
		faceRenderer = ((Face != null) ? Face.GetComponent<Renderer>() : null);
		goList = new GameObject[2] { Face, Hair };
		renderList = new List<Renderer>();
		GameObject[] array = goList;
		foreach (GameObject gameObject in array)
		{
			if (!(gameObject != null))
			{
				continue;
			}
			Renderer[] components = gameObject.GetComponents<Renderer>();
			foreach (Renderer item in components)
			{
				if (!renderList.Contains(item))
				{
					renderList.Add(item);
				}
			}
		}
	}

	private void GetProps()
	{
		control.GetProperty("_ShadowForward", out m_ForwardProperty, RendererBlockControl.PropertyType.Vector);
		control.GetProperty("_ShadowRight", out m_RightProperty, RendererBlockControl.PropertyType.Vector);
		control.GetProperty("_FacePos", out m_PosProperty, RendererBlockControl.PropertyType.Vector);
	}

	private void SetProps(Vector3 front, Vector3 right, Vector3 pos)
	{
		m_ForwardProperty.setVectorValue(front);
		m_RightProperty.setVectorValue(right);
		m_PosProperty.setVectorValue(pos);
	}

	private void Update()
	{
		if (IsMainCharacter)
		{
			Vector3 position = m_trans.position;
			Shader.SetGlobalVector("_MainCharacterPosWS", position);
		}
		if (faceRenderer == null || !trans)
		{
			return;
		}
		Vector3 up = trans.up;
		Vector3 vector = -trans.forward;
		Vector3 center = faceRenderer.bounds.center;
		if (control == null)
		{
			if (renderList == null)
			{
				return;
			}
			EnsureMaterialPropertyBlock();
			foreach (Renderer render in renderList)
			{
				m_Block.Clear();
				render.GetPropertyBlock(m_Block);
				m_Block.SetVector("_ShadowForward", up);
				m_Block.SetVector("_ShadowRight", vector);
				m_Block.SetVector("_FacePos", center);
				render.SetPropertyBlock(m_Block);
			}
			m_HasBlockOverride = true;
		}
		else
		{
			if (m_HasBlockOverride)
			{
				releaseBlock();
			}
			if (m_ForwardProperty == null)
			{
				GetProps();
			}
			SetProps(up, vector, center);
		}
	}

	private void releaseBlock()
	{
		m_HasBlockOverride = false;
	}

	private void OnDestroy()
	{
		releaseBlock();
		if (control != null)
		{
			control.RemoveProperty(m_ForwardProperty);
			control.RemoveProperty(m_RightProperty);
			control.RemoveProperty(m_PosProperty);
			m_ForwardProperty = null;
			m_RightProperty = null;
			m_PosProperty = null;
		}
	}

	public void GetFaceAndBone()
	{
		Transform[] componentsInChildren = gameObject.GetComponentsInChildren<Transform>();
		foreach (Transform transform in componentsInChildren)
		{
			if (transform.name.EndsWith("Face"))
			{
				Face = transform.gameObject;
				Debug.Log("设置面部Obj为  " + transform.gameObject.name);
			}
			if (transform.name.EndsWith("Head"))
			{
				targetBone = transform.gameObject;
				Debug.Log("设置面部朝向目标骨骼为   " + transform.gameObject.name);
			}
		}
	}
}
