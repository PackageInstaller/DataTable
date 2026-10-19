using System;

namespace ACT.Config;

[Serializable]
public class RogueRoom
{
	public readonly int id;

	public readonly int roomType;

	public readonly int sceneType;

	public readonly int weight;

	public readonly int difficulty;

	public readonly string addressable = "";

	public readonly int[] blueprintList = new int[0];

	public readonly int[] monsterPointList = new int[0];

	public readonly int[] monsterPointParmList = new int[0];

	public readonly int eventInteractionId;

	public readonly int eventLibrary;

	public readonly int cardLibrary;

	public readonly int artifactLibrary;

	public readonly string caskAddressable = "";

	public RogueRoom(int id, int roomType, int sceneType, int weight, int difficulty, string addressable, int[] blueprintList, int[] monsterPointList, int[] monsterPointParmList, int eventInteractionId, int eventLibrary, int cardLibrary, int artifactLibrary, string caskAddressable)
	{
		this.id = id;
		this.roomType = roomType;
		this.sceneType = sceneType;
		this.weight = weight;
		this.difficulty = difficulty;
		this.addressable = addressable;
		this.blueprintList = blueprintList;
		this.monsterPointList = monsterPointList;
		this.monsterPointParmList = monsterPointParmList;
		this.eventInteractionId = eventInteractionId;
		this.eventLibrary = eventLibrary;
		this.cardLibrary = cardLibrary;
		this.artifactLibrary = artifactLibrary;
		this.caskAddressable = caskAddressable;
	}
}
