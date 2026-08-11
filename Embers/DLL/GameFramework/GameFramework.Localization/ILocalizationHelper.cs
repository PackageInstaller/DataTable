namespace GameFramework.Localization;

public interface ILocalizationHelper
{
	Language Language { get; set; }

	Language SystemLanguage { get; }

	void Init();

	string GetString(string key);

	string GetString(string key, object arg0);

	string GetString(string key, object arg0, object arg1);

	string GetString(string key, object arg0, object arg1, object arg2);

	string GetString(string key, params object[] args);
}
