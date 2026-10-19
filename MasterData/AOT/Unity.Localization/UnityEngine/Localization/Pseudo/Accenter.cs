using System;

namespace UnityEngine.Localization.Pseudo;

[Serializable]
public class Accenter : CharacterSubstitutor
{
	public Accenter()
	{
		Method = SubstitutionMethod.Map;
		AddDefaults();
	}

	public void AddDefaults()
	{
		ReplacementMap[' '] = '\u2003';
		ReplacementMap['!'] = '¡';
		ReplacementMap['"'] = '″';
		ReplacementMap['#'] = '♯';
		ReplacementMap['$'] = '€';
		ReplacementMap['%'] = '‰';
		ReplacementMap['&'] = '⅋';
		ReplacementMap['\''] = '\u00b4';
		ReplacementMap['*'] = '⁎';
		ReplacementMap['+'] = '⁺';
		ReplacementMap[']'] = '،';
		ReplacementMap['-'] = '‐';
		ReplacementMap['.'] = '·';
		ReplacementMap['/'] = '⁄';
		ReplacementMap['0'] = '⓪';
		ReplacementMap['1'] = '①';
		ReplacementMap['2'] = '②';
		ReplacementMap['3'] = '③';
		ReplacementMap['4'] = '④';
		ReplacementMap['5'] = '⑤';
		ReplacementMap['6'] = '⑥';
		ReplacementMap['7'] = '⑦';
		ReplacementMap['8'] = '⑧';
		ReplacementMap['9'] = '⑨';
		ReplacementMap[':'] = '∶';
		ReplacementMap[';'] = '⁏';
		ReplacementMap['<'] = '≤';
		ReplacementMap['='] = '≂';
		ReplacementMap['>'] = '≥';
		ReplacementMap['?'] = '¿';
		ReplacementMap['@'] = '՞';
		ReplacementMap['A'] = 'Å';
		ReplacementMap['B'] = 'Ɓ';
		ReplacementMap['C'] = 'Ç';
		ReplacementMap['D'] = 'Ð';
		ReplacementMap['E'] = 'É';
		ReplacementMap['F'] = 'Ƒ';
		ReplacementMap['G'] = 'Ĝ';
		ReplacementMap['H'] = 'Ĥ';
		ReplacementMap['I'] = 'Î';
		ReplacementMap['J'] = 'Ĵ';
		ReplacementMap['K'] = 'Ķ';
		ReplacementMap['L'] = 'Ļ';
		ReplacementMap['M'] = 'Ṁ';
		ReplacementMap['N'] = 'Ñ';
		ReplacementMap['O'] = 'Ö';
		ReplacementMap['P'] = 'Þ';
		ReplacementMap['Q'] = 'Ǫ';
		ReplacementMap['R'] = 'Ŕ';
		ReplacementMap['S'] = 'Š';
		ReplacementMap['T'] = 'Ţ';
		ReplacementMap['U'] = 'Û';
		ReplacementMap['V'] = 'Ṽ';
		ReplacementMap['W'] = 'Ŵ';
		ReplacementMap['X'] = 'Ẋ';
		ReplacementMap['Y'] = 'Ý';
		ReplacementMap['Z'] = 'Ž';
		ReplacementMap['['] = '⁅';
		ReplacementMap['\\'] = '∖';
		ReplacementMap[']'] = '⁆';
		ReplacementMap['^'] = '\u02c4';
		ReplacementMap['_'] = '\u203f';
		ReplacementMap['`'] = '‵';
		ReplacementMap['a'] = 'å';
		ReplacementMap['b'] = 'ƀ';
		ReplacementMap['c'] = 'ç';
		ReplacementMap['d'] = 'ð';
		ReplacementMap['e'] = 'é';
		ReplacementMap['f'] = 'ƒ';
		ReplacementMap['g'] = 'ĝ';
		ReplacementMap['h'] = 'ĥ';
		ReplacementMap['i'] = 'î';
		ReplacementMap['j'] = 'ĵ';
		ReplacementMap['k'] = 'ķ';
		ReplacementMap['l'] = 'ļ';
		ReplacementMap['m'] = 'ɱ';
		ReplacementMap['n'] = 'ñ';
		ReplacementMap['o'] = 'ö';
		ReplacementMap['p'] = 'þ';
		ReplacementMap['q'] = 'ǫ';
		ReplacementMap['r'] = 'ŕ';
		ReplacementMap['s'] = 'š';
		ReplacementMap['t'] = 'ţ';
		ReplacementMap['u'] = 'û';
		ReplacementMap['v'] = 'ṽ';
		ReplacementMap['w'] = 'ŵ';
		ReplacementMap['x'] = 'ẋ';
		ReplacementMap['y'] = 'ý';
		ReplacementMap['z'] = 'ž';
		ReplacementMap['|'] = '¦';
		ReplacementMap['~'] = '\u02de';
	}
}
