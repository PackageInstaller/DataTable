using GameFramework.Runtime;

namespace Ase;

public interface IBannerService
{
	void RequestBannerDataAfterLogin();

	IMessenger GetMessager();

	BannerInfo GetBannerWaitShow();

	void SetBannerNull();

	void SetBannerShowed(int id, bool useCd);
}
