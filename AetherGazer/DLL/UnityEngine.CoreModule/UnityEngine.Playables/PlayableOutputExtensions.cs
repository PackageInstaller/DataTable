using System;

namespace UnityEngine.Playables;

public static class PlayableOutputExtensions
{
	public static bool IsOutputNull<U>(this U output) where U : struct, IPlayableOutput
	{
		return output.GetHandle().IsNull();
	}

	public static bool IsOutputValid<U>(this U output) where U : struct, IPlayableOutput
	{
		return output.GetHandle().IsValid();
	}

	public static Object GetReferenceObject<U>(this U output) where U : struct, IPlayableOutput
	{
		return output.GetHandle().GetReferenceObject();
	}

	public static void SetReferenceObject<U>(this U output, Object value) where U : struct, IPlayableOutput
	{
		output.GetHandle().SetReferenceObject(value);
	}

	public static Object GetUserData<U>(this U output) where U : struct, IPlayableOutput
	{
		return output.GetHandle().GetUserData();
	}

	public static void SetUserData<U>(this U output, Object value) where U : struct, IPlayableOutput
	{
		output.GetHandle().SetUserData(value);
	}

	public static Playable GetSourcePlayable<U>(this U output) where U : struct, IPlayableOutput
	{
		return new Playable(output.GetHandle().GetSourcePlayable());
	}

	public static void SetSourcePlayable<U, V>(this U output, V value) where U : struct, IPlayableOutput where V : struct, IPlayable
	{
		output.GetHandle().SetSourcePlayable(value.GetHandle(), output.GetSourceOutputPort());
	}

	public static void SetSourcePlayable<U, V>(this U output, V value, int port) where U : struct, IPlayableOutput where V : struct, IPlayable
	{
		output.GetHandle().SetSourcePlayable(value.GetHandle(), port);
	}

	public static int GetSourceOutputPort<U>(this U output) where U : struct, IPlayableOutput
	{
		return output.GetHandle().GetSourceOutputPort();
	}

	public static float GetWeight<U>(this U output) where U : struct, IPlayableOutput
	{
		return output.GetHandle().GetWeight();
	}

	public static void SetWeight<U>(this U output, float value) where U : struct, IPlayableOutput
	{
		output.GetHandle().SetWeight(value);
	}

	public static void PushNotification<U>(this U output, Playable origin, INotification notification, object context = null) where U : struct, IPlayableOutput
	{
		output.GetHandle().PushNotification(origin.GetHandle(), notification, context);
	}

	public static INotificationReceiver[] GetNotificationReceivers<U>(this U output) where U : struct, IPlayableOutput
	{
		return output.GetHandle().GetNotificationReceivers();
	}

	public static void AddNotificationReceiver<U>(this U output, INotificationReceiver receiver) where U : struct, IPlayableOutput
	{
		output.GetHandle().AddNotificationReceiver(receiver);
	}

	public static void RemoveNotificationReceiver<U>(this U output, INotificationReceiver receiver) where U : struct, IPlayableOutput
	{
		output.GetHandle().RemoveNotificationReceiver(receiver);
	}

	[Obsolete("Method GetSourceInputPort has been renamed to GetSourceOutputPort (UnityUpgradable) -> GetSourceOutputPort<U>(*)", false)]
	public static int GetSourceInputPort<U>(this U output) where U : struct, IPlayableOutput
	{
		return output.GetHandle().GetSourceOutputPort();
	}

	[Obsolete("Method SetSourceInputPort has been deprecated. Use SetSourcePlayable(Playable, Port) instead.", false)]
	public static void SetSourceInputPort<U>(this U output, int value) where U : struct, IPlayableOutput
	{
		output.SetSourcePlayable(output.GetSourcePlayable(), value);
	}

	[Obsolete("Method SetSourceOutputPort has been deprecated. Use SetSourcePlayable(Playable, Port) instead.", false)]
	public static void SetSourceOutputPort<U>(this U output, int value) where U : struct, IPlayableOutput
	{
		output.SetSourcePlayable(output.GetSourcePlayable(), value);
	}
}
