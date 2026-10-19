using System;
using UnityEngine;

public class RendererBlockContorlData
{
	[Serializable]
	public class ShaderProperty
	{
		[SerializeField]
		private string m_name;

		[SerializeField]
		private bool m_dirt;

		[SerializeField]
		private RendererBlockControl.PropertyType m_type;

		[SerializeField]
		private float m_floatValue;

		[SerializeField]
		private Vector4 m_vectorValue;

		[SerializeField]
		[ColorUsage(true, true)]
		private Color m_colorValue;

		public string name => m_name;

		public float floatValue => m_floatValue;

		public Vector4 vectorValue => m_vectorValue;

		public Color colorValue => m_colorValue;

		public RendererBlockControl.PropertyType type => m_type;

		public ShaderProperty(string PropName, RendererBlockControl.PropertyType PropType)
		{
			m_name = PropName;
			m_type = PropType;
			m_dirt = true;
		}

		public void setFloatValue(float inputValue)
		{
			m_floatValue = inputValue;
			m_dirt = true;
		}

		public void setVectorValue(Vector4 inputValue)
		{
			m_vectorValue = inputValue;
			m_dirt = true;
		}

		public void setColorValue(Color inputValue)
		{
			m_colorValue = inputValue;
			m_dirt = true;
		}

		public void setDirt(bool isDirt)
		{
			m_dirt = isDirt;
		}

		public bool isDirt()
		{
			return m_dirt;
		}
	}
}
