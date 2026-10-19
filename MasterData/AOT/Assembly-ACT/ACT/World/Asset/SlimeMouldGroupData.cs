using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class SlimeMouldGroupData : IDataToBake
{
	[SerializeField]
	private Pos[] _modelPos;

	public Pos[] ModelPos => _modelPos;

	public void Bake(object baker)
	{
	}
}
