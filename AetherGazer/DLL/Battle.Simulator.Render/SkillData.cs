using System.Collections.Generic;
using UnityEngine;

public class SkillData
{
	public int length;

	public int actionId;

	public List<string> effects = new List<string>();

	public List<string> attchment = new List<string>();

	public List<Vector3> offset = new List<Vector3>();

	public List<Vector3> rotate = new List<Vector3>();

	public List<bool> follow = new List<bool>();

	public string GetEffect(int stage)
	{
		if (stage >= 0 && stage < effects.Count)
		{
			return effects[stage];
		}
		return string.Empty;
	}

	public string GetAttchment(int stage)
	{
		if (stage >= 0 && stage < attchment.Count)
		{
			return attchment[stage];
		}
		return string.Empty;
	}

	public Vector3 GetOffset(int stage)
	{
		if (stage >= 0 && stage < offset.Count)
		{
			return offset[stage];
		}
		return Vector3.zero;
	}

	public Vector3 GetRotate(int stage)
	{
		if (stage >= 0 && stage < rotate.Count)
		{
			return rotate[stage];
		}
		return Vector3.zero;
	}

	public bool GetFollow(int stage)
	{
		if (stage >= 0 && stage < rotate.Count)
		{
			return follow[stage];
		}
		return false;
	}
}
