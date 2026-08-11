using System.Collections.Generic;
using UnityEngine;

namespace Yarn.Unity;

internal interface ICommandDispatcher : IActionRegistration
{
	IEnumerable<ICommand> Commands { get; }

	CommandDispatchResult DispatchCommand(string command, out Coroutine commandCoroutine);

	void SetupForProject(YarnProject yarnProject);
}
