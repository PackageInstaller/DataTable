using System.Collections.Generic;

namespace ES3Types;

public class ES3Type_ES3RefDictionary : ES3DictionaryType
{
	public static ES3Type Instance = new ES3Type_ES3RefDictionary();

	public ES3Type_ES3RefDictionary()
		: base(typeof(Dictionary<ES3Ref, ES3Ref>), ES3Type_ES3Ref.Instance, ES3Type_ES3Ref.Instance)
	{
		Instance = this;
	}
}
