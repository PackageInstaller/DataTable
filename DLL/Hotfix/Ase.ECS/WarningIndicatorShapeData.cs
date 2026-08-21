using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public abstract class WarningIndicatorShapeData : IReference
{
	public Color color;

	private WarningIndicatorShapeEnum _shape;

	public DRWarningIndicator DrWarningIndicator;

	public virtual WarningIndicatorShapeEnum ShapeEnum
	{
		get
		{
			return _shape;
		}
		set
		{
			_shape = value;
			DrWarningIndicator = GameEntry.DataTable.GetDataRow((DRWarningIndicator data) => data.WarningIndicatorShapeEnum == _shape);
		}
	}

	public Vector3 scale { get; set; }

	public abstract void Init(WarningIndicatorTimeData timeData);

	public virtual void Clear()
	{
	}
}
