using GameFramework;

namespace Ase.ECS;

public class WarningIndicatorData : IReference
{
	public WarningIndicatorShapeData shapeData;

	public WarningIndicatorTimeData timeData;

	public WarningIndicatorCommonData commonData;

	public void Make(WarningIndicatorShapeData shapeData, WarningIndicatorTimeData timeData, WarningIndicatorCommonData commonData)
	{
		this.shapeData = shapeData;
		this.shapeData.Init(timeData);
		this.timeData = timeData;
		this.commonData = commonData;
	}

	public virtual void Clear()
	{
		ReferencePool.Release(shapeData);
		ReferencePool.Release(timeData);
		ReferencePool.Release(commonData);
	}
}
