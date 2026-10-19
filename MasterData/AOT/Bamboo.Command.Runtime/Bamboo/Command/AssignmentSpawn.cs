using System;
using System.Collections.Generic;

namespace Bamboo.Command;

public static class AssignmentSpawn
{
	private const string DEFAULT_ADAPTER_NAME = "Default";

	private static readonly ISpawnAdapter _defaultAdapter;

	private static readonly Dictionary<string, ISpawnAdapter> _adapterMap;

	public static ISpawnAdapter DefaultAdapter => _defaultAdapter;

	static AssignmentSpawn()
	{
		List<Type> typesFromBaseType = ReflectionHelper.GetTypesFromBaseType(typeof(ISpawnAdapter));
		if (typesFromBaseType.Count == 0)
		{
			throw new Exception("types.Count is 0.");
		}
		_adapterMap = new Dictionary<string, ISpawnAdapter>(typesFromBaseType.Count);
		foreach (Type item in typesFromBaseType)
		{
			ISpawnAdapter spawnAdapter = Activator.CreateInstance(item) as ISpawnAdapter;
			_adapterMap.Add(spawnAdapter.Name, spawnAdapter);
			if (spawnAdapter.Name == "Default")
			{
				_defaultAdapter = spawnAdapter;
			}
		}
		if (_defaultAdapter == null)
		{
			throw new Exception("Default Adapter is null.");
		}
	}

	public static ISpawnAdapter GetAdapter(string adapterName)
	{
		_adapterMap.TryGetValue(adapterName, out var value);
		return value;
	}
}
