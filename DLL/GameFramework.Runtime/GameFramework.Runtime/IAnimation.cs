using System;

namespace GameFramework.Runtime;

public interface IAnimation
{
	IAnimation OnStart(Action onStart);

	IAnimation OnEnd(Action onEnd);

	IAnimation Play();
}
