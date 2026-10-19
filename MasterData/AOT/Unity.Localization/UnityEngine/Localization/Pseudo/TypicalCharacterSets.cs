using System.Collections.Generic;

namespace UnityEngine.Localization.Pseudo;

public static class TypicalCharacterSets
{
	internal static Dictionary<SystemLanguage, char[]> s_TypicalCharacterSets = new Dictionary<SystemLanguage, char[]>
	{
		{
			SystemLanguage.Czech,
			"áčďéěíňóřšťúůýÁČĎÉĚÍŇÓŘŠŤÚŮÝ‚„".ToCharArray()
		},
		{
			SystemLanguage.Danish,
			"åæøÅÆØ".ToCharArray()
		},
		{
			SystemLanguage.Dutch,
			"àáèéêëïóöÀÁÈÉÊËÏÓÖ".ToCharArray()
		},
		{
			SystemLanguage.Finnish,
			"åäöšÅÄÖŠ".ToCharArray()
		},
		{
			SystemLanguage.French,
			"àâæéèêëîïôœùûüçÀÂÆÉÈÊËÎÏÔŒÙÛÜÇ".ToCharArray()
		},
		{
			SystemLanguage.German,
			"ÄÖÜẞäöüß‚„".ToCharArray()
		},
		{
			SystemLanguage.Italian,
			"àéèìòùÀÉÈÌÒÙªº".ToCharArray()
		},
		{
			SystemLanguage.Norwegian,
			"åæøÅÆØ".ToCharArray()
		},
		{
			SystemLanguage.Polish,
			"ąćęłńóśżźĄĆĘŁŃÓŚŻŹ‚„".ToCharArray()
		},
		{
			SystemLanguage.Portuguese,
			"àáâãçéêíóôõúüÀÁÂÃÇÉÊÍÓÔÕÚÜ".ToCharArray()
		},
		{
			SystemLanguage.Russian,
			"абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ№".ToCharArray()
		},
		{
			SystemLanguage.Spanish,
			"áéíóúüñÁÉÍÓÚÜÑ¿¡ªº".ToCharArray()
		},
		{
			SystemLanguage.Swedish,
			"åäöÅÄÖ".ToCharArray()
		}
	};

	public static char[] GetTypicalCharactersForLanguage(SystemLanguage language)
	{
		if (s_TypicalCharacterSets.TryGetValue(language, out var value))
		{
			return value;
		}
		return null;
	}
}
