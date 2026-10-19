namespace UnityEngine.Rendering.Universal;

public static class CharacterShadowRegistry
{
	public sealed class Registration
	{
		internal HDShadow.HDTarget Target;
	}

	public const int MaxShadowCount = 4;

	public static Registration Register(GameObject owner)
	{
		if (owner == null)
		{
			return null;
		}
		HDShadow.HDTarget hDTarget = HDShadow.RegisterTarget(owner.GetInstanceID(), owner);
		if (hDTarget != null)
		{
			return new Registration
			{
				Target = hDTarget
			};
		}
		return null;
	}

	public static void Unregister(Registration registration)
	{
		if (registration != null)
		{
			HDShadow.UnregisterTarget(registration.Target);
			registration.Target = null;
		}
	}
}
