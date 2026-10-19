using System;
using System.Collections.Generic;
using System.Reflection;

namespace Proxima;

internal class ProximaFeatures
{
	[ProximaCommand("Internal", "", "", "", "")]
	public static List<string> GetInstalledFeatures()
	{
		List<string> list = new List<string>();
		Assembly assembly = Assembly.GetAssembly(typeof(ProximaInspector));
		if (assembly.GetType("Proxima.ProximaConsoleCommands") != null)
		{
			list.Add("console");
		}
		if (assembly.GetType("Proxima.ProximaProComponentCommands") != null)
		{
			list.Add("inspectorEdit");
		}
		if (assembly.GetType("Proxima.ProximaProfilerCommands") != null)
		{
			list.Add("profiler");
		}
		return list;
	}

	public static void RegisterProFeatures()
	{
		ProximaInspector.RegisterCommands<ProximaFeatures>();
		Assembly assembly = Assembly.GetAssembly(typeof(ProximaInspector));
		Type type = assembly.GetType("Proxima.ProximaConsoleCommands");
		if (type != null)
		{
			ProximaInspector.RegisterCommands(type);
		}
		Type type2 = assembly.GetType("Proxima.ProximaProComponentCommands");
		if (type2 != null)
		{
			ProximaInspector.RegisterCommands(type2);
		}
		Type type3 = assembly.GetType("Proxima.ProximaProfilerCommands");
		if (type3 != null)
		{
			ProximaInspector.RegisterCommands(type3);
		}
	}

	public static bool AllFeaturesInstalled()
	{
		return GetInstalledFeatures().Count == 3;
	}
}
