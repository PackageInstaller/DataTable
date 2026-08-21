using UnityEngine;

namespace ES3Types;

public class ES3Type_AudioClipArray : ES3ArrayType
{
	public static ES3Type Instance;

	public ES3Type_AudioClipArray()
		: base(typeof(AudioClip[]), ES3Type_AudioClip.Instance)
	{
		Instance = this;
	}
}
