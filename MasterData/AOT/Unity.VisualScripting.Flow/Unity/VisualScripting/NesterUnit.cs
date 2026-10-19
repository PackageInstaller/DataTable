using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[SpecialUnit]
public abstract class NesterUnit<TGraph, TMacro> : Unit, INesterUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable, IGraphNesterElement, IGraphParentElement, IGraphParent, IGraphNester where TGraph : class, IGraph, new() where TMacro : Macro<TGraph>
{
	public override bool canDefine => nest.graph != null;

	[Serialize]
	public GraphNest<TGraph, TMacro> nest { get; private set; } = new GraphNest<TGraph, TMacro>();

	[DoNotSerialize]
	IGraphNest IGraphNester.nest => nest;

	[DoNotSerialize]
	IGraph IGraphParent.childGraph => nest.graph;

	[DoNotSerialize]
	bool IGraphParent.isSerializationRoot => nest.source == GraphSource.Macro;

	[DoNotSerialize]
	UnityEngine.Object IGraphParent.serializedObject => nest.macro;

	[DoNotSerialize]
	public override IEnumerable<ISerializationDependency> deserializationDependencies => nest.deserializationDependencies;

	protected NesterUnit()
	{
		nest.nester = this;
	}

	protected NesterUnit(TMacro macro)
	{
		nest.nester = this;
		nest.macro = macro;
		nest.source = GraphSource.Macro;
	}

	public override IEnumerable<object> GetAotStubs(HashSet<object> visited)
	{
		return LinqUtility.Concat<object>(new IEnumerable[2]
		{
			base.GetAotStubs(visited),
			nest.GetAotStubs(visited)
		});
	}

	protected void CopyFrom(NesterUnit<TGraph, TMacro> source)
	{
		CopyFrom((Unit)source);
		nest = source.nest;
	}

	public abstract TGraph DefaultGraph();

	IGraph IGraphParent.DefaultGraph()
	{
		return DefaultGraph();
	}

	void IGraphNester.InstantiateNest()
	{
		InstantiateNest();
	}

	void IGraphNester.UninstantiateNest()
	{
		UninstantiateNest();
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
