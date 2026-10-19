using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMAnimation
{
	public static class Data
	{
		public struct Create(Animator animator)
		{
			public Animator animator = animator;
		}
	}

	public static Data.Create Create(this Animator animator)
	{
		return new Data.Create(animator);
	}
}
