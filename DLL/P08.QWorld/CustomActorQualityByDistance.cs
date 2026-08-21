using UnityEngine;

public struct CustomActorQualityByDistance
{
	public enum CalcActorQualityFunc
	{
		[InspectorName("默认")]
		ByDefault,
		[InspectorName("自定义LOD切换")]
		ByCustomLOD,
		[InspectorName("自定义距离切换")]
		ByCustomDistance
	}

	public CalcActorQualityFunc calcActorQualityFunc;

	public int startUseLowQuality;

	public int startCull;

	public float startUseLowQualityDistance;

	public float startCullDistance;

	private static int[] LodOptions()
	{
		return new int[4] { 24948, 2081095680, 1801677140, 1970238023 };
	}

	public void UpdatePassiveCharaActor(PassiveCharaActor actor, in QWorldMapCull.QWorldCullResult cullResult)
	{
		UpdatePassiveCharaActor(actor, !cullResult.visible, in cullResult);
	}

	public void UpdatePassiveCharaActor(PassiveCharaActor actor, bool manuallyCull, in QWorldMapCull.QWorldCullResult cullResult)
	{
		switch (calcActorQualityFunc)
		{
		case CalcActorQualityFunc.ByDefault:
			actor.OnUpdate(manuallyCull, CalcQualityByLOD(in cullResult));
			break;
		case CalcActorQualityFunc.ByCustomLOD:
			actor.OnUpdate(manuallyCull, CalcQualityByLOD(in cullResult, startUseLowQuality, startCull));
			break;
		case CalcActorQualityFunc.ByCustomDistance:
			actor.OnUpdate(manuallyCull, CalcQualityByDistance(in cullResult, startUseLowQualityDistance, startCullDistance));
			break;
		}
	}

	public PassiveCharaActor.Quality CalcQuality(in QWorldMapCull.QWorldCullResult cullResult)
	{
		return calcActorQualityFunc switch
		{
			CalcActorQualityFunc.ByCustomLOD => CalcQualityByLOD(in cullResult, startUseLowQuality, startCull), 
			CalcActorQualityFunc.ByCustomDistance => CalcQualityByDistance(in cullResult, startUseLowQualityDistance, startCullDistance), 
			_ => CalcQualityByLOD(in cullResult), 
		};
	}

	public static PassiveCharaActor.Quality CalcQualityByLOD(in QWorldMapCull.QWorldCullResult cullResult)
	{
		return CalcQualityByLOD(in cullResult, 2, 3);
	}

	public static PassiveCharaActor.Quality CalcQualityByLOD(in QWorldMapCull.QWorldCullResult cullResult, int startLowQuality, int startCull)
	{
		int lod = cullResult.lod;
		if (lod > startCull)
		{
			return PassiveCharaActor.Quality.Cull;
		}
		if (lod > startLowQuality)
		{
			return PassiveCharaActor.Quality.Low;
		}
		return PassiveCharaActor.Quality.High;
	}

	public static PassiveCharaActor.Quality CalcQualityByDistance(in QWorldMapCull.QWorldCullResult cullResult, float startLowQualityDistance, float startCullDistance)
	{
		float distanceSqr = cullResult.distanceSqr;
		if (distanceSqr > startCullDistance * startCullDistance)
		{
			return PassiveCharaActor.Quality.Cull;
		}
		if (distanceSqr > startLowQualityDistance * startLowQualityDistance)
		{
			return PassiveCharaActor.Quality.Low;
		}
		return PassiveCharaActor.Quality.High;
	}
}
