using System;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface ITimeService
{
	UniTask<bool> RequestServerRefreshHour();

	int GetDailyUpdateHour();

	Task<long> GetServiceTime();

	long GetLeftUpdateSeconds();

	TimeSpan GetLeftServiceTime(long targetTimeStamp);

	void UpdateRealisticTimer();

	void GoldFingerForceUpdateRealisticTimer(long GoldFingerTime);

	void AddDailyUpdateAction(Action action);

	void RemoveDailyUpdateAction(Action action);

	long GetCurServerTime();

	DateTime GetCurServerDateTime();

	void SetCurServerTimeGoldenfinger(long testServerTime);

	void AddNormalSecondUpdateAction(Action<long> action);

	void RemoveNormalSecondUpdateAction(Action<long> action);

	void AddTimeDuraSettle(TimeDuraSettle timeDuraSettle);

	void RemoveTimeDuraSettle(TimeDuraSettle timeDuraSettle);

	void ClearTimeDureByTag(GroupTagEnum tag);

	int GetCurDayOfWeek();

	void Dispose();

	bool CheckNextDay(long time);
}
