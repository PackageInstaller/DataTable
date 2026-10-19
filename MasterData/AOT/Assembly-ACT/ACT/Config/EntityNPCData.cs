using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EntityNPCData
{
	public readonly int id;

	public readonly int nameLocal;

	public readonly string config = "";

	public readonly string showModel = "";

	public readonly int npcStateId;

	public readonly List<Vector> npcPosition;

	public readonly List<Vector> npcRotation;

	public readonly float Focus;

	public readonly int FOV;

	public readonly int CameraPushinDuration;

	public readonly int CameraPulloutDuration;

	public readonly int LensDistance;

	public EntityNPCData(int id, int nameLocal, string config, string showModel, int npcStateId, List<Vector> npcPosition, List<Vector> npcRotation, float Focus, int FOV, int CameraPushinDuration, int CameraPulloutDuration, int LensDistance)
	{
		this.id = id;
		this.nameLocal = nameLocal;
		this.config = config;
		this.showModel = showModel;
		this.npcStateId = npcStateId;
		this.npcPosition = npcPosition;
		this.npcRotation = npcRotation;
		this.Focus = Focus;
		this.FOV = FOV;
		this.CameraPushinDuration = CameraPushinDuration;
		this.CameraPulloutDuration = CameraPulloutDuration;
		this.LensDistance = LensDistance;
	}
}
