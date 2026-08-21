using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class BulletMorphedData : IReference
{
	public Vector3 position;

	public float angle;

	public Vector3 localScale;

	public List<float> values;

	public void Init(Vector3 position, float angle, List<float> values)
	{
		this.position = position;
		this.angle = angle;
		this.values = values;
		localScale = Vector3.one;
	}

	public void Clear()
	{
		values = null;
	}
}
