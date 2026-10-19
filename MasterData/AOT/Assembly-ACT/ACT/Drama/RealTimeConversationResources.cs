using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using ACT.Battle.Configs;
using ACT.Config;
using Cinemachine;
using Sirenix.OdinInspector;
using UnityEngine;

namespace ACT.Drama;

public class RealTimeConversationResources : LuminSerializedScriptableObject
{
	public List<GameObject> cinemachinePresets;

	public CinemachineBlenderSettings dialogVmBlends;

	public RuntimeAnimatorController runtimeController;

	public ConfigBlendShapes dialogExpressionConfig;

	public static IEnumerable GetEmojiIds()
	{
		FieldInfo[] info = typeof(DramaCharacterData).GetFields();
		yield return new ValueDropdownItem
		{
			Text = "默认",
			Value = 0
		};
		for (int i = 4; i < info.Length; i++)
		{
			int num = i;
			yield return new ValueDropdownItem
			{
				Text = (info[i].Name ?? ""),
				Value = num
			};
		}
	}
}
