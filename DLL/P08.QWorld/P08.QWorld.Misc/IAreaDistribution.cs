using System.Collections.Generic;
using UnityEngine;

namespace P08.QWorld.Misc;

public interface IAreaDistribution
{
	public struct PosRecord(Transform trs) : ISerializationCallbackReceiver
	{
		public Vector3 position = trs.position;

		public Quaternion rotation = trs.rotation;

		public void OnAfterDeserialize()
		{
		}

		public void OnBeforeSerialize()
		{
		}
	}

	void SetSize(Vector3 size);

	Bounds WorldBounds(Transform trs);

	IEnumerable<PosRecord> DistributePos(Transform trs, int cnt);

	IEnumerable<PosRecord> DistributeWorldPos(Transform trs, int cnt);

	IEnumerable<Vector3> RndWorldPos(Transform trs, int cnt);

	protected static Quaternion RndLookRot()
	{
		Vector2 insideUnitCircle = Random.insideUnitCircle;
		return Quaternion.LookRotation(new Vector3(insideUnitCircle.x, 0f, insideUnitCircle.y));
	}
}
