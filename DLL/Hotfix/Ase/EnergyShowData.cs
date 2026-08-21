using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EnergyShowData
{
	public GameObject EnergySegGobj;

	public Image EnergySegImage;

	public Animation EnergySegAnimation;

	public float EnergySegValue;

	public SegImageState SegImageState = SegImageState.Light;
}
