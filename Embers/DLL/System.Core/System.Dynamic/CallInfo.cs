using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Linq.Expressions;

namespace System.Dynamic;

public sealed class CallInfo
{
	public int ArgumentCount { get; }

	public ReadOnlyCollection<string> ArgumentNames { get; }

	public CallInfo(int argCount, IEnumerable<string> argNames)
	{
		ContractUtils.RequiresNotNull(argNames, "argNames");
		ReadOnlyCollection<string> readOnlyCollection = argNames.ToReadOnly();
		if (argCount < readOnlyCollection.Count)
		{
			throw Error.ArgCntMustBeGreaterThanNameCnt();
		}
		ContractUtils.RequiresNotNullItems(readOnlyCollection, "argNames");
		ArgumentCount = argCount;
		ArgumentNames = readOnlyCollection;
	}

	public override int GetHashCode()
	{
		return ArgumentCount ^ ArgumentNames.ListHashCode();
	}

	public override bool Equals(object obj)
	{
		if (obj is CallInfo callInfo && ArgumentCount == callInfo.ArgumentCount)
		{
			return ArgumentNames.ListEquals(callInfo.ArgumentNames);
		}
		return false;
	}
}
