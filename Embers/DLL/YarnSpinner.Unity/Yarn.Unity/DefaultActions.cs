using System;
using System.Collections;
using UnityEngine;

namespace Yarn.Unity;

internal class DefaultActions : MonoBehaviour
{
	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
	public static void AddRegisterFunction()
	{
		Actions.AddRegistrationMethod(RegisterActions);
	}

	public static void RegisterActions(IActionRegistration target)
	{
		target.AddCommandHandler("wait", (Func<float, IEnumerator>)Wait);
	}

	[YarnCommand("wait")]
	public static IEnumerator Wait(float duration)
	{
		yield return new WaitForSeconds(duration / DialogueGlobals.Speed);
	}
}
