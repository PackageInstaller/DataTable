namespace Sirenix.Serialization;

public interface IDictionaryKeyPathProvider
{
	string ProviderID { get; }

	string GetPathStringFromKey(object key);

	object GetKeyFromPathString(string pathStr);

	int Compare(object x, object y);
}
public interface IDictionaryKeyPathProvider<T> : IDictionaryKeyPathProvider
{
	string GetPathStringFromKey(T key);

	new T GetKeyFromPathString(string pathStr);

	int Compare(T x, T y);
}
