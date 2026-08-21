using UnityEngine;

public class BuglyCallback
{
	public interface ICrashHandleListener
	{
		byte[] getCrashExtraData(bool isNativeCrashed, string crashType, string crashAddress, string crashStack, int nativeSiCode, long crashTime);

		string getCrashExtraMessage(bool isNativeCrashed, string crashType, string crashAddress, string crashStack, int nativeSiCode, long crashTime);

		void onCrashHandleStart(bool isNativeCrashed);

		bool onCrashHandleEnd(bool isNativeCrashed);

		bool onCrashSaving(bool isNativeCrashed, string crashType, string crashAddress, string crashStack, int nativeSiCode, long crashTime, string userId, string deviceId, string crashUuid, string processName);
	}

	public class ListenerAdapter : AndroidJavaProxy
	{
		private readonly ICrashHandleListener _listener;

		public ListenerAdapter(ICrashHandleListener listener)
			: base("com.tencent.feedback.eup.CrashHandleListener")
		{
			_listener = listener;
		}

		private byte[] getCrashExtraData(bool isNativeCrashed, string crashType, string crashAddress, string crashStack, int nativeSiCode, long crashTime)
		{
			return _listener.getCrashExtraData(isNativeCrashed, crashType, crashAddress, crashStack, nativeSiCode, crashTime);
		}

		private string getCrashExtraMessage(bool isNativeCrashed, string crashType, string crashAddress, string crashStack, int nativeSiCode, long crashTime)
		{
			return _listener.getCrashExtraMessage(isNativeCrashed, crashType, crashAddress, crashStack, nativeSiCode, crashTime);
		}

		private void onCrashHandleStart(bool isNativeCrashed)
		{
			_listener.onCrashHandleStart(isNativeCrashed);
		}

		private bool onCrashHandleEnd(bool isNativeCrashed)
		{
			return _listener.onCrashHandleEnd(isNativeCrashed);
		}

		private bool onCrashSaving(bool isNativeCrashed, string crashType, string crashAddress, string crashStack, int nativeSiCode, long crashTime, string userId, string deviceId, string crashUuid, string processName)
		{
			return _listener.onCrashSaving(isNativeCrashed, crashType, crashAddress, crashStack, nativeSiCode, crashTime, userId, deviceId, crashUuid, processName);
		}
	}

	public static ListenerAdapter GetCrashListenerAdapter(ICrashHandleListener listener)
	{
		ListenerAdapter result = null;
		if (listener != null)
		{
			result = new ListenerAdapter(listener);
		}
		return result;
	}
}
