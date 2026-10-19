using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行控制Bodyparts", "Action", new string[] { "control", "bodyparts", "state", "status", "tag" })]
public class ActionControlBodyparts : ConfigAction
{
	public enum ControlBodyPartType
	{
		stringArray,
		All
	}

	public string[] array;

	public bool result;

	public ControlBodyPartType controlType;

	public override void Do(ActionMemory memory)
	{
		MonoBodyPart[] bodyParts = memory.target.entity.GetMono().bodyParts;
		switch (controlType)
		{
		case ControlBodyPartType.stringArray:
		{
			string[] array2 = this.array;
			foreach (string text in array2)
			{
				MonoBodyPart[] array = bodyParts;
				foreach (MonoBodyPart monoBodyPart in array)
				{
					if (monoBodyPart.name == text)
					{
						monoBodyPart.SetRuntimeActive(result);
					}
				}
			}
			break;
		}
		case ControlBodyPartType.All:
		{
			MonoBodyPart[] array = bodyParts;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetRuntimeActive(result);
			}
			break;
		}
		}
	}
}
