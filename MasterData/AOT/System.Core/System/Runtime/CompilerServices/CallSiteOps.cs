using System.ComponentModel;
using System.Diagnostics;

namespace System.Runtime.CompilerServices;

[EditorBrowsable(EditorBrowsableState.Never)]
[DebuggerStepThrough]
public static class CallSiteOps
{
	[Obsolete("do not use this method", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static CallSite<T> CreateMatchmaker<T>(CallSite<T> site) where T : class
	{
		CallSite<T> callSite = site.CreateMatchMaker();
		callSite._match = true;
		return callSite;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static bool SetNotMatched(CallSite site)
	{
		bool match = site._match;
		site._match = false;
		return match;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static bool GetMatch(CallSite site)
	{
		return site._match;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static void ClearMatch(CallSite site)
	{
		site._match = true;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static void AddRule<T>(CallSite<T> site, T rule) where T : class
	{
		site.AddRule(rule);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static void UpdateRules<T>(CallSite<T> @this, int matched) where T : class
	{
		if (matched > 1)
		{
			@this.MoveRule(matched);
		}
	}

	[Obsolete("do not use this method", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static T[] GetRules<T>(CallSite<T> site) where T : class
	{
		return site.Rules;
	}

	[Obsolete("do not use this method", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static RuleCache<T> GetRuleCache<T>(CallSite<T> site) where T : class
	{
		return site.Binder.GetRuleCache<T>();
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static void MoveRule<T>(RuleCache<T> cache, T rule, int i) where T : class
	{
		if (i > 1)
		{
			cache.MoveRule(rule, i);
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static T[] GetCachedRules<T>(RuleCache<T> cache) where T : class
	{
		return cache.GetRules();
	}

	[Obsolete("do not use this method", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static T Bind<T>(CallSiteBinder binder, CallSite<T> site, object[] args) where T : class
	{
		return binder.BindCore(site, args);
	}
}
