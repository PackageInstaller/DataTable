using P08Common.Collections;
using UnityEngine;

namespace P08Common;

internal class OrcaSolver
{
	internal struct OrcaLine
	{
		public Vector2 point;

		public Vector2 direction;
	}

	internal bool resultReady;

	internal Vector2 result;

	internal Vector2 optimalVelocity;

	internal float radius;

	internal bool optSpeed;

	internal FastList<OrcaLine> lines = new FastList<OrcaLine>();

	internal FastList<OrcaLine> projectedLines = new FastList<OrcaLine>();

	internal int obstCount;

	internal int collisionCount;

	private float sqrRadius;

	public Int2 Result
	{
		get
		{
			//IL_0015: Unknown result type (might be due to invalid IL or missing references)
			if (!resultReady)
			{
				return ComputeResult();
			}
			return (Int2)result;
		}
	}

	public void Initialize(Int2 optimalVelocity, float radius, bool optSpeed = false)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		resultReady = true;
		result = (Vector2)optimalVelocity;
		this.optimalVelocity = (Vector2)optimalVelocity;
		this.radius = radius;
		this.optSpeed = optSpeed;
		sqrRadius = radius * radius;
		lines.Clear();
		obstCount = 0;
		collisionCount = 0;
		Vector2 vector = result;
		Debug.Log((object)("optimalVelocity:" + vector.ToString() + ",radius:" + radius));
	}

	public void AddLine(Vector2 point, Vector2 direction, bool collision = false)
	{
		resultReady = false;
		OrcaLine orcaLine = default(OrcaLine);
		orcaLine.point = point;
		orcaLine.direction = direction;
		if (collision)
		{
			if (collisionCount < lines.count)
			{
				OrcaLine item = lines[collisionCount];
				lines[collisionCount] = orcaLine;
				lines.Add(item);
			}
			else
			{
				lines.Add(orcaLine);
			}
			collisionCount++;
		}
		else
		{
			lines.Add(orcaLine);
		}
	}

	public Int2 ComputeResult()
	{
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		int num = LinearProgram2(lines, optimalVelocity, optimalDirection: false, ref result);
		if (num < lines.count)
		{
			LinearProgram3(lines, num, ref result);
		}
		resultReady = true;
		Vector2 vector = result;
		Debug.Log((object)("result:" + vector.ToString()));
		return (Int2)result;
	}

	private bool LinearProgram1(FastList<OrcaLine> lines, int lineNo, Vector2 optimalResult, bool optimalDirection, ref Vector2 result)
	{
		OrcaLine orcaLine = lines[lineNo];
		Vector2 point = orcaLine.point;
		Vector2 direction = orcaLine.direction;
		float num = Vector2.Dot(point, direction);
		float num2 = num * num + sqrRadius - Vector2.Dot(point, point);
		if (num2 < 0f)
		{
			return false;
		}
		num2 = Math.Sqrt(num2);
		float num3 = 0f - num - num2;
		float num4 = 0f - num + num2;
		for (int i = 0; i < lineNo; i++)
		{
			OrcaLine orcaLine2 = lines[i];
			Vector2 point2 = orcaLine2.point;
			Vector2 direction2 = orcaLine2.direction;
			float num5 = 0f - Vector2.Det(direction, direction2);
			float num6 = Vector2.Det(point - point2, direction2);
			string[] obj = new string[12]
			{
				"w_:",
				num5.ToString(),
				",x:",
				num6.ToString(),
				",dir:",
				null,
				null,
				null,
				null,
				null,
				null,
				null
			};
			Vector2 vector = direction;
			obj[5] = vector.ToString();
			obj[6] = ",dir_i:";
			vector = direction2;
			obj[7] = vector.ToString();
			obj[8] = ",P:";
			vector = point;
			obj[9] = vector.ToString();
			obj[10] = ",P_i:";
			vector = point2;
			obj[11] = vector.ToString();
			Debug.Log((object)string.Concat(obj));
			if (Math.Abs(num5) <= 0.0001f)
			{
				if (num6 < 0f)
				{
					return false;
				}
				continue;
			}
			float b = num6 / num5;
			if (num5 < 0f)
			{
				num3 = Math.Max(num3, b);
			}
			else
			{
				num4 = Math.Min(num4, b);
			}
			Debug.Log((object)(",w:" + num5 + ",x:" + num6 + ",t:" + b + ",tRight_:" + num4 + ",tLeft_:" + num3));
			if (num3 > num4)
			{
				return false;
			}
		}
		if (optimalDirection)
		{
			if (Vector2.Dot(optimalResult, direction) > 0f)
			{
				result = point + num4 * direction;
			}
			else
			{
				result = point + num3 * direction;
			}
		}
		else
		{
			float num7 = Vector2.Dot(direction, optimalResult - point);
			if (num7 < num3)
			{
				result = point + num3 * direction;
			}
			else if (num7 > num4)
			{
				result = point + num4 * direction;
			}
			else
			{
				result = point + num7 * direction;
			}
		}
		return true;
	}

	private int LinearProgram2(FastList<OrcaLine> lines, Vector2 optimalVelocity, bool optimalDirection, ref Vector2 result)
	{
		if (optimalDirection)
		{
			result = optimalVelocity * radius;
		}
		else if (optimalVelocity.SquareMagnitude > sqrRadius)
		{
			result = optimalVelocity.Normalized * radius;
		}
		else
		{
			result = optimalVelocity;
		}
		for (int i = 0; i < lines.count; i++)
		{
			if (Vector2.Det(result - lines[i].point, lines[i].direction) < 0f && !LinearProgram1(lines, i, optimalVelocity, optimalDirection, ref result))
			{
				return i;
			}
		}
		return lines.count;
	}

	private void LinearProgram3(FastList<OrcaLine> lines, int beginLine_, ref Vector2 result)
	{
		float num = 0f;
		int count = lines.count;
		OrcaLine item = default(OrcaLine);
		for (int i = beginLine_; i < count; i++)
		{
			OrcaLine orcaLine = lines[i];
			Vector2 point = orcaLine.point;
			Vector2 direction = orcaLine.direction;
			float num2 = Vector2.Det(result - point, direction);
			if (!(num2 < num))
			{
				continue;
			}
			projectedLines.Clear();
			int num3 = ((i >= obstCount) ? ((i < collisionCount) ? obstCount : collisionCount) : 0);
			for (int j = 0; j < num3; j++)
			{
				projectedLines.Add(lines[j]);
			}
			for (int k = num3; k < i; k++)
			{
				OrcaLine orcaLine2 = lines[k];
				Vector2 point2 = orcaLine2.point;
				Vector2 direction2 = orcaLine2.direction;
				float num4 = 0f - Vector2.Det(direction, direction2);
				if (Math.Abs(num4) <= 0.0001f)
				{
					if (Vector2.Dot(direction, direction2) > 0f)
					{
						continue;
					}
					item.point = (point + point2) / 2f;
				}
				else
				{
					item.point = point + direction * Vector2.Det(point - point2, direction2) / num4;
				}
				item.direction = (direction2 - direction).Normalized;
				projectedLines.Add(item);
			}
			Vector2 vector = result;
			if (LinearProgram2(projectedLines, direction.Perpendicular, optimalDirection: true, ref result) < projectedLines.count)
			{
				result = vector;
			}
			num = num2;
		}
	}
}
