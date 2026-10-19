using System;
using System.Collections.Generic;

namespace UnityEngine.Localization.SmartFormat.Core.Settings;

[Serializable]
public class SmartSettings
{
	[SerializeField]
	private ErrorAction m_FormatErrorAction;

	[SerializeField]
	private ErrorAction m_ParseErrorAction;

	[Tooltip("Determines whether placeholders are case-sensitive or not.")]
	[SerializeField]
	private CaseSensitivityType m_CaseSensitivity;

	[Tooltip("This setting is relevant for the 'Parsing.LiteralText', If true (the default), character string literals are treated like in normal string.Format: string.Format(\"\t\") will return a \"TAB\" character If false, character string literals are not converted, just like with this string.Format: string.Format(@\"\t\") will return the 2 characters \"\" and \"t\"")]
	[SerializeField]
	private bool m_ConvertCharacterStringLiterals = true;

	public ErrorAction FormatErrorAction
	{
		get
		{
			return m_FormatErrorAction;
		}
		set
		{
			m_FormatErrorAction = value;
		}
	}

	public ErrorAction ParseErrorAction
	{
		get
		{
			return m_ParseErrorAction;
		}
		set
		{
			m_ParseErrorAction = value;
		}
	}

	public CaseSensitivityType CaseSensitivity
	{
		get
		{
			return m_CaseSensitivity;
		}
		set
		{
			m_CaseSensitivity = value;
		}
	}

	public bool ConvertCharacterStringLiterals
	{
		get
		{
			return m_ConvertCharacterStringLiterals;
		}
		set
		{
			m_ConvertCharacterStringLiterals = value;
		}
	}

	internal SmartSettings()
	{
		CaseSensitivity = CaseSensitivityType.CaseSensitive;
		ConvertCharacterStringLiterals = true;
		FormatErrorAction = ErrorAction.ThrowError;
		ParseErrorAction = ErrorAction.ThrowError;
	}

	internal IEqualityComparer<string> GetCaseSensitivityComparer()
	{
		return CaseSensitivity switch
		{
			CaseSensitivityType.CaseSensitive => (IEqualityComparer<string>)StringComparer.Ordinal, 
			CaseSensitivityType.CaseInsensitive => StringComparer.OrdinalIgnoreCase, 
			_ => throw new InvalidOperationException($"The case sensitivity type [{CaseSensitivity}] is unknown."), 
		};
	}

	internal StringComparison GetCaseSensitivityComparison()
	{
		return CaseSensitivity switch
		{
			CaseSensitivityType.CaseSensitive => StringComparison.Ordinal, 
			CaseSensitivityType.CaseInsensitive => StringComparison.OrdinalIgnoreCase, 
			_ => throw new InvalidOperationException($"The case sensitivity type [{CaseSensitivity}] is unknown."), 
		};
	}
}
