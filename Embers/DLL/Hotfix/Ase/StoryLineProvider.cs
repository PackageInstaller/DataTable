using System.Collections.Generic;
using System.Globalization;
using System.Text.RegularExpressions;
using Yarn;
using Yarn.Unity;

namespace Ase;

public class StoryLineProvider : LineProviderBehaviour
{
	[Language]
	public string textLanguageCode = CultureInfo.CurrentCulture.Name;

	public override bool LinesAvailable => true;

	public override string LocaleCode => textLanguageCode;

	public override LocalizedLine GetLocalizedLine(Line line)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		string localizedString = base.YarnProject.GetLocalization(textLanguageCode).GetLocalizedString(line.ID);
		localizedString = GetAndReplaceAudioIdWithRegex(localizedString, out var audioId);
		return new LocalizedLine
		{
			TextID = line.ID,
			AudioId = audioId,
			RawText = ReplaceUsernameWithRegex(localizedString, StoryUtility.GetName()),
			Substitutions = line.Substitutions,
			Metadata = base.YarnProject.lineMetadata.GetMetadata(line.ID)
		};
	}

	public override void PrepareForLines(IEnumerable<string> lineIDs)
	{
	}

	private string ReplaceUsernameWithRegex(string template, string username)
	{
		string pattern = "USERNAME";
		return Regex.Replace(template, pattern, username ?? "", RegexOptions.IgnoreCase);
	}

	private string GetAndReplaceAudioIdWithRegex(string template, out string audioId)
	{
		string pattern = "\\*(\\d+)";
		Match match = Regex.Match(template, pattern, RegexOptions.IgnoreCase);
		if (match.Success && match.Groups.Count > 1)
		{
			audioId = match.Groups[1].Value;
			return Regex.Replace(template, pattern, "", RegexOptions.IgnoreCase).Trim();
		}
		audioId = string.Empty;
		return template;
	}
}
