using System;
using System.Collections.Generic;

namespace Spine;

public class AnimationStateData
{
	public struct AnimationPair(Animation a1, Animation a2)
	{
		public readonly Animation a1 = a1;

		public readonly Animation a2 = a2;

		public override string ToString()
		{
			return a1.name + "->" + a2.name;
		}
	}

	public class AnimationPairComparer : IEqualityComparer<AnimationPair>
	{
		public static readonly AnimationPairComparer Instance = new AnimationPairComparer();

		bool IEqualityComparer<AnimationPair>.Equals(AnimationPair x, AnimationPair y)
		{
			if (x.a1 == y.a1)
			{
				return x.a2 == y.a2;
			}
			return false;
		}

		int IEqualityComparer<AnimationPair>.GetHashCode(AnimationPair obj)
		{
			int hashCode = obj.a1.GetHashCode();
			return ((hashCode << 5) + hashCode) ^ obj.a2.GetHashCode();
		}
	}

	internal SkeletonData skeletonData;

	private readonly Dictionary<AnimationPair, float> animationToMixTime = new Dictionary<AnimationPair, float>(AnimationPairComparer.Instance);

	internal float defaultMix;

	public SkeletonData SkeletonData => skeletonData;

	public float DefaultMix
	{
		get
		{
			return defaultMix;
		}
		set
		{
			defaultMix = value;
		}
	}

	public AnimationStateData(SkeletonData skeletonData)
	{
		if (skeletonData == null)
		{
			throw new ArgumentException("skeletonData cannot be null.", "skeletonData");
		}
		this.skeletonData = skeletonData;
	}

	public void SetMix(string fromName, string toName, float duration)
	{
		Animation animation = skeletonData.FindAnimation(fromName);
		if (animation == null)
		{
			throw new ArgumentException("Animation not found: " + fromName, "fromName");
		}
		Animation animation2 = skeletonData.FindAnimation(toName);
		if (animation2 == null)
		{
			throw new ArgumentException("Animation not found: " + toName, "toName");
		}
		SetMix(animation, animation2, duration);
	}

	public void SetMix(Animation from, Animation to, float duration)
	{
		if (from == null)
		{
			throw new ArgumentNullException("from", "from cannot be null.");
		}
		if (to == null)
		{
			throw new ArgumentNullException("to", "to cannot be null.");
		}
		AnimationPair key = new AnimationPair(from, to);
		animationToMixTime.Remove(key);
		animationToMixTime.Add(key, duration);
	}

	public float GetMix(Animation from, Animation to)
	{
		if (from == null)
		{
			throw new ArgumentNullException("from", "from cannot be null.");
		}
		if (to == null)
		{
			throw new ArgumentNullException("to", "to cannot be null.");
		}
		AnimationPair key = new AnimationPair(from, to);
		if (animationToMixTime.TryGetValue(key, out var value))
		{
			return value;
		}
		return defaultMix;
	}
}
