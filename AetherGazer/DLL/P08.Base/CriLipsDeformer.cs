using UnityEngine;

[AddComponentMenu("CRIWARE/CriLipsDeformer")]
public class CriLipsDeformer : CriMonoBehaviour
{
	public delegate void UserModifyDelegateFunction(ref CriLipsMouth.Info info, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese morph, ICriLipsAnalyzeModule analyzeModule);

	public enum UpdateScheduleType
	{
		LateUpdate,
		Update,
		Manual
	}

	public UserModifyDelegateFunction UserModifyDelegate;

	public UpdateScheduleType UpdateSchedule;

	[SerializeReference]
	private ICriLipsMorph lipsMorph;

	protected CriLipsMouth.Info info;

	protected CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount;

	protected ICriLipsAnalyzeModule analyzeModule;

	private CriLipsMouth.Info silicenInfo;

	public ICriLipsMorph LipsMorph
	{
		get
		{
			return lipsMorph;
		}
		set
		{
			if (lipsMorph != null)
			{
				lipsMorph.Reset();
			}
			lipsMorph = value;
			if (lipsMorph != null)
			{
				lipsMorph.SilenceInfo = silicenInfo;
			}
		}
	}

	protected virtual void StartForMorphing(CriLipsMouth.Info silenceInfo)
	{
		if (LipsMorph != null)
		{
			LipsMorph.SilenceInfo = silenceInfo;
		}
		silicenInfo = silenceInfo;
	}

	protected virtual void UpdateLipsParameter()
	{
		if (UserModifyDelegate != null && analyzeModule != null)
		{
			UserModifyDelegate(ref info, ref blendAmount, analyzeModule);
		}
		if (LipsMorph != null)
		{
			lipsMorph.Update(ref info, ref blendAmount);
			if (analyzeModule != null)
			{
				LipsMorph.Update(analyzeModule);
			}
		}
	}

	public void ManualUpdate()
	{
		if (UpdateSchedule == UpdateScheduleType.Manual)
		{
			UpdateLipsParameter();
		}
	}

	public override void CriInternalUpdate()
	{
		if (UpdateSchedule == UpdateScheduleType.Update)
		{
			UpdateLipsParameter();
		}
	}

	public override void CriInternalLateUpdate()
	{
		if (UpdateSchedule == UpdateScheduleType.LateUpdate)
		{
			UpdateLipsParameter();
		}
	}
}
