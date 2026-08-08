using System.Collections.Generic;
using Config;
using UnityEngine;

public class TimelineEarlyWarningClipPlayer : CommonSimpleTimelineClipPlayer<EarlyWarningClip>, ITimeScalePlayer
{
	public int CreationIndex;

	public BBHumanoid mCharacter;

	public int SceneLevel = -1;

	public bool IsPlayWarning = true;

	private Dictionary<int, EarlyWarningEffectController> m_dict = new Dictionary<int, EarlyWarningEffectController>(new IntComparer());

	private bool _InResetData;

	private bool _isPause;

	private float _timeScale = 1f;

	protected override void _Initialize(List<EarlyWarningClip> clips)
	{
	}

	protected override void _EnterNodes(List<EarlyWarningClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		if (!IsPlayWarning)
		{
			return;
		}
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			EarlyWarningClip earlyWarningClip = clipsInThisFrame[i];
			if (earlyWarningClip.Level < SceneLevel)
			{
				continue;
			}
			GameObject gameObject = Asset.Instantiate(earlyWarningClip.WarningPrefabPath);
			if (gameObject == null)
			{
				continue;
			}
			if (CreationIndex < 0 && ((BattleScene)NScene.GetCurrentScene()).GetBattleSimulatorSystem().ThrownManager.TryGetThrown(CreationIndex, out var thrownStateOfRender))
			{
				gameObject.transform.position = (Vector3)IntMath.Transform((Int3)earlyWarningClip.Offset, (Int3)thrownStateOfRender.Forward, (Int3)thrownStateOfRender.Position);
				gameObject.transform.rotation = Quaternion.Euler(Quaternion.LookRotation(thrownStateOfRender.Forward.NewY(0f)).eulerAngles + earlyWarningClip.Rotation);
			}
			else
			{
				gameObject.transform.position = (Vector3)IntMath.Transform((Int3)earlyWarningClip.Offset, (Int3)mCharacter.NextFrameFaceDirection, (Int3)mCharacter.NextFramePosition);
				Vector3 forward = ((mCharacter != null) ? mCharacter.NextFrameFaceDirection : base.Transform.rotation.eulerAngles);
				gameObject.transform.rotation = Quaternion.Euler(Quaternion.LookRotation(forward).eulerAngles + earlyWarningClip.Rotation);
			}
			gameObject.transform.localScale = earlyWarningClip.Scale;
			if (earlyWarningClip.RangeType == RangeType.AnnularSector)
			{
				U3DUtil.Get<SectorIndicator>(gameObject).Init(earlyWarningClip.Angle, earlyWarningClip.StartValue, earlyWarningClip.ValidValue, earlyWarningClip.InnerRadius / earlyWarningClip.Scale.x);
			}
			else if (earlyWarningClip.RangeType == RangeType.Annulus)
			{
				WarningManager componentInChildren = gameObject.GetComponentInChildren<WarningManager>();
				if (componentInChildren != null)
				{
					componentInChildren.InnerRadius = earlyWarningClip.InnerRadius / earlyWarningClip.Scale.x;
				}
			}
			else if (earlyWarningClip.Angle != 0)
			{
				U3DUtil.Get<SectorIndicator>(gameObject).Init(earlyWarningClip.Angle, earlyWarningClip.StartValue, earlyWarningClip.ValidValue);
			}
			EffectController component = gameObject.GetComponent<EffectController>();
			component.Initialize(isLoop: false, earlyWarningClip.Length, 1f, BattleScene.MainPlayerQuality, OnEffectStop);
			component.Simulator(0f);
			if (mCharacter != null && mCharacter.mAgent != null && mCharacter.mAgent.ComponentTimeline != null && mCharacter.mAgent.ComponentTimeline.TimelinePlayer != null)
			{
				_timeScale = mCharacter.mAgent.ComponentTimeline.TimelinePlayer.GetTimeScale();
			}
			EarlyWarningEffectController component2 = gameObject.GetComponent<EarlyWarningEffectController>();
			if (component2 != null)
			{
				component2.Key = earlyWarningClip.Key;
				component2.EffectCtrl = component;
				component2.transform.parent = (earlyWarningClip.IsAttach ? base.Transform : null);
				component2.Offset = earlyWarningClip.Offset;
				component2.Rotation = earlyWarningClip.Rotation;
				component2.Duration = earlyWarningClip.Length;
				component2.IsInward = earlyWarningClip.IsInward;
				component2.HideRenderer(v: false);
				component2.EffectCtrl.SetTimeScale(_timeScale);
				m_dict.Add(earlyWarningClip.Key, component2);
			}
			else
			{
				Debug.LogError("=====>>>>> 预警特效找不到预警控制器:" + earlyWarningClip.WarningPrefabPath);
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<EarlyWarningClip> clipsInThisFrame, float normalized)
	{
	}

	protected override void _ExitNodes(List<EarlyWarningClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
	}

	protected override void _Stop(bool isForceClean = true)
	{
		ResetData();
	}

	protected override void _Shutdown()
	{
		IsPlayWarning = true;
		ResetData();
	}

	private void ResetData()
	{
		_InResetData = true;
		Dictionary<int, EarlyWarningEffectController>.Enumerator enumerator = m_dict.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.Stop();
		}
		m_dict.Clear();
		_InResetData = false;
		_timeScale = 1f;
	}

	public void SetTimeScale(float timeScale)
	{
		_timeScale = timeScale;
		Dictionary<int, EarlyWarningEffectController>.Enumerator enumerator = m_dict.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.EffectCtrl.SetTimeScale(timeScale);
		}
	}

	public void Pause(bool isPause = true)
	{
		if (_isPause != isPause)
		{
			Dictionary<int, EarlyWarningEffectController>.Enumerator enumerator = m_dict.GetEnumerator();
			while (enumerator.MoveNext())
			{
				enumerator.Current.Value.EffectCtrl.Pause(isPause);
			}
			_isPause = isPause;
		}
	}

	public void OnEffectStop(EffectController effectController)
	{
		if (!_InResetData)
		{
			EarlyWarningEffectController component = effectController.GetComponent<EarlyWarningEffectController>();
			if (component != null)
			{
				m_dict.Remove(component.Key);
			}
		}
	}

	public override void UpdateTransform(Vector3 position, Vector3 forward)
	{
		Dictionary<int, EarlyWarningEffectController>.Enumerator enumerator = m_dict.GetEnumerator();
		while (enumerator.MoveNext())
		{
			EarlyWarningEffectController value = enumerator.Current.Value;
			value.transform.position = (Vector3)IntMath.Transform((Int3)value.Offset, (Int3)forward, (Int3)position);
			value.transform.rotation = Quaternion.Euler(Quaternion.LookRotation(forward.NewY(0f)).eulerAngles + value.Rotation);
		}
	}

	internal void EnableRenders()
	{
		Dictionary<int, EarlyWarningEffectController>.Enumerator enumerator = m_dict.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.HideRenderer(v: false);
		}
	}

	internal void DisableRenders()
	{
		Dictionary<int, EarlyWarningEffectController>.Enumerator enumerator = m_dict.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.HideRenderer(v: true);
		}
	}

	public void SetIsPlayEarlyWarning(bool isActive)
	{
		IsPlayWarning = isActive;
	}
}
