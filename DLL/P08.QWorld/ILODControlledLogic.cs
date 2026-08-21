using UnityEngine;

public interface ILODControlledLogic
{
	Bounds Bounds { get; }

	bool Culled { get; set; }

	int LOD { get; set; }

	int UpdateRate => LOD + 1;

	void Init();

	void Shutdown();

	void UpdateLogic(float dt, QWorldMapCull.QWorldCullResult cullResult);
}
