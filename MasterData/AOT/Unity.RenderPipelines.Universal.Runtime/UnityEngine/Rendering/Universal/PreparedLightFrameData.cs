namespace UnityEngine.Rendering.Universal;

internal sealed class PreparedLightFrameData
{
	internal readonly PreparedVisibleLight[] visibleLights;

	internal readonly int[] punctualVisibleLightIndices;

	internal readonly int[] shadowCandidateVisibleLightIndices;

	internal readonly LightHaloCandidate[] haloCandidates;

	internal int visibleLightCount;

	internal int punctualLightCount;

	internal int shadowCandidateCount;

	internal int haloCandidateCount;

	internal PreparedLightFrameData(int capacity)
	{
		visibleLights = new PreparedVisibleLight[capacity];
		punctualVisibleLightIndices = new int[capacity];
		shadowCandidateVisibleLightIndices = new int[capacity];
		haloCandidates = new LightHaloCandidate[capacity];
	}

	internal void Complete(int preparedVisibleLightCount, int preparedPunctualLightCount, int preparedShadowCandidateCount, int preparedHaloCandidateCount)
	{
		for (int i = preparedVisibleLightCount; i < visibleLightCount; i++)
		{
			visibleLights[i] = default;
		}
		for (int j = preparedHaloCandidateCount; j < haloCandidateCount; j++)
		{
			haloCandidates[j] = default;
		}
		visibleLightCount = preparedVisibleLightCount;
		punctualLightCount = preparedPunctualLightCount;
		shadowCandidateCount = preparedShadowCandidateCount;
		haloCandidateCount = preparedHaloCandidateCount;
	}
}
