using System;
using ACT.Model;

namespace ACT.UI;

public class BottleMatChangeWindowViewData : UIViewData
{
	public BloodBottleMaterial targetMaterial;

	public Action cancelEvt;

	public Action confirmEvt;
}
