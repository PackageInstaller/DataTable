using System;

namespace Unity.VisualScripting;

public sealed class UnitRelation : IUnitRelation, IConnection<IUnitPort, IUnitPort>
{
	public IUnitPort source { get; }

	public IUnitPort destination { get; }

	public UnitRelation(IUnitPort source, IUnitPort destination)
	{
		Ensure.That("source").IsNotNull(source);
		Ensure.That("destination").IsNotNull(destination);
		if (source.unit != destination.unit)
		{
			throw new NotSupportedException("Cannot create relations across nodes.");
		}
		this.source = source;
		this.destination = destination;
	}
}
