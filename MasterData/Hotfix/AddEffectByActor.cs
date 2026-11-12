using System.Collections.Generic;

public class AddEffectByActor
{
	public readonly int actorId;

	public readonly List<AddEffectInfo> effectInfos;

	public AddEffectByActor(int actorId, List<AddEffectInfo> effectInfos)
	{
		this.actorId = actorId;
		this.effectInfos = effectInfos;
	}
}
