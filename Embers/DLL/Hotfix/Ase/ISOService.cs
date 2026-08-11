using Cysharp.Threading.Tasks;

namespace Ase;

public interface ISOService
{
	UniTask InitServices();

	UniTask<bool> RequestData();

	bool GetState(int serviceId);

	bool GetServiceInBanState(int serviceId);

	bool CheckGuideComplete();

	void Dispose();
}
