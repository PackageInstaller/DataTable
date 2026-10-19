using System;
using System.Collections.Generic;
using ACT.UI;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.Precache;
using UnityEngine;

namespace ACT.Model;

public class CommonInteractUIModel : Model<CommonInteractUIModel>
{
	private struct InstanceData
	{
		public InstanceHandle handle;

		public CommonInteractUI ui;

		public Action<CommonInteractUI> onLoaded;
	}

	private struct RefreshState
	{
		public Vector3 lastPosition;

		public float lastPositionChangeTime;

		public float activeEnterTime;

		public bool requiresProtectionEndRuleCheck;

		public bool scaleResetOutsideFrustum;
	}

	private readonly Dictionary<object, InstanceData> m_InstanceDatas = new Dictionary<object, InstanceData>();

	private readonly List<CommonInteractUI> m_ActiveUIs = new List<CommonInteractUI>();

	private readonly List<CommonInteractUI> m_InactiveUIs = new List<CommonInteractUI>();

	private readonly Dictionary<CommonInteractUI, RefreshState> m_RefreshStates = new Dictionary<CommonInteractUI, RefreshState>();

	private const int MaxLateUpdateCountPerFrame = 5;

	private const int ActiveUIRuleCheckIntervalFrame = 30;

	private const float ActiveUIKeepDuration = 1f;

	private const float PositionChangeSqrThreshold = 0.0001f;

	private Looper m_LateUpdateLooper;

	private int m_InactiveUIUpdateCursor;

	private int m_ActiveUIRuleCheckFrame;

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
		StopLateUpdateLooper();
		foreach (InstanceData value in m_InstanceDatas.Values)
		{
			ReleaseInstance(value);
		}
		m_InstanceDatas.Clear();
		m_ActiveUIs.Clear();
		m_InactiveUIs.Clear();
		m_RefreshStates.Clear();
	}

	public InstanceHandle Load(object owner, Action<CommonInteractUI> onLoaded)
	{
		if (m_InstanceDatas.TryGetValue(owner, out var value))
		{
			return value.handle;
		}
		value = new InstanceData
		{
			onLoaded = onLoaded,
			handle = PrecacheManager.Instance.GetInstanceHandle(GameLoader.meta.npcUIReferenceAssetID.GUID)
		};
		m_InstanceDatas.Add(owner, value);
		value.handle.Completed += (InstanceHandle handle) =>
		{
			OnLoadCompleted(owner, handle);
		};
		return value.handle;
	}

	public InstanceHandle GetInstanceHandle(object owner)
	{
		if (!m_InstanceDatas.TryGetValue(owner, out var value))
		{
			return null;
		}
		return value.handle;
	}

	public void Release(object owner)
	{
		if (m_InstanceDatas.Remove(owner, out var value))
		{
			ReleaseInstance(value);
		}
	}

	public void LateUpdate()
	{
		Camera mainCamera = GameUtility.mainCamera;
		UpdateActiveUIs(mainCamera);
		if (++m_ActiveUIRuleCheckFrame >= 30)
		{
			m_ActiveUIRuleCheckFrame = 0;
			EvaluateActiveUIRefreshRules(mainCamera);
		}
		UpdateInactiveUIs(mainCamera);
		if (m_ActiveUIs.Count == 0 && m_InactiveUIs.Count == 0)
		{
			StopLateUpdateLooper();
		}
	}

	private void OnLoadCompleted(object owner, InstanceHandle handle)
	{
		if (!m_InstanceDatas.TryGetValue(owner, out var value) || value.handle != handle)
		{
			return;
		}
		try
		{
			GameObject result = handle.Result;
			result.transform.SetParent(GameUtility.npcInfoRoot);
			result.SetActive(value: false);
			CommonInteractUI componentInChildren = result.GetComponentInChildren<CommonInteractUI>();
			if (!componentInChildren)
			{
				throw new InvalidOperationException("头顶提示预制体缺少 CommonInteractUI 组件。");
			}
			value.ui = componentInChildren;
			m_InstanceDatas[owner] = value;
			value.onLoaded?.Invoke(componentInChildren);
			AddActiveUI(componentInChildren);
			StartLateUpdateLooper();
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"头顶提示加载失败 原因 :\n {arg}");
			}
			Release(owner);
		}
	}

	private void ReleaseInstance(InstanceData instanceData)
	{
		try
		{
			if ((bool)instanceData.ui)
			{
				m_ActiveUIs.Remove(instanceData.ui);
				RemoveInactiveUI(instanceData.ui);
				m_RefreshStates.Remove(instanceData.ui);
				instanceData.ui.UnInit();
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"头顶提示卸载失败 原因 :\n {arg}");
			}
		}
		finally
		{
			ReleaseInstanceHandleSafely(instanceData.handle);
			if (m_ActiveUIs.Count == 0 && m_InactiveUIs.Count == 0)
			{
				StopLateUpdateLooper();
			}
		}
	}

	private static void ReleaseInstanceHandleSafely(InstanceHandle handle)
	{
		if (handle == null || !handle.IsValid)
		{
			return;
		}
		try
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(handle);
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"头顶提示句柄回收失败 原因 :\n {arg}");
			}
		}
	}

	private void StartLateUpdateLooper()
	{
		if (!m_LateUpdateLooper.IsValid())
		{
			m_LateUpdateLooper = UpdateTimer.Default.LoopFrame(1, LateUpdate);
		}
	}

	private void StopLateUpdateLooper()
	{
		if (m_LateUpdateLooper.IsValid())
		{
			m_LateUpdateLooper.Cancel();
		}
		m_LateUpdateLooper = default;
		m_InactiveUIUpdateCursor = 0;
		m_ActiveUIRuleCheckFrame = 0;
	}

	private void UpdateActiveUIs(Camera mainCamera)
	{
		for (int num = m_ActiveUIs.Count - 1; num >= 0; num--)
		{
			CommonInteractUI commonInteractUI = m_ActiveUIs[num];
			if (!commonInteractUI)
			{
				m_ActiveUIs.RemoveAt(num);
				m_RefreshStates.Remove(commonInteractUI);
			}
			else
			{
				bool flag = IsWithinActiveRefreshProtection(commonInteractUI);
				if (flag || !TryEvaluateProtectionEndRefreshRule(commonInteractUI))
				{
					if (!flag && !IsInMainCameraFrustum(commonInteractUI, mainCamera))
					{
						commonInteractUI.ResetPositionToDefault();
						ResetScaleWhenOutsideMainCameraFrustum(commonInteractUI);
					}
					else
					{
						commonInteractUI.LateUpdateByUpdater();
						MarkScaleUpdatedInsideMainCameraFrustum(commonInteractUI);
						UpdatePositionChangeTime(commonInteractUI);
					}
				}
			}
		}
	}

	private void EvaluateActiveUIRefreshRules(Camera mainCamera)
	{
		float time = Time.time;
		for (int num = m_ActiveUIs.Count - 1; num >= 0; num--)
		{
			CommonInteractUI commonInteractUI = m_ActiveUIs[num];
			if (!commonInteractUI)
			{
				m_ActiveUIs.RemoveAt(num);
				m_RefreshStates.Remove(commonInteractUI);
			}
			else if (!(time - m_RefreshStates[commonInteractUI].lastPositionChangeTime < 1f) && IsInMainCameraFrustum(commonInteractUI, mainCamera))
			{
				m_ActiveUIs.RemoveAt(num);
				m_InactiveUIs.Add(commonInteractUI);
			}
		}
	}

	private void UpdateInactiveUIs(Camera mainCamera)
	{
		int num = 0;
		while (num < 5 && m_InactiveUIs.Count > 0)
		{
			if (m_InactiveUIUpdateCursor >= m_InactiveUIs.Count)
			{
				m_InactiveUIUpdateCursor = 0;
			}
			CommonInteractUI commonInteractUI = m_InactiveUIs[m_InactiveUIUpdateCursor];
			if (!commonInteractUI)
			{
				m_InactiveUIs.RemoveAt(m_InactiveUIUpdateCursor);
				m_RefreshStates.Remove(commonInteractUI);
				num++;
				continue;
			}
			if (!IsInMainCameraFrustum(commonInteractUI, mainCamera))
			{
				ResetScaleWhenOutsideMainCameraFrustum(commonInteractUI);
				commonInteractUI.SetVisible(isVisible: false);
				m_InactiveUIUpdateCursor++;
				num++;
				continue;
			}
			commonInteractUI.SetVisible(isVisible: true);
			commonInteractUI.LateUpdateByUpdater();
			MarkScaleUpdatedInsideMainCameraFrustum(commonInteractUI);
			if (UpdatePositionChangeTime(commonInteractUI))
			{
				m_InactiveUIs.RemoveAt(m_InactiveUIUpdateCursor);
				PromoteToActiveUI(commonInteractUI);
			}
			else
			{
				m_InactiveUIUpdateCursor++;
			}
			num++;
		}
	}

	private void AddActiveUI(CommonInteractUI commonInteractUI)
	{
		m_RefreshStates[commonInteractUI] = new RefreshState
		{
			lastPosition = commonInteractUI.CullingPosition,
			lastPositionChangeTime = Time.time,
			activeEnterTime = Time.time,
			requiresProtectionEndRuleCheck = true
		};
		m_ActiveUIs.Add(commonInteractUI);
	}

	private void PromoteToActiveUI(CommonInteractUI commonInteractUI)
	{
		RefreshState value = m_RefreshStates[commonInteractUI];
		value.activeEnterTime = Time.time;
		value.requiresProtectionEndRuleCheck = true;
		m_RefreshStates[commonInteractUI] = value;
		m_ActiveUIs.Add(commonInteractUI);
	}

	private bool UpdatePositionChangeTime(CommonInteractUI commonInteractUI)
	{
		RefreshState value = m_RefreshStates[commonInteractUI];
		Vector3 cullingPosition = commonInteractUI.CullingPosition;
		if ((cullingPosition - value.lastPosition).sqrMagnitude <= 0.0001f)
		{
			return false;
		}
		value.lastPosition = cullingPosition;
		value.lastPositionChangeTime = Time.time;
		m_RefreshStates[commonInteractUI] = value;
		return true;
	}

	private static bool IsInMainCameraFrustum(CommonInteractUI commonInteractUI, Camera mainCamera)
	{
		if (!mainCamera)
		{
			return true;
		}
		Vector3 vector = mainCamera.WorldToViewportPoint(commonInteractUI.CullingPosition);
		if (vector.z > 0f)
		{
			float x = vector.x;
			if (x >= 0f && x <= 1f)
			{
				x = vector.y;
				if (x >= 0f)
				{
					return x <= 1f;
				}
				return false;
			}
		}
		return false;
	}

	private bool IsWithinActiveRefreshProtection(CommonInteractUI commonInteractUI)
	{
		if (m_RefreshStates.TryGetValue(commonInteractUI, out var value))
		{
			return Time.time - value.activeEnterTime < 1f;
		}
		return false;
	}

	private bool TryEvaluateProtectionEndRefreshRule(CommonInteractUI commonInteractUI)
	{
		RefreshState value = m_RefreshStates[commonInteractUI];
		if (!value.requiresProtectionEndRuleCheck)
		{
			return false;
		}
		value.requiresProtectionEndRuleCheck = false;
		m_RefreshStates[commonInteractUI] = value;
		if (Time.time - value.lastPositionChangeTime < 1f)
		{
			return false;
		}
		m_ActiveUIs.Remove(commonInteractUI);
		m_InactiveUIs.Add(commonInteractUI);
		return true;
	}

	private void RemoveInactiveUI(CommonInteractUI commonInteractUI)
	{
		int num = m_InactiveUIs.IndexOf(commonInteractUI);
		if (num >= 0)
		{
			m_InactiveUIs.RemoveAt(num);
			if (num < m_InactiveUIUpdateCursor)
			{
				m_InactiveUIUpdateCursor--;
			}
		}
	}

	private void ResetScaleWhenOutsideMainCameraFrustum(CommonInteractUI commonInteractUI)
	{
		if (m_RefreshStates.TryGetValue(commonInteractUI, out var value) && !value.scaleResetOutsideFrustum)
		{
			commonInteractUI.ResetScaleToDefault();
			value.scaleResetOutsideFrustum = true;
			m_RefreshStates[commonInteractUI] = value;
		}
	}

	private void MarkScaleUpdatedInsideMainCameraFrustum(CommonInteractUI commonInteractUI)
	{
		if (m_RefreshStates.TryGetValue(commonInteractUI, out var value) && value.scaleResetOutsideFrustum)
		{
			value.scaleResetOutsideFrustum = false;
			m_RefreshStates[commonInteractUI] = value;
		}
	}
}
