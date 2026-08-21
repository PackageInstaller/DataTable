using System.Collections.Generic;
using UnityEngine;

namespace Yarn.Unity.UnityLocalization;

public class UnityLocalisedLineProvider : LineProviderBehaviour
{
	public override string LocaleCode => "error";

	public override bool LinesAvailable => true;

	public override void PrepareForLines(IEnumerable<string> lineIDs)
	{
		Debug.LogError("UnityLocalisedLineProvider requires that the Unity Localization package is installed in the project. To fix this, install Unity Localization.");
	}

	public override void Start()
	{
		Debug.LogError("UnityLocalisedLineProvider requires that the Unity Localization package is installed in the project. To fix this, install Unity Localization.");
	}

	public override LocalizedLine GetLocalizedLine(Line line)
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		Debug.LogError("UnityLocalisedLineProvider: Can't create a localised line for ID " + line.ID + " because the Unity Localization package is not installed in this project. To fix this, install Unity Localization.");
		return new LocalizedLine
		{
			TextID = line.ID,
			RawText = line.ID + ": Unable to create a localised line, because the Unity Localization package is not installed in this project.",
			Substitutions = line.Substitutions
		};
	}
}
