using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Template;

public class Skill_DrawGraphicIndicator : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		GetEntityPositionObsoleted(GetCurrentPlayer());
		yield return null;
	}

	protected IEnumerator DrawCircleGraphicIndicator(bool IsFull, TSVector2 Position, FP Radius, Color Color, FP DelayTime)
	{
		double ElapsedTime = 0.0;
		CircleGraphicIndicator GraphicIndicator = SceneSingleton<AdventureIndicatorController>.Instance.SpawnCircleGraphicIndicator();
		GraphicIndicator.position = Position.ToVector2();
		GraphicIndicator.rotation = 0f;
		GraphicIndicator.size = (float)Radius * 2f;
		GraphicIndicator.progress = 0f;
		GraphicIndicator.progressColor = Color;
		while (ElapsedTime <= DelayTime)
		{
			ElapsedTime += 0.03;
			FP fP = ((DelayTime > 0f) ? TSMath.Clamp01(ElapsedTime / DelayTime) : ((FP)1f));
			if (!IsFull)
			{
				GraphicIndicator.progress = (float)fP;
			}
			else
			{
				GraphicIndicator.progress = 1f;
			}
			yield return WaitTime(0.03);
		}
		GraphicIndicator.gameObject.SetActive(value: false);
	}

	protected IEnumerator DrawFanGraphicIndicator(bool IsFull, TSVector2 Position, FP Radius, Color Color, FP DelayTime, FP Angle, FP Rotation)
	{
		double ElapsedTime = 0.0;
		FanGraphicIndicator GraphicIndicator = SceneSingleton<AdventureIndicatorController>.Instance.SpawnFanGraphicIndicator();
		GraphicIndicator.position = Position.ToVector2();
		GraphicIndicator.rotation = (float)Rotation;
		GraphicIndicator.size = (float)Radius * 2f;
		GraphicIndicator.angle = (float)Angle;
		GraphicIndicator.progress = 0f;
		GraphicIndicator.progressColor = Color;
		while (ElapsedTime <= DelayTime)
		{
			ElapsedTime += 0.03;
			FP fP = ((DelayTime > 0f) ? TSMath.Clamp01(ElapsedTime / DelayTime) : ((FP)1f));
			if (!IsFull)
			{
				GraphicIndicator.progress = (float)fP;
			}
			else
			{
				GraphicIndicator.progress = 1f;
			}
			yield return WaitTime(0.03);
		}
		GraphicIndicator.gameObject.SetActive(value: false);
	}

	protected IEnumerator DrawRingGraphicIndicator(bool IsFull, TSVector2 Position, FP Radius, Color Color, FP DelayTime, FP Thickness)
	{
		double ElapsedTime = 0.0;
		RingGraphicIndicator GraphicIndicator = SceneSingleton<AdventureIndicatorController>.Instance.SpawnRingGraphicIndicator();
		GraphicIndicator.position = Position.ToVector2();
		GraphicIndicator.rotation = 0f;
		GraphicIndicator.size = (float)Radius * 2f;
		GraphicIndicator.thickness = (float)Thickness;
		GraphicIndicator.progress = 0f;
		GraphicIndicator.progressColor = Color;
		while (ElapsedTime <= DelayTime)
		{
			ElapsedTime += 0.03;
			FP fP = ((DelayTime > 0f) ? TSMath.Clamp01(ElapsedTime / DelayTime) : ((FP)1f));
			if (!IsFull)
			{
				GraphicIndicator.progress = (float)fP;
			}
			else
			{
				GraphicIndicator.progress = 1f;
			}
			yield return WaitTime(0.03);
		}
		GraphicIndicator.gameObject.SetActive(value: false);
	}

	protected IEnumerator DrawRecGraphicIndicator(bool IsFull, TSVector2 Position, FP Width, FP Height, Color Color, FP DelayTime, FP Rotation)
	{
		double ElapsedTime = 0.0;
		RectangleGraphicIndicator GraphicIndicator = SceneSingleton<AdventureIndicatorController>.Instance.SpawnRectangleGraphicIndicator();
		GraphicIndicator.position = Position.ToVector2();
		GraphicIndicator.rotation = (float)Rotation;
		GraphicIndicator.width = (float)Width;
		GraphicIndicator.height = (float)Height;
		GraphicIndicator.progress = 0f;
		GraphicIndicator.progressColor = Color;
		while (ElapsedTime <= DelayTime)
		{
			ElapsedTime += 0.03;
			FP fP = ((DelayTime > 0f) ? TSMath.Clamp01(ElapsedTime / DelayTime) : ((FP)1f));
			if (!IsFull)
			{
				GraphicIndicator.progress = (float)fP;
			}
			else
			{
				GraphicIndicator.progress = 1f;
			}
			yield return WaitTime(0.03);
		}
		GraphicIndicator.gameObject.SetActive(value: false);
	}
}
