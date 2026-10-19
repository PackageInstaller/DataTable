using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行控制SonColliders", "Action", new string[] { "control", "son", "colliders", "state", "status", "tag" })]
public class ActionControlSonColliders : ConfigAction
{
	public enum ControlSonColliderType
	{
		stringArray,
		All
	}

	public string[] array;

	public bool result;

	public ControlSonColliderType controlType;

	public override void Do(ActionMemory memory)
	{
		SonCollider[] sonColliders = memory.target.entity.GetMono().sonColliders;
		switch (controlType)
		{
		case ControlSonColliderType.stringArray:
		{
			string[] array2 = this.array;
			foreach (string text in array2)
			{
				SonCollider[] array = sonColliders;
				foreach (SonCollider sonCollider in array)
				{
					if (sonCollider.name == text)
					{
						sonCollider.gameObject.SafeSetActive(result);
					}
				}
			}
			break;
		}
		case ControlSonColliderType.All:
		{
			SonCollider[] array = sonColliders;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].gameObject.SafeSetActive(result);
			}
			break;
		}
		}
	}
}
