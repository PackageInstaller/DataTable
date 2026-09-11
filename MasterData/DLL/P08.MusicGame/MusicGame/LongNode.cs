using UnityEngine;

namespace MusicGame;

internal class LongNode : BaseNode
{
	public int startTime;

	public int renderTime;

	public float offsetY = 2.6f;

	public SpriteRenderer _sprRend;

	public Transform _handle;

	private bool pressState;

	public bool valid = true;

	private Color32 beginColor = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, 150);

	private Color32 endColor = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, 40);

	public void Awake()
	{
		pressState = false;
		ChangeValid(value: false);
	}

	public void ChangeValid(bool value)
	{
		if (value != valid)
		{
			valid = value;
			_sprRend.color = (valid ? beginColor : endColor);
		}
	}

	public bool GetValid()
	{
		return valid;
	}

	public void SetPressState(bool value)
	{
		pressState = value;
	}

	public void StartNode(int startTime, int endTime)
	{
		reachTime = endTime;
		this.startTime = startTime;
		pressState = false;
		renderTime = this.startTime;
		_sprRend.size = new Vector2(_sprRend.size.x, 0f);
		ChangeValid(value: true);
	}

	private void NormalTrack(int currentTime)
	{
		float num = MusicController.GetNodePosition(reachTime) - MusicController.GetNodePosition(renderTime) + offsetY;
		_sprRend.size = new Vector2(_sprRend.size.x, num);
		float y = MusicController.GetNodePosition(renderTime) - MusicController.GetNodePosition(currentTime) + num / 2f;
		_sprRend.transform.localPosition = new Vector3(0f, y, 0f);
		float y2 = num / 2f;
		_handle.localPosition = new Vector3(0f, y2, 0f);
	}

	private void ConstantTrack(int currentTime)
	{
		float newPositionConstant = MusicController.GetNewPositionConstant(currentTime, renderTime);
		float newPositionConstant2 = MusicController.GetNewPositionConstant(currentTime, reachTime);
		float num = 0f;
		float num2 = newPositionConstant2 - newPositionConstant + num;
		if (num2 >= 0f)
		{
			_sprRend.size = new Vector2(_sprRend.size.x, num2);
			_sprRend.transform.localPosition = new Vector3(0f, newPositionConstant2 - num2 / 2f, 0f);
		}
		else
		{
			num2 = 99f;
			_sprRend.size = new Vector2(_sprRend.size.x, num2);
			_sprRend.transform.localPosition = new Vector3(0f, newPositionConstant + num2 / 2f - num, 0f);
		}
		float y = num2 * 0.5f;
		_handle.localPosition = new Vector3(0f, y, 0f);
	}

	public override void Process(int currentTime)
	{
		if (valid)
		{
			if (startTime + MusicController.longStartArea < currentTime && !pressState)
			{
				Track.MusicNodeHit(MusicNodeHitRating.Miss, MusicNodeHitType.None);
				ChangeValid(value: false);
			}
			if (pressState)
			{
				renderTime = Mathf.Max(currentTime, startTime);
			}
		}
		base.transform.localPosition = Vector3.zero;
		if (MusicController.isConstant)
		{
			ConstantTrack(currentTime);
		}
		else
		{
			NormalTrack(currentTime);
		}
	}

	public override bool Check(int currentTime, int musicLength)
	{
		if (reachTime < currentTime)
		{
			return true;
		}
		return false;
	}

	public override NodeType GetNodeType()
	{
		return NodeType.Long;
	}
}
