using System;
using UnityEngine;

public readonly struct SummerRacePresentationPhaseContract
{
	public readonly SummerRacePresentationDeliveryKind DeliveryKind;

	public readonly bool CanReject;

	public readonly SummerRacePresentationPhaseMask SupportedPhases;

	public readonly int SuccessPhaseCount;

	private readonly SummerRacePresentationPhase phase0;

	private readonly SummerRacePresentationPhase phase1;

	private readonly SummerRacePresentationPhase phase2;

	private readonly SummerRacePresentationPhase phase3;

	private readonly SummerRacePresentationPhase phase4;

	public SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind deliveryKind, bool canReject, SummerRacePresentationPhase phase0, SummerRacePresentationPhase phase1 = SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase phase2 = SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase phase3 = SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase phase4 = SummerRacePresentationPhase.Rejected, int successPhaseCount = 1)
	{
		DeliveryKind = deliveryKind;
		CanReject = canReject;
		this.phase0 = phase0;
		this.phase1 = phase1;
		this.phase2 = phase2;
		this.phase3 = phase3;
		this.phase4 = phase4;
		SuccessPhaseCount = Mathf.Clamp(successPhaseCount, 0, 5);
		SummerRacePresentationPhaseMask summerRacePresentationPhaseMask = (canReject ? SummerRacePresentationPhaseMask.Rejected : SummerRacePresentationPhaseMask.None);
		if (SuccessPhaseCount > 0)
		{
			summerRacePresentationPhaseMask |= ToMask(phase0);
		}
		if (SuccessPhaseCount > 1)
		{
			summerRacePresentationPhaseMask |= ToMask(phase1);
		}
		if (SuccessPhaseCount > 2)
		{
			summerRacePresentationPhaseMask |= ToMask(phase2);
		}
		if (SuccessPhaseCount > 3)
		{
			summerRacePresentationPhaseMask |= ToMask(phase3);
		}
		if (SuccessPhaseCount > 4)
		{
			summerRacePresentationPhaseMask |= ToMask(phase4);
		}
		SupportedPhases = summerRacePresentationPhaseMask;
	}

	public SummerRacePresentationPhase GetSuccessPhase(int index)
	{
		return index switch
		{
			0 => phase0, 
			1 => phase1, 
			2 => phase2, 
			3 => phase3, 
			4 => phase4, 
			_ => throw new ArgumentOutOfRangeException("index"), 
		};
	}

	public bool SupportsPhase(SummerRacePresentationPhase phase)
	{
		return (SupportedPhases & ToMask(phase)) != 0;
	}

	private static SummerRacePresentationPhaseMask ToMask(SummerRacePresentationPhase phase)
	{
		return phase switch
		{
			SummerRacePresentationPhase.Rejected => SummerRacePresentationPhaseMask.Rejected, 
			SummerRacePresentationPhase.Fired => SummerRacePresentationPhaseMask.Fired, 
			SummerRacePresentationPhase.Activated => SummerRacePresentationPhaseMask.Activated, 
			SummerRacePresentationPhase.ActiveExpired => SummerRacePresentationPhaseMask.ActiveExpired, 
			SummerRacePresentationPhase.Spawned => SummerRacePresentationPhaseMask.Spawned, 
			SummerRacePresentationPhase.ReturnStarted => SummerRacePresentationPhaseMask.ReturnStarted, 
			SummerRacePresentationPhase.Hit => SummerRacePresentationPhaseMask.Hit, 
			SummerRacePresentationPhase.Recycled => SummerRacePresentationPhaseMask.Recycled, 
			SummerRacePresentationPhase.Impact => SummerRacePresentationPhaseMask.Impact, 
			_ => SummerRacePresentationPhaseMask.None, 
		};
	}
}
