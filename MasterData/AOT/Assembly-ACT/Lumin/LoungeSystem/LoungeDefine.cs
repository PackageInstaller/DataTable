namespace Lumin.LoungeSystem;

public static class LoungeDefine
{
	public enum InteractionType
	{
		TriggerGlobalStory,
		PersonalStory,
		Gift,
		Chat,
		BackToMain,
		Touch
	}

	public enum LoungeStoryType
	{
		LoungeGlobalStory = 101,
		TriggerGlobalStory = 102,
		PersonalStory = 201
	}

	public enum LoungeStoryResourceType
	{
		Timeline = 1,
		AVG
	}

	public enum MoodState
	{
		VeryHappy,
		Happy,
		Normal,
		Unhappy,
		Sad
	}

	public enum RoomType
	{
		doorWay = 1,
		roomCell
	}

	public enum EventType
	{
		Birthday,
		Festival,
		Story,
		Random,
		Daily
	}

	public enum DialogueEmotion
	{
		Normal,
		Happy,
		Shy,
		Angry,
		Sad,
		Surprised,
		Confused
	}

	public const int MaxCharactersPerRoom = 5;
}
