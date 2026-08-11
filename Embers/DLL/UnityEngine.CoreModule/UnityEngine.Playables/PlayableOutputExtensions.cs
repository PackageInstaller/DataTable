namespace UnityEngine.Playables;

public static class PlayableOutputExtensions
{
	public static void SetReferenceObject<U>(this U output, Object value) where U : struct, IPlayableOutput
	{
		output.GetHandle().SetReferenceObject(value);
	}

	public static void SetUserData<U>(this U output, Object value) where U : struct, IPlayableOutput
	{
		output.GetHandle().SetUserData(value);
	}

	public static Playable GetSourcePlayable<U>(this U output) where U : struct, IPlayableOutput
	{
		return new Playable(output.GetHandle().GetSourcePlayable());
	}

	public static void SetSourcePlayable<U, V>(this U output, V value, int port) where U : struct, IPlayableOutput where V : struct, IPlayable
	{
		output.GetHandle().SetSourcePlayable(value.GetHandle(), port);
	}

	public static int GetSourceOutputPort<U>(this U output) where U : struct, IPlayableOutput
	{
		return output.GetHandle().GetSourceOutputPort();
	}

	public static void SetWeight<U>(this U output, float value) where U : struct, IPlayableOutput
	{
		output.GetHandle().SetWeight(value);
	}

	public static void PushNotification<U>(this U output, Playable origin, INotification notification, object context = null) where U : struct, IPlayableOutput
	{
		output.GetHandle().PushNotification(origin.GetHandle(), notification, context);
	}

	public static void AddNotificationReceiver<U>(this U output, INotificationReceiver receiver) where U : struct, IPlayableOutput
	{
		output.GetHandle().AddNotificationReceiver(receiver);
	}
}
