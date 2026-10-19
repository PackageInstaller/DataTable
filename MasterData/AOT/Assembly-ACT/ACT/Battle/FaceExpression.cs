using System.Collections.Generic;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public class FaceExpression : MonoBehaviour
{
	public SkinnedMeshRenderer skin;

	protected ConfigBlendShapes m_blendConfig;

	private Dictionary<string, int> m_BlendNames = new Dictionary<string, int>();

	private float[] m_CurWeights;

	public Animator animator;

	private float m_Timer;

	private bool IsNeedChage;

	private void Start()
	{
		int blendShapeCount = skin.sharedMesh.blendShapeCount;
		for (int i = 0; i < blendShapeCount; i++)
		{
			string blendShapeName = skin.sharedMesh.GetBlendShapeName(i);
			m_BlendNames.Add(blendShapeName, i);
		}
	}

	public void ChangeFace(ConfigBlendShapes blendConfig, int? hash = null)
	{
		m_blendConfig = blendConfig;
		m_Timer = m_blendConfig.time;
		if (blendConfig.playMode == FacePlayMode.BlendShape)
		{
			ConfigBlendShapes.blendShape[] blendShapes = blendConfig.blendShapes;
			m_CurWeights = new float[blendShapes.Length];
			for (int i = 0; i < blendShapes.Length; i++)
			{
				ConfigBlendShapes.blendShape blendShape = blendShapes[i];
				int index = m_BlendNames[blendShape.shapeName];
				m_CurWeights[i] = skin.GetBlendShapeWeight(index);
			}
		}
		else if (!hash.HasValue)
		{
			animator.Play(blendConfig.name, blendConfig.layer);
		}
		else
		{
			animator.Play(hash.Value, blendConfig.layer);
		}
		IsNeedChage = true;
	}

	private void UpdateWeight()
	{
		ConfigBlendShapes.blendShape[] blendShapes = m_blendConfig.blendShapes;
		for (int i = 0; i < blendShapes.Length; i++)
		{
			ConfigBlendShapes.blendShape blendShape = blendShapes[i];
			int index = m_BlendNames[blendShape.shapeName];
			float value = skin.GetBlendShapeWeight(index) + ((float)blendShape.weight - m_CurWeights[i]) * (Time.deltaTime / m_blendConfig.time);
			skin.SetBlendShapeWeight(index, value);
		}
	}

	private void Update()
	{
		if (!IsNeedChage)
		{
			return;
		}
		if (m_blendConfig.playMode == FacePlayMode.BlendShape)
		{
			if (m_Timer > 0f)
			{
				UpdateWeight();
				m_Timer -= Time.deltaTime;
			}
			else
			{
				ChangeToDefault();
			}
		}
		else if (m_blendConfig.IsChangeToDefult)
		{
			if (m_Timer > 0f)
			{
				m_Timer -= Time.deltaTime;
				return;
			}
			animator.Play("default");
			IsNeedChage = false;
		}
	}

	private void ChangeToDefault()
	{
		ConfigBlendShapes.blendShape[] blendShapes = m_blendConfig.blendShapes;
		for (int i = 0; i < blendShapes.Length; i++)
		{
			ConfigBlendShapes.blendShape blendShape = blendShapes[i];
			if (blendShape.changeToDefult)
			{
				int index = m_BlendNames[blendShape.shapeName];
				skin.SetBlendShapeWeight(index, m_CurWeights[i]);
			}
		}
		IsNeedChage = false;
	}
}
