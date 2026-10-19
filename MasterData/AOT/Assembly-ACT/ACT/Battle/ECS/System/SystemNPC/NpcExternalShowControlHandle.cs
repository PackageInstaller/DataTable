using UnityEngine;

namespace ACT.Battle.ECS.System.SystemNPC;

public struct NpcExternalShowControlHandle
{
	public int Oid { get; }

	public int NpcConfigUid { get; }

	public bool Visible { get; }

	public bool HasWorldPosition { get; }

	public Vector3 WorldPosition { get; }

	public bool HasWorldRotation { get; }

	public Vector3 WorldRotation { get; }

	public bool Applied { get; internal set; }

	public bool IsValid { get; internal set; }

	public NpcShowControlSource ControlSource { get; internal set; }

	internal NpcExternalShowControlHandle(int oid, int npcConfigUid, bool visible, bool hasWorldPosition, Vector3 worldPosition, bool hasWorldRotation, Vector3 worldRotation)
	{
		Oid = oid;
		NpcConfigUid = npcConfigUid;
		Visible = visible;
		HasWorldPosition = hasWorldPosition;
		WorldPosition = worldPosition;
		HasWorldRotation = hasWorldRotation;
		WorldRotation = worldRotation;
		ControlSource = (visible ? NpcShowControlSource.ForceShow : NpcShowControlSource.ForceHide);
		Applied = false;
		IsValid = true;
	}
}
