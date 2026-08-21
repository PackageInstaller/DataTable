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
}
