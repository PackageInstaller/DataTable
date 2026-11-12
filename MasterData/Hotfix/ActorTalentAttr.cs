using Google.Protobuf.Collections;

public struct ActorTalentAttr(int nCharId)
{
	public int nId = nCharId;

	public RepeatedField<int> effectIds = new RepeatedField<int>();

	public static ActorTalentAttr Empty = new ActorTalentAttr(0);
}
