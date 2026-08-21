using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IMailService
{
	bool IsMailDataRequested { get; }

	UniTask<bool> RequestMailData();

	UniTask<bool> ReceiveMails();

	UniTask<bool> MailRead(long mailId);

	UniTask<MailAttachmentGetInfo> MailGetAttach(long mailId = 0L);

	UniTask<List<long>> MailDelete(long mailId = 0L);

	MailViewModel GetMailViewModel();

	Dictionary<long, MailData> GetMailDatas();

	UniTask<MailAttachmentGetInfo> SendGetPackRequest(List<MailGiftPack> mailGiftPacks);
}
