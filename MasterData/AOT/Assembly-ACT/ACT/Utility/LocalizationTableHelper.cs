namespace ACT.Utility;

public class LocalizationTableHelper
{
	public static string TableEnum2TableString(LocalizeTable tableEnum)
	{
		return tableEnum switch
		{
			LocalizeTable.Common => LocalizationUtility.localizeTableName_Common, 
			LocalizeTable.LongCommon => LocalizationUtility.localizeTableName_longcommon, 
			LocalizeTable.ShortCommon => LocalizationUtility.localizeTableName_shortcommon, 
			LocalizeTable.MainStory => LocalizationUtility.localizeTableName_MainStory, 
			_ => string.Empty, 
		};
	}
}
