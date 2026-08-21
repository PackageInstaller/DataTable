using System.Runtime.ExceptionServices;
using System.Threading;

namespace System;

internal class LazyHelper
{
	internal static readonly LazyHelper NoneViaConstructor = new LazyHelper(LazyState.NoneViaConstructor);

	internal static readonly LazyHelper NoneViaFactory = new LazyHelper(LazyState.NoneViaFactory);

	internal static readonly LazyHelper PublicationOnlyViaConstructor = new LazyHelper(LazyState.PublicationOnlyViaConstructor);

	internal static readonly LazyHelper PublicationOnlyViaFactory = new LazyHelper(LazyState.PublicationOnlyViaFactory);

	internal static readonly LazyHelper PublicationOnlyWaitForOtherThreadToPublish = new LazyHelper(LazyState.PublicationOnlyWait);

	private readonly ExceptionDispatchInfo _exceptionDispatch;

	internal LazyState State { get; }

	internal LazyHelper(LazyState state)
	{
		State = state;
	}

	internal LazyHelper(LazyThreadSafetyMode mode, Exception exception)
	{
		switch (mode)
		{
		case LazyThreadSafetyMode.ExecutionAndPublication:
			State = LazyState.ExecutionAndPublicationException;
			break;
		case LazyThreadSafetyMode.None:
			State = LazyState.NoneException;
			break;
		case LazyThreadSafetyMode.PublicationOnly:
			State = LazyState.PublicationOnlyException;
			break;
		}
		_exceptionDispatch = ExceptionDispatchInfo.Capture(exception);
	}

	internal void ThrowException()
	{
		_exceptionDispatch.Throw();
	}

	private LazyThreadSafetyMode GetMode()
	{
		switch (State)
		{
		case LazyState.NoneViaConstructor:
		case LazyState.NoneViaFactory:
		case LazyState.NoneException:
			return LazyThreadSafetyMode.None;
		case LazyState.PublicationOnlyViaConstructor:
		case LazyState.PublicationOnlyViaFactory:
		case LazyState.PublicationOnlyWait:
		case LazyState.PublicationOnlyException:
			return LazyThreadSafetyMode.PublicationOnly;
		case LazyState.ExecutionAndPublicationViaConstructor:
		case LazyState.ExecutionAndPublicationViaFactory:
		case LazyState.ExecutionAndPublicationException:
			return LazyThreadSafetyMode.ExecutionAndPublication;
		default:
			return LazyThreadSafetyMode.None;
		}
	}

	internal static LazyThreadSafetyMode? GetMode(LazyHelper state)
	{
		return state?.GetMode();
	}

	internal static bool GetIsValueFaulted(LazyHelper state)
	{
		return state?._exceptionDispatch != null;
	}

	internal static LazyHelper Create(LazyThreadSafetyMode mode, bool useDefaultConstructor)
	{
		switch (mode)
		{
		case LazyThreadSafetyMode.None:
			if (!useDefaultConstructor)
			{
				return NoneViaFactory;
			}
			return NoneViaConstructor;
		case LazyThreadSafetyMode.PublicationOnly:
			if (!useDefaultConstructor)
			{
				return PublicationOnlyViaFactory;
			}
			return PublicationOnlyViaConstructor;
		case LazyThreadSafetyMode.ExecutionAndPublication:
			return new LazyHelper(useDefaultConstructor ? LazyState.ExecutionAndPublicationViaConstructor : LazyState.ExecutionAndPublicationViaFactory);
		default:
			throw new ArgumentOutOfRangeException("mode", "The mode argument specifies an invalid value.");
		}
	}

	internal static object CreateViaDefaultConstructor(Type type)
	{
		try
		{
			return Activator.CreateInstance(type);
		}
		catch (MissingMethodException)
		{
			throw new MissingMemberException("The lazily-initialized type does not have a public, parameterless constructor.");
		}
	}

	internal static LazyThreadSafetyMode GetModeFromIsThreadSafe(bool isThreadSafe)
	{
		if (!isThreadSafe)
		{
			return LazyThreadSafetyMode.None;
		}
		return LazyThreadSafetyMode.ExecutionAndPublication;
	}
}
