namespace ACT.DialogueSystem;

public static class DialogueIdGenerator
{
	private static Snowflake IdGenerator = new Snowflake(0, new Snowflake.UtcMSDateTimeProvider(2020, 1, 1));

	public static long NextId()
	{
		return IdGenerator.NextId();
	}
}
