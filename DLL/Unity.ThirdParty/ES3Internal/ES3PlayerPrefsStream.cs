using System;
using System.IO;
using UnityEngine;

namespace ES3Internal;

internal class ES3PlayerPrefsStream : MemoryStream
{
	private string path;

	private bool append;

	private bool isWriteStream;

	private bool isDisposed;

	public ES3PlayerPrefsStream(string path)
		: base(GetData(path, isWriteStream: false))
	{
		this.path = path;
		append = false;
	}

	public ES3PlayerPrefsStream(string path, int bufferSize, bool append = false)
		: base(bufferSize)
	{
		this.path = path;
		this.append = append;
		isWriteStream = true;
	}

	private static byte[] GetData(string path, bool isWriteStream)
	{
		if (!PlayerPrefs.HasKey(path))
		{
			throw new FileNotFoundException("File \"" + path + "\" could not be found in PlayerPrefs");
		}
		return Convert.FromBase64String(PlayerPrefs.GetString(path));
	}

	protected override void Dispose(bool disposing)
	{
		if (isDisposed)
		{
			return;
		}
		isDisposed = true;
		if (isWriteStream && Length > 0)
		{
			if (append)
			{
				byte[] array = Convert.FromBase64String(PlayerPrefs.GetString(path));
				byte[] array2 = ToArray();
				byte[] array3 = new byte[array.Length + array2.Length];
				Buffer.BlockCopy(array, 0, array3, 0, array.Length);
				Buffer.BlockCopy(array2, 0, array3, array.Length, array2.Length);
				PlayerPrefs.SetString(path, Convert.ToBase64String(array3));
				PlayerPrefs.Save();
			}
			else
			{
				PlayerPrefs.SetString(path + ".tmp", Convert.ToBase64String(ToArray()));
			}
			PlayerPrefs.SetString("timestamp_" + path, DateTime.UtcNow.Ticks.ToString());
		}
		base.Dispose(disposing);
	}
}
