using System;
using UnityEngine;

namespace ACT;

[Serializable]
public class GraphicGradePreset
{
	[SerializeField]
	private GraphicPresetLevel _grade;

	[SerializeField]
	private GraphicSettingPreset[] _graphicPresets;

	public GraphicPresetLevel GradeLevel => _grade;

	public GraphicSettingPreset[] GraphicPresets => _graphicPresets;
}
