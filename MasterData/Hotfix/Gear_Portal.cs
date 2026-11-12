using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class Gear_Portal : GearBase
{
	public Portal_End[] ends;

	public GameObject triggerFx;

	private readonly Dictionary<Brick_BallBase, HashSet<Portal_End>> _suppressed = new Dictionary<Brick_BallBase, HashSet<Portal_End>>(BrickBallRefComparer.Instance);

	private static readonly List<Brick_BallBase> _pruneTmp = new List<Brick_BallBase>();

	protected override void OnInit()
	{
		if (ends != null)
		{
			for (int i = 0; i < ends.Length; i++)
			{
				ends[i]?.InitData(this);
			}
		}
	}

	protected override void OnActive()
	{
		_suppressed.Clear();
		if (ends == null)
		{
			return;
		}
		for (int i = 0; i < ends.Length; i++)
		{
			if (ends[i] != null)
			{
				ends[i].ActiveSelf = true;
			}
		}
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		_suppressed.Clear();
	}

	public void OnEndHit(Portal_End src, Brick_BallBase ball, TSVector2 hitPoint, TSVector2 inDir)
	{
		if (src == null || ball == null || (_suppressed.TryGetValue(ball, out var value) && value.Contains(src)))
		{
			return;
		}
		TSVector2 forward = src.Collider.tsTransform.Forward;
		if (Dot(inDir, forward) >= 0)
		{
			return;
		}
		Portal_End partner = GetPartner(src);
		if (!(partner == null))
		{
			TSVector2 right = src.Collider.tsTransform.Right;
			TSVector2 position = src.Collider.tsTransform.Position;
			TSVector2 forward2 = partner.Collider.tsTransform.Forward;
			TSVector2 right2 = partner.Collider.tsTransform.Right;
			TSVector2 position2 = partner.Collider.tsTransform.Position;
			TSVector2 a = hitPoint - position;
			FP fP = Dot(a, forward);
			FP fP2 = Dot(a, right);
			TSVector2 position3 = position2 + right2 * fP2 + forward2 * fP;
			FP fP3 = Dot(inDir, forward);
			FP fP4 = Dot(inDir, right);
			TSVector2 normalized = (right2 * fP4 + forward2 * -fP3).normalized;
			FP fP5 = 0.342f;
			FP fP6 = 0.9397f;
			FP fP7 = FP.Abs(normalized.y);
			FP fP8 = ((normalized.y >= 0) ? 1 : (-1));
			if (fP7 < fP5)
			{
				normalized = new TSVector2(normalized.x, fP5 * fP8).normalized;
			}
			else if (fP7 > fP6)
			{
				normalized = new TSVector2(normalized.x, fP6 * fP8).normalized;
			}
			ball.tsTransform.Position = position3;
			ball.SetMoveDirection(normalized);
			ball.OnTeleported();
			if (!_suppressed.TryGetValue(ball, out value))
			{
				value = new HashSet<Portal_End>();
				_suppressed.set_Item(ball, value);
			}
			value.Add(partner);
			partner.StartImmune(ball);
			if (triggerFx != null)
			{
				AdventureFXPlayer.PlayFX(triggerFx, 1f, src.transform.position, Quaternion.identity);
				AdventureFXPlayer.PlayFX(triggerFx, 1f, partner.transform.position, Quaternion.identity);
			}
		}
	}

	public void OnEndStep(Portal_End end, Brick_BallBase ball, TSVector2 curPos)
	{
		if (!(end == null) && !(ball == null) && _suppressed.TryGetValue(ball, out var value) && value.Contains(end) && !end.ContainsPoint(curPos))
		{
			value.Remove(end);
			if (value.Count == 0)
			{
				_suppressed.Remove(ball);
			}
		}
	}

	public void PruneSuppressed(List<Brick_BallBase> balls)
	{
		if (_suppressed.Count == 0)
		{
			return;
		}
		_pruneTmp.Clear();
		foreach (KeyValuePair<Brick_BallBase, HashSet<Portal_End>> item in _suppressed)
		{
			if (item.Key == null || balls == null || !balls.Contains(item.Key))
			{
				_pruneTmp.Add(item.Key);
			}
		}
		for (int i = 0; i < _pruneTmp.Count; i++)
		{
			_suppressed.Remove(_pruneTmp.get_Item(i));
		}
	}

	private Portal_End GetPartner(Portal_End src)
	{
		if (ends == null)
		{
			return null;
		}
		for (int i = 0; i < ends.Length; i++)
		{
			if (ends[i] != null && ends[i] != src)
			{
				return ends[i];
			}
		}
		return null;
	}

	private static FP Dot(TSVector2 a, TSVector2 b)
	{
		return a.x * b.x + a.y * b.y;
	}
}
