using System.Diagnostics;
using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/WorldAssetComp/LaserComp")]
public class LaserComp : StateWorldAssetComp<LaserData>
{
	private void linkThoughts()
	{
		Process.Start("https://thoughts.teambition.com/workspaces/5fa92928dbaa030046a23c32/docs/634384e4b587e60001486640");
	}
}
