using System.Collections.Generic;
using System.Threading.Tasks;

namespace Ase;

public interface IMapService
{
	Task<bool> RequestOpenMap(int id);

	Task<bool> RequestMapState(int id);

	int GetPlayerMark();

	void SetPlayerMark(int levelId);

	List<DRMap> GetAllLevelOpened();

	List<DRSectionMap> GetAllSectionOpened();

	List<DRWorldMap> GetAllWorldOpened();

	bool GetLevelOpenState(int id);

	bool GetLevelOpenState(DRMap drMap);

	bool GetSectionOpenState(int id);

	bool GetWorldOpenState(int id);

	List<DRMap> GetAllLevelInSection(int sectionId);

	List<DRSectionMap> GetAllSectionInWorld(int worldId);

	int GetLatestLevelInSection(int sectionId);

	DRMap GetLevelWithLatestMainTask();

	Task<(List<PbIdValue>, int)> GetCollectionsForStory(int mapId);
}
