using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface IAnnouncementService
{
	IMessenger GetMessager();

	UniTask<bool> RequestNoticeData();

	UniTask<bool> RequestAllNoticeData();

	List<AnnouncementData> GetAnnouncementData();

	AnnouncementData GetAnnouncementById(long id);

	List<long> GetUnReadList();

	bool SetRead(long id);
}
