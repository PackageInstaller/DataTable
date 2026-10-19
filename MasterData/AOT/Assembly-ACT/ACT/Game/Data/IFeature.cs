using System.Collections.Generic;

namespace ACT.Game.Data;

public interface IFeature
{
	int GetFeatureData(int featureID, bool clamp = true);

	int GetFeatureData(int featureID, FeatureData.FeatureSourceType sourceType, bool clamp = true);

	void GetAllFeatureIDs(List<int> output);
}
