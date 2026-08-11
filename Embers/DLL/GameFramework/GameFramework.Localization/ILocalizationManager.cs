using Cysharp.Threading.Tasks;
using GameFramework.Resource;

namespace GameFramework.Localization;

public interface ILocalizationManager
{
	Language Language { get; set; }

	Language SystemLanguage { get; }

	void SetResourceManager(IResourceManager resourceManager);

	void SetLocalizationHelper(ILocalizationHelper localizationHelper);

	UniTask UpdateGlobalSource();

	string GetString(string key);

	string GetString(string key, object arg0);

	string GetString(string key, object arg0, object arg1);

	string GetString(string key, object arg0, object arg1, object arg2);

	string GetString(string key, params object[] args);
}
