using UnityEngine;

namespace Cinemachine;

[ExecuteAlways]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/api/Cinemachine.GroupWeightManipulator.html")]
[RequireComponent(typeof(CinemachineTargetGroup))]
public class GroupWeightManipulator : MonoBehaviour
{
	[Tooltip("The weight of the group member at index 0")]
	public float m_Weight0 = 1f;

	[Tooltip("The weight of the group member at index 1")]
	public float m_Weight1 = 1f;

	[Tooltip("The weight of the group member at index 2")]
	public float m_Weight2 = 1f;

	[Tooltip("The weight of the group member at index 3")]
	public float m_Weight3 = 1f;

	[Tooltip("The weight of the group member at index 4")]
	public float m_Weight4 = 1f;

	[Tooltip("The weight of the group member at index 5")]
	public float m_Weight5 = 1f;

	[Tooltip("The weight of the group member at index 6")]
	public float m_Weight6 = 1f;

	[Tooltip("The weight of the group member at index 7")]
	public float m_Weight7 = 1f;

	private CinemachineTargetGroup m_group;

	private void Start()
	{
		m_group = GetComponent<CinemachineTargetGroup>();
	}

	private void OnValidate()
	{
		m_Weight0 = Mathf.Max(0f, m_Weight0);
		m_Weight1 = Mathf.Max(0f, m_Weight1);
		m_Weight2 = Mathf.Max(0f, m_Weight2);
		m_Weight3 = Mathf.Max(0f, m_Weight3);
		m_Weight4 = Mathf.Max(0f, m_Weight4);
		m_Weight5 = Mathf.Max(0f, m_Weight5);
		m_Weight6 = Mathf.Max(0f, m_Weight6);
		m_Weight7 = Mathf.Max(0f, m_Weight7);
	}

	private void Update()
	{
		if (m_group != null)
		{
			UpdateWeights();
		}
	}

	private void UpdateWeights()
	{
		CinemachineTargetGroup.Target[] targets = m_group.m_Targets;
		int num = targets.Length - 1;
		if (num < 0)
		{
			return;
		}
		targets[0].weight = m_Weight0;
		if (num < 1)
		{
			return;
		}
		targets[1].weight = m_Weight1;
		if (num < 2)
		{
			return;
		}
		targets[2].weight = m_Weight2;
		if (num < 3)
		{
			return;
		}
		targets[3].weight = m_Weight3;
		if (num < 4)
		{
			return;
		}
		targets[4].weight = m_Weight4;
		if (num < 5)
		{
			return;
		}
		targets[5].weight = m_Weight5;
		if (num >= 6)
		{
			targets[6].weight = m_Weight6;
			if (num >= 7)
			{
				targets[7].weight = m_Weight7;
			}
		}
	}
}
