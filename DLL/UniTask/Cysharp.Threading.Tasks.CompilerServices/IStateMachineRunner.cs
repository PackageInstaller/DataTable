using System;

namespace Cysharp.Threading.Tasks.CompilerServices;

internal interface IStateMachineRunner
{
	Action MoveNext { get; }

	Action ReturnAction { get; }

	void Return();
}
