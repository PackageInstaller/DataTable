using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IGameNoteService
{
	UniTask<bool> RequestGameNoteData();

	UniTask<bool> RequestGameNoteData(int type);

	List<long> GetTimelineList();

	List<long> GetBranchTimelineList();

	List<long> GetActivityTimelineList();

	List<long> GetMonsterList();

	List<long> GetCollection();

	void SaveRedPoint(int type, int id);

	Dictionary<string, RedPointSave> GetRedPointService(int type);

	bool LoadHeroRedPoint(int heroId, int tabIndex, int id);

	void SaveHeroRedPoint(int heroId, int tabIndex, int id);

	void SaveHeroRedPoint(int heroId);

	Dictionary<int, Dictionary<string, bool>> GetHeroRedPoint();

	void AddRedPointAction(Action<bool> action);
}
