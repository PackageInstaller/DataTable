using System;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TouchUIMaskEnergyComponent : MonoBehaviour
{
	public bool oneMinus;

	public GameObject root;

	public Image imageUI;

	public Slider sliderUI;

	public GameObject imageFill;

	public GameObject imageFillComplete;

	public Animator animator;

	[NonSerialized]
	public bool filled;

	public void SetFill(bool isFill)
	{
		filled = isFill;
	}
}
