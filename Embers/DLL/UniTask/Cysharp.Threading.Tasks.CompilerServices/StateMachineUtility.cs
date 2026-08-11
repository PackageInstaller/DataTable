using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace Cysharp.Threading.Tasks.CompilerServices;

internal static class StateMachineUtility
{
	public static int GetState(IAsyncStateMachine stateMachine)
	{
		return (int)stateMachine.GetType().GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).First((FieldInfo x) => x.Name.EndsWith("__state"))
			.GetValue(stateMachine);
	}
}
