using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

[Serializable]
public class PageInputActionRes : ScriptableObject
{
	public string pageName;

	public EInputActiveType activeType = EInputActiveType.TopPage;

	public bool canBeTop = true;

	public List<InputActionRes> inputActions;
}
