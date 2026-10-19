using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/InteractRule")]
public class InteractRuleBaker : MonoDataBaker
{
	[SerializeField]
	public DataBaker<InteractRule> dataBaker = new DataBaker<InteractRule>();

	public override IDataBaker Baker => dataBaker;
}
