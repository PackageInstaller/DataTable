using System.Collections.Generic;

namespace UnityEngine.Localization.Pseudo;

[CreateAssetMenu(menuName = "Localization/Pseudo-Locale", fileName = "Pseudo-Locale(pseudo)")]
public class PseudoLocale : Locale
{
	[SerializeReference]
	private List<IPseudoLocalizationMethod> m_Methods = new List<IPseudoLocalizationMethod>
	{
		new PreserveTags(),
		new Expander(),
		new Accenter(),
		new Encapsulator()
	};

	public List<IPseudoLocalizationMethod> Methods => m_Methods;

	public static PseudoLocale CreatePseudoLocale()
	{
		PseudoLocale pseudoLocale = ScriptableObject.CreateInstance<PseudoLocale>();
		pseudoLocale.name = "PseudoLocale";
		return pseudoLocale;
	}

	private PseudoLocale()
	{
		Identifier = new LocaleIdentifier("en");
	}

	internal void Reset()
	{
		foreach (IPseudoLocalizationMethod method in Methods)
		{
			if (method is CharacterSubstitutor characterSubstitutor)
			{
				characterSubstitutor.m_ReplacementsPosition = 0;
			}
		}
	}

	public virtual string GetPseudoString(string input)
	{
		Message message = Message.CreateMessage(input);
		foreach (IPseudoLocalizationMethod method in Methods)
		{
			method?.Transform(message);
		}
		string result = message.ToString();
		message.Release();
		return result;
	}

	public override string ToString()
	{
		return "Pseudo (" + base.ToString() + ")";
	}
}
