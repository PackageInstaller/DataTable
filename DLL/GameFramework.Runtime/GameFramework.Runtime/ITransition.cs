using System;

namespace GameFramework.Runtime;

public interface ITransition
{
	bool IsDone { get; }

	object WaitForDone();

	IAwaiter GetAwaiter();

	ITransition DisableAnimation(bool disabled);

	ITransition AtLayer(int layer);

	ITransition Overlay(Func<IWindow, IWindow, TransitionActionType> policy);

	ITransition OnStart(Action callback);

	ITransition OnStateChanged(Action<IWindow, WindowState> callback);

	ITransition OnFinish(Action callback);
}
