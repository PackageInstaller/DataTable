using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering;

public sealed class ProbeReferenceVolumeProfile : ScriptableObject
{
	internal enum Version
	{
		Initial
	}

	[SerializeField]
	private Version version = CoreUtils.GetLastEnumValue<Version>();

	[Range(2f, 5f)]
	public int simplificationLevels = 3;

	[Min(0.1f)]
	public float minDistanceBetweenProbes = 1f;

	public int cellSizeInBricks => (int)Mathf.Pow(3f, simplificationLevels);

	public int maxSubdivision => simplificationLevels + 1;

	public float minBrickSize => Mathf.Max(0.01f, minDistanceBetweenProbes * 3f);

	public float cellSizeInMeters => (float)cellSizeInBricks * minBrickSize;

	private void OnEnable()
	{
		_ = version;
		CoreUtils.GetLastEnumValue<Version>();
	}

	public bool IsEquivalent(ProbeReferenceVolumeProfile otherProfile)
	{
		if (minDistanceBetweenProbes == otherProfile.minDistanceBetweenProbes && cellSizeInMeters == otherProfile.cellSizeInMeters)
		{
			return simplificationLevels == otherProfile.simplificationLevels;
		}
		return false;
	}
}
