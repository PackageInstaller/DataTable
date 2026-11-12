using System;
using System.Collections.Generic;
using Drawing;
using TrueSync;
using UnityEngine;
using UnityEngine.InputSystem;

public class AdventureModuleDebugHelper : SceneSingleton<AdventureModuleDebugHelper>
{
	public Transform IndicatorsRoot;

	[NonSerialized]
	public bool PlayerGizmo;

	[NonSerialized]
	public bool MonsterGizmo;

	[NonSerialized]
	public bool BulletGizmo;

	[NonSerialized]
	public bool HitboxGizmo;

	[NonSerialized]
	public bool HearingGizmoForPlayer;

	[NonSerialized]
	public bool HearingGizmoForMonster;

	[NonSerialized]
	public bool VisionGizmoForPlayer;

	[NonSerialized]
	public bool VisionGizmoForMonster;

	[NonSerialized]
	public bool InputAndVisionGizmo;

	[NonSerialized]
	public bool MonsterPathGizmo;

	[NonSerialized]
	public bool PlayerPathGizmo;

	[NonSerialized]
	public bool CameraGizmo;

	private readonly LabelAlignment alignment1 = LabelAlignment.TopCenter.withPixelOffset(0f, -40f);

	private readonly LabelAlignment alignment2 = LabelAlignment.TopCenter.withPixelOffset(0f, -60f);

	private readonly LabelAlignment alignment3 = LabelAlignment.TopCenter.withPixelOffset(0f, -80f);

	private readonly LabelAlignment alignment4 = LabelAlignment.TopCenter.withPixelOffset(0f, 180f);

	private readonly LabelAlignment alignment5 = LabelAlignment.TopCenter.withPixelOffset(0f, 200f);

	private readonly LabelAlignment alignment6 = LabelAlignment.TopCenter.withPixelOffset(0f, 220f);

	private readonly LabelAlignment alignment7 = LabelAlignment.TopCenter.withPixelOffset(0f, 160f);

	private void Update()
	{
		if (!MonoSingleton<ClientManager>.Instance.isOpenGM())
		{
			return;
		}
		if (MonoSingleton<InputManager>.Instance.GetKeyDown(Key.F5))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("TestSwitchSkillBtn");
		}
		else if (MonoSingleton<InputManager>.Instance.GetKeyDown(Key.F6))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("TestSwitchHudDamage");
		}
		else if (MonoSingleton<InputManager>.Instance.GetKeyDown(Key.F7))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("TestSwitchHudHpBar");
			if (IndicatorsRoot != null)
			{
				if (IndicatorsRoot.localScale.x > 0f)
				{
					IndicatorsRoot.localScale = Vector3.zero;
				}
				else
				{
					IndicatorsRoot.localScale = Vector3.one;
				}
			}
		}
		else if (MonoSingleton<InputManager>.Instance.GetKeyDown(Key.F8))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("TestSwitchUI");
		}
		else if (MonoSingleton<InputManager>.Instance.GetKeyDown(Key.F9))
		{
			MonoSingleton<WwiseAudioManager>.Instance.TestSet_BGM_Voice();
		}
	}

	public void ShowArrowLineGizmo(Vector3 start, Vector3 end, Color color, float duarationTime = 0f)
	{
		CommandBuilder ingame = Draw.ingame;
		if (duarationTime > Mathf.Epsilon)
		{
			using (ingame.WithDuration(duarationTime))
			{
				using (ingame.WithColor(color))
				{
					ingame.Line(start, end, color);
					ingame.ArrowheadArc(end, (end - start).normalized, 0f);
					return;
				}
			}
		}
		using (ingame.WithColor(color))
		{
			ingame.Line(start, end, color);
			ingame.ArrowheadArc(end, (end - start).normalized, 0f);
		}
	}

	public void ShowCameraGizmo(Vector3 pos, Vector3 targetPos, Vector3 forward, float speed, bool moved, Color color)
	{
		CommandBuilder ingame = Draw.ingame;
		using (ingame.WithColor(color))
		{
			ingame.Circle(targetPos, Vector3.up, 0.1f);
			ingame.Circle(pos, Vector3.up, 0.2f);
			if (moved)
			{
				ingame.ArrowheadArc(pos, forward, 0.3f);
			}
		}
	}

	public void ShowMonsterGizmo(Vector3 pos, Vector3 forward, Vector3 up, float radius, string actorName, string stateName, string skillName, Color color)
	{
		CommandBuilder ingame = Draw.ingame;
		using (ingame.WithColor(color))
		{
			ingame.Circle(pos, up, radius);
			ingame.ArrowheadArc(pos, forward, radius + 0.1f);
			ingame.Label2D(pos, actorName, 14f, alignment1);
			ingame.Label2D(pos, stateName, 14f, alignment2);
			if (skillName != null)
			{
				ingame.Label2D(pos, skillName, 14f, alignment3);
			}
		}
	}

	public void ShowPlayerGizmo(Vector3 pos, float radius, string actorName, string stateName, string skillName, Color color)
	{
		CommandBuilder ingame = Draw.ingame;
		using (ingame.WithColor(color))
		{
			ingame.Circle(pos, Vector3.up, radius);
			ingame.Label2D(pos, actorName, 14f, alignment4);
			ingame.Label2D(pos, stateName, 14f, alignment5);
			if (skillName != null)
			{
				ingame.Label2D(pos, skillName, 14f, alignment6);
			}
		}
	}

	public void ShowPathGizmo(List<TSVector> pos, float y, float radius, Color color)
	{
		if (pos == null || pos.Count < 2)
		{
			return;
		}
		CommandBuilder ingame = Draw.ingame;
		using (ingame.WithColor(color))
		{
			for (int i = 0; i < pos.Count - 1; i++)
			{
				TSVector tSVector = pos.get_Item(i);
				TSVector tSVector2 = pos.get_Item(i + 1) - tSVector;
				FP magnitude = tSVector2.magnitude;
				TSVector normalized = tSVector2.normalized;
				TSVector tSVector3 = tSVector;
				ingame.Arrowhead(new Vector3((float)tSVector3.x, y, (float)tSVector3.z), new Vector3((float)normalized.x, 0f, (float)normalized.z), radius);
				while (magnitude > 1)
				{
					tSVector3 += normalized;
					magnitude -= (FP)1;
					ingame.Arrowhead(new Vector3((float)tSVector3.x, y, (float)tSVector3.z), new Vector3((float)normalized.x, 0f, (float)normalized.z), radius);
				}
			}
			TSVector tSVector4 = pos.get_Item(pos.Count - 1);
			ingame.Circle(new Vector3((float)tSVector4.x, y, (float)tSVector4.z), Vector3.up, radius);
		}
	}

	private static void DrawWithOptionalLineWidth(CommandBuilder draw, float lineWidthPixels, Action<CommandBuilder> drawAction)
	{
		if (lineWidthPixels > 0f)
		{
			using (draw.WithLineWidth(lineWidthPixels))
			{
				drawAction(draw);
				return;
			}
		}
		drawAction(draw);
	}

	public void ShowRectangleGizmo(Vector3 pos, float width, float length, float rot, Color color, float duarationTime = 0f, float lineWidthPixels = 0f)
	{
		CommandBuilder ingame = Draw.ingame;
		Quaternion rot2 = Quaternion.Euler(0f, 0f - rot, 0f);
		Vector2 size = new Vector2(width, length);
		if (duarationTime > Mathf.Epsilon)
		{
			using (ingame.WithDuration(duarationTime))
			{
				DrawWithOptionalLineWidth(ingame, lineWidthPixels, Core);
				return;
			}
		}
		DrawWithOptionalLineWidth(ingame, lineWidthPixels, Core);
		void Core(CommandBuilder d)
		{
			using (d.WithColor(color))
			{
				d.WireRectangle(pos, rot2, size);
			}
		}
	}

	public void ShowFanGizmo(Vector3 pos, float radius, float angle, float rot, Color color, float duarationTime = 0f)
	{
		CommandBuilder ingame = Draw.ingame;
		float num = rot + 90f - angle * 0.5f;
		Quaternion rot2 = Quaternion.Euler(0f, 0f - num, 0f);
		if (duarationTime > Mathf.Epsilon)
		{
			using (ingame.WithDuration(duarationTime))
			{
				using (ingame.WithColor(color))
				{
					Fan(ingame, pos, rot2, radius, angle);
					return;
				}
			}
		}
		using (ingame.WithColor(color))
		{
			Fan(ingame, pos, rot2, radius, angle);
		}
	}

	public void ShowFanRingGizmo(Vector3 pos, float innerRadius, float radius, float angle, float rot, Color color, float duarationTime = 0f)
	{
		CommandBuilder ingame = Draw.ingame;
		float num = rot + 90f - angle * 0.5f;
		Quaternion rot2 = Quaternion.Euler(0f, 0f - num, 0f);
		if (duarationTime > Mathf.Epsilon)
		{
			using (ingame.WithDuration(duarationTime))
			{
				using (ingame.WithColor(color))
				{
					FanRing(ingame, pos, rot2, innerRadius, radius, angle);
					return;
				}
			}
		}
		using (ingame.WithColor(color))
		{
			FanRing(ingame, pos, rot2, innerRadius, radius, angle);
		}
	}

	public void ShowRingGizmo(Vector3 pos, Vector3 up, float innerRadius, float radius, Color innerColor, Color color, float duarationTime = 0f)
	{
		CommandBuilder ingame = Draw.ingame;
		if (duarationTime > Mathf.Epsilon)
		{
			using (ingame.WithDuration(duarationTime))
			{
				using (ingame.WithColor(innerColor))
				{
					ingame.Circle(pos, up, innerRadius);
				}
				using (ingame.WithColor(color))
				{
					ingame.Circle(pos, up, radius);
					return;
				}
			}
		}
		using (ingame.WithColor(innerColor))
		{
			ingame.Circle(pos, up, innerRadius);
		}
		using (ingame.WithColor(color))
		{
			ingame.Circle(pos, up, radius);
		}
	}

	public void ShowCircleGizmo(Vector3 pos, Vector3 up, float radius, Color color, float duarationTime = 0f, float lineWidthPixels = 0f)
	{
		CommandBuilder ingame = Draw.ingame;
		if (duarationTime > Mathf.Epsilon)
		{
			using (ingame.WithDuration(duarationTime))
			{
				DrawWithOptionalLineWidth(ingame, lineWidthPixels, Core);
				return;
			}
		}
		DrawWithOptionalLineWidth(ingame, lineWidthPixels, Core);
		void Core(CommandBuilder d)
		{
			using (d.WithColor(color))
			{
				d.Circle(pos, up, radius);
			}
		}
	}

	private static void Fan(CommandBuilder builder, Vector3 pos, Quaternion rot, float radius, float angle)
	{
		List<Vector3> list = new List<Vector3> { pos };
		Matrix4x4 matrix4x = Matrix4x4.TRS(pos, rot, Vector3.one);
		float num = angle / 20f;
		for (float num2 = 0f; num2 <= angle; num2 += num)
		{
			Vector3 point = new Vector3(radius * Mathf.Cos(num2 * (MathF.PI / 180f)), 0f, radius * Mathf.Sin(num2 * (MathF.PI / 180f)));
			point = matrix4x.MultiplyPoint3x4(point);
			list.Add(point);
		}
		builder.Polyline(list, cycle: true);
	}

	private static void FanRing(CommandBuilder builder, Vector3 pos, Quaternion rot, float innerRadius, float radius, float angle)
	{
		List<Vector3> list = new List<Vector3>();
		Matrix4x4 matrix4x = Matrix4x4.TRS(pos, rot, Vector3.one);
		float num = angle / 20f;
		for (float num2 = 0f; num2 <= angle; num2 += num)
		{
			Vector3 point = new Vector3(innerRadius * Mathf.Cos(num2 * (MathF.PI / 180f)), 0f, innerRadius * Mathf.Sin(num2 * (MathF.PI / 180f)));
			point = matrix4x.MultiplyPoint3x4(point);
			list.Add(point);
		}
		for (float num3 = angle; num3 >= 0f; num3 -= num)
		{
			Vector3 point2 = new Vector3(radius * Mathf.Cos(num3 * (MathF.PI / 180f)), 0f, radius * Mathf.Sin(num3 * (MathF.PI / 180f)));
			point2 = matrix4x.MultiplyPoint3x4(point2);
			list.Add(point2);
		}
		builder.Polyline(list, cycle: true);
	}
}
