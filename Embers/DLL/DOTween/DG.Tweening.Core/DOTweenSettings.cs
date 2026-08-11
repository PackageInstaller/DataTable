using System;
using DG.Tweening.Core.Enums;
using UnityEngine;

namespace DG.Tweening.Core;

public class DOTweenSettings : ScriptableObject
{
	public enum SettingsLocation
	{
		AssetsDirectory,
		DOTweenDirectory,
		DemigiantDirectory
	}

	[Serializable]
	public class SafeModeOptions
	{
		public SafeModeLogBehaviour logBehaviour = SafeModeLogBehaviour.Warning;

		public NestedTweenFailureBehaviour nestedTweenFailureBehaviour;
	}

	[Serializable]
	public class ModulesSetup
	{
		public bool showPanel;

		public bool audioEnabled = true;

		public bool physicsEnabled = true;

		public bool physics2DEnabled = true;

		public bool spriteEnabled = true;

		public bool uiEnabled = true;

		public bool textMeshProEnabled;

		public bool tk2DEnabled;

		public bool deAudioEnabled;

		public bool deUnityExtendedEnabled;

		public bool epoOutlineEnabled;
	}

	public const string AssetName = "DOTweenSettings";

	public const string AssetFullFilename = "DOTweenSettings.asset";

	public bool useSafeMode = true;

	public SafeModeOptions safeModeOptions = new SafeModeOptions();

	public float timeScale = 1f;

	public float unscaledTimeScale = 1f;

	public bool useSmoothDeltaTime;

	public float maxSmoothUnscaledTime = 0.15f;

	public RewindCallbackMode rewindCallbackMode;

	public bool showUnityEditorReport;

	public LogBehaviour logBehaviour;

	public bool drawGizmos = true;

	public bool defaultRecyclable;

	public AutoPlay defaultAutoPlay = AutoPlay.All;

	public UpdateType defaultUpdateType;

	public bool defaultTimeScaleIndependent;

	public Ease defaultEaseType = Ease.OutQuad;

	public float defaultEaseOvershootOrAmplitude = 1.70158f;

	public float defaultEasePeriod;

	public bool defaultAutoKill = true;

	public LoopType defaultLoopType;

	public bool debugMode;

	public bool debugStoreTargetId = true;

	public bool showPreviewPanel = true;

	public SettingsLocation storeSettingsLocation;

	public ModulesSetup modules = new ModulesSetup();

	public bool createASMDEF;

	public bool showPlayingTweens;

	public bool showPausedTweens;
}
