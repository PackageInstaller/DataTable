using UnityEngine;

namespace Pinball;

public class GainBallItem : BallPolygon
{
	public GainBallItem(int uniqueId, GameObject go, Vector2 origin)
		: base(uniqueId, go, origin, 1, PolygonType.gainBallItem)
	{
		vertexCount = 4;
		vertex = new Vector2[vertexCount];
		normal = new Vector2[vertexCount];
		vertex[0] = new Vector2(origin.x, origin.y);
		vertex[1] = new Vector2(origin.x + 1f, origin.y);
		vertex[2] = new Vector2(origin.x + 1f, origin.y - 1f);
		vertex[3] = new Vector2(origin.x, origin.y - 1f);
		normal[0] = Vector2.up;
		normal[1] = Vector2.right;
		normal[2] = Vector2.down;
		normal[3] = Vector2.left;
		BindEffectPs();
		EnterAnim();
	}

	public override BallPolygon Clone()
	{
		if (go == null)
		{
			return new GainBallItem(uniqueId, null, Vector2.zero);
		}
		return new GainBallItem(uniqueId, null, GetLocalPosition());
	}

	public override float CheckCollision(Vector2 ballPosition, Vector2 ballVelocity, float ballRadius, out Vector2 newPosition, out Vector2 newVelocity)
	{
		float num = 560000f;
		newPosition = Vector2.zero;
		newVelocity = Vector2.zero;
		for (int i = 0; i < vertexCount; i++)
		{
			Vector2 lineStart = vertex[i];
			Vector2 lineEnd = vertex[(i + 1) % vertexCount];
			Vector2 lineNormal = normal[i];
			Vector2 resPos = Vector2.zero;
			Vector2 resVel = Vector2.zero;
			float num2 = PinballKinematicLib.CalculateCollision(ballPosition, ballVelocity, ballRadius, lineStart, lineEnd, lineNormal, out resPos, out resVel);
			if (num2 > 0f && num2 < num)
			{
				num = num2;
				newPosition = resPos;
				newVelocity = resVel;
			}
		}
		return num;
	}

	public override void TriggerPolygonEffect()
	{
	}

	public override void TriggerPolygonEffect(Ball ball)
	{
	}

	public override void TriggerPolygonCallBackEffect()
	{
	}

	public override void OnCollision(Ball ball)
	{
		BreakAnim(playerBreak: true);
		PinballGameManager.Instance.AddUIDToRemoveList(uniqueId);
		PinballGameManager.Instance.AddNewBall(show: false, BallType.normalBall);
	}

	public override int OnRoundAfter()
	{
		return 1;
	}
}
