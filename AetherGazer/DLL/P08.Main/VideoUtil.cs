using System;
using System.IO;
using UnityEngine;

public class VideoUtil
{
	private const string winPath = "D:\\";

	private const string videoFolderName = "gameVideo";

	private static FileStream m_videoFile;

	private static StreamWriter m_sw;

	private static bool m_isOpenStream;

	private static void openStream()
	{
		try
		{
			Directory.CreateDirectory("D:\\gameVideo");
			if (File.Exists("D:\\gameVideo\\tempCmds.viddat"))
			{
				File.Delete("D:\\gameVideo\\tempCmds.viddat");
			}
			m_videoFile = new FileStream("D:\\gameVideo\\tempCmds.viddat", FileMode.Append, FileAccess.Write);
			m_sw = new StreamWriter(m_videoFile);
			m_isOpenStream = true;
		}
		catch (IOException ex)
		{
			throw ex;
		}
	}

	public static void WriteVideoDataPiece(string str)
	{
		try
		{
			if (!m_isOpenStream)
			{
				openStream();
			}
			if (!string.IsNullOrEmpty(str))
			{
				m_sw.Write(str);
			}
		}
		catch (IOException ex)
		{
			Debug.LogError("-------异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
		}
	}

	public static void SaveVideoFile()
	{
		try
		{
			m_sw.Flush();
			m_sw.Close();
			File.Move("D:\\gameVideo\\tempCmds.viddat", "D:\\gameVideo\\" + Convert.ToInt64((DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0)).TotalSeconds) + ".viddat");
			m_sw.Dispose();
			m_videoFile.Dispose();
			m_sw = null;
			m_videoFile = null;
			m_isOpenStream = false;
		}
		catch (IOException ex)
		{
			Debug.LogError("-------异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
		}
	}

	public static string GetVideoFiles()
	{
		try
		{
			if (!Directory.Exists("D:\\gameVideo"))
			{
				return "";
			}
			string[] fileSystemEntries = Directory.GetFileSystemEntries("D:\\gameVideo", "*.viddat");
			string text = "";
			for (int i = 0; i < fileSystemEntries.Length; i++)
			{
				text = text + Path.GetFileNameWithoutExtension(fileSystemEntries[i]) + "|";
			}
			return text;
		}
		catch (IOException ex)
		{
			Debug.LogError("-------异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return "";
		}
	}

	public static string GetVideoDataByFileName(string fileName)
	{
		string path = "D:\\gameVideo\\" + fileName + ".viddat";
		if (File.Exists(path))
		{
			StreamReader streamReader = new StreamReader(new FileStream(path, FileMode.Open, FileAccess.Read));
			string text = streamReader.ReadToEnd();
			Debug.Log("-----------读取到的文件:" + text);
			streamReader.Close();
			return text;
		}
		Debug.LogError("--------要播放的录像文件为空");
		return "";
	}
}
