using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

public interface IGraphWithVariables : IGraph, IDisposable, IPrewarmable, IAotStubbable, ISerializationDepender, ISerializationCallbackReceiver
{
	VariableDeclarations variables { get; }

	IEnumerable<string> GetDynamicVariableNames(VariableKind kind, GraphReference reference);
}
