using System.IO;
using UnityEngine;

namespace ES3Internal;

internal class ES3ResourcesStream : MemoryStream
{
	public bool Exists => Length > 0;

	public ES3ResourcesStream(string path)
		: base(GetData(path))
	{
	}

	private static byte[] GetData(string path)
	{
		TextAsset textAsset = Resources.Load(path) as TextAsset;
		if (textAsset == null)
		{
			return new byte[0];
		}
		return textAsset.bytes;
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
	}
}
