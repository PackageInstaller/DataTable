using System.Collections.Generic;
using UnityEngine;

namespace ACT_Instance;

[ExecuteAlways]
public class DrawInstance : MonoBehaviour
{
	private List<DrawInstanceObject> m_objectList;

	public List<DrawInstanceObject.InstanceObject> m_InstanceObjectList;

	private void OnEnable()
	{
		m_objectList = new List<DrawInstanceObject>();
		foreach (DrawInstanceObject.InstanceObject instanceObject in m_InstanceObjectList)
		{
			if (instanceObject != null)
			{
				m_objectList.Add(new DrawInstanceObject(instanceObject, cameraCull: true, VisiableCull: false));
			}
		}
		foreach (DrawInstanceObject @object in m_objectList)
		{
			@object.AddToRenderer();
		}
	}

	private void Build()
	{
		m_InstanceObjectList.Clear();
		InstanceMesh[] array = Object.FindObjectsOfType<InstanceMesh>();
		foreach (InstanceMesh go in array)
		{
			AddToList(go);
		}
	}

	public void AddToList(InstanceMesh go)
	{
		go.CreateMesh();
		m_InstanceObjectList.Add(go.m_InstanceObject);
	}

	private void OnDisable()
	{
		foreach (DrawInstanceObject @object in m_objectList)
		{
			@object.RemoveFromRenderer();
			@object.release();
		}
		m_objectList.Clear();
	}
}
