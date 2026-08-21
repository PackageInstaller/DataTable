using System.Collections.Generic;
using System.Globalization;

namespace Yarn.Unity;

public class TextLineProvider : LineProviderBehaviour
{
	[Language]
	public string textLanguageCode = CultureInfo.CurrentCulture.Name;

	public override bool LinesAvailable => true;

	public override string LocaleCode => textLanguageCode;

	public override LocalizedLine GetLocalizedLine(Line line)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		string localizedString = base.YarnProject.GetLocalization(textLanguageCode).GetLocalizedString(line.ID);
		return new LocalizedLine
		{
			TextID = line.ID,
			RawText = localizedString,
			Substitutions = line.Substitutions,
			Metadata = base.YarnProject.lineMetadata.GetMetadata(line.ID)
		};
	}

	public override void PrepareForLines(IEnumerable<string> lineIDs)
	{
	}
}
