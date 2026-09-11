namespace System.Globalization;

internal interface ISimpleCollator
{
	SortKey GetSortKey(string source, CompareOptions options);

	int Compare(string s1, int idx1, int len1, string s2, int idx2, int len2, CompareOptions options);

	bool IsPrefix(string src, string target, CompareOptions opt);

	bool IsSuffix(string src, string target, CompareOptions opt);

	int IndexOf(string s, string target, int start, int length, CompareOptions opt);

	int LastIndexOf(string s, string target, int start, int length, CompareOptions opt);
}
