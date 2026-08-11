using System;
using UnityEngine;

namespace Cinemachine;

[Serializable]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineBlending.html")]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public sealed class CinemachineBlenderSettings : ScriptableObject
{
	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public struct CustomBlend
	{
		[Tooltip("When blending from this camera")]
		public string m_From;

		[Tooltip("When blending to this camera")]
		public string m_To;

		[Tooltip("Blend curve definition")]
		[CinemachineBlendDefinitionProperty]
		public CinemachineBlendDefinition m_Blend;
	}

	[Tooltip("The array containing explicitly defined blends between two Virtual Cameras")]
	public CustomBlend[] m_CustomBlends;

	public const string kBlendFromAnyCameraLabel = "**ANY CAMERA**";

	public CinemachineBlendDefinition GetBlendForVirtualCameras(string fromCameraName, string toCameraName, CinemachineBlendDefinition defaultBlend)
	{
		bool flag = false;
		bool flag2 = false;
		CinemachineBlendDefinition result = defaultBlend;
		CinemachineBlendDefinition result2 = defaultBlend;
		if (m_CustomBlends != null)
		{
			for (int i = 0; i < m_CustomBlends.Length; i++)
			{
				CustomBlend customBlend = m_CustomBlends[i];
				if (customBlend.m_From == fromCameraName && customBlend.m_To == toCameraName)
				{
					return customBlend.m_Blend;
				}
				if (customBlend.m_From == "**ANY CAMERA**")
				{
					if (!string.IsNullOrEmpty(toCameraName) && customBlend.m_To == toCameraName)
					{
						if (!flag)
						{
							result = customBlend.m_Blend;
						}
						flag = true;
					}
					else if (customBlend.m_To == "**ANY CAMERA**")
					{
						defaultBlend = customBlend.m_Blend;
					}
				}
				else if (customBlend.m_To == "**ANY CAMERA**" && !string.IsNullOrEmpty(fromCameraName) && customBlend.m_From == fromCameraName)
				{
					if (!flag2)
					{
						result2 = customBlend.m_Blend;
					}
					flag2 = true;
				}
			}
		}
		if (flag)
		{
			return result;
		}
		if (flag2)
		{
			return result2;
		}
		return defaultBlend;
	}
}
