using System.Collections.Generic;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.Localization;

internal class LocalizationBehaviour : ComponentSingleton<LocalizationBehaviour>
{
	private Queue<(int frame, AsyncOperationHandle handle)> m_ReleaseQueue = new Queue<(int, AsyncOperationHandle)>();

	protected override string GetGameObjectName()
	{
		return "Localization Resource Manager";
	}

	public static void ReleaseNextFrame(AsyncOperationHandle handle)
	{
		ComponentSingleton<LocalizationBehaviour>.Instance.DoReleaseNextFrame(handle);
	}

	private void DoReleaseNextFrame(AsyncOperationHandle handle)
	{
		enabled = true;
		m_ReleaseQueue.Enqueue((Time.frameCount, handle));
	}

	private void LateUpdate()
	{
		int frameCount = Time.frameCount;
		while (m_ReleaseQueue.Count > 0 && m_ReleaseQueue.Peek().frame < frameCount)
		{
			AddressablesInterface.SafeRelease(m_ReleaseQueue.Dequeue().handle);
		}
		if (m_ReleaseQueue.Count == 0)
		{
			enabled = false;
		}
	}
}
