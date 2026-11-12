using TrueSync;

namespace AIScript;

public class GridQueryParam
{
	public TSVector2 center;

	public FP range;

	public bool preferNonFlame;

	public GridQueryParam(TSVector2 center, FP range, bool preferNonFlame)
	{
		this.center = center;
		this.range = range;
		this.preferNonFlame = preferNonFlame;
	}
}
