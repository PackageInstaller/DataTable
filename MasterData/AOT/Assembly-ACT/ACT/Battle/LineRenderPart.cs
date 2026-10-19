using System;

namespace ACT.Battle;

[Serializable]
public struct LineRenderPart
{
	public string name;

	public MonoLineEffect monoLineRender;

	public string muzzleAttachPointName;
}
