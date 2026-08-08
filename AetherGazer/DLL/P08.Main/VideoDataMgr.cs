using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using System.Threading;
using UnityEngine;

public class VideoDataMgr : MonoBehaviour
{
	private static VideoDataMgr m_instance;

	private Queue<string> m_queue = new Queue<string>();

	private VideoSyncEvents m_syncEvents = new VideoSyncEvents();

	private Thread m_videoLoggerThread;

	private bool m_isStart;

	private string m_videoPath;

	private string m_videoIndexPath;

	private string m_videoExtension = ".viddat";

	private const char m_separator = '|';

	public static VideoDataMgr Inst => m_instance;

	private void Awake()
	{
		m_instance = this;
		m_videoPath = Application.persistentDataPath + "/video/";
		m_videoIndexPath = m_videoPath + "video.index";
		m_videoExtension = ".viddat";
	}

	public int StartVideoLogger()
	{
		if (m_isStart)
		{
			return -1;
		}
		string fileName = "tempCmds";
		VideoLogger videoLogger = new VideoLogger(m_queue, m_syncEvents, m_videoPath, fileName);
		m_videoLoggerThread = new Thread(videoLogger.ThreadRun);
		m_videoLoggerThread.Start();
		m_isStart = true;
		return 0;
	}

	public int StartVideoLoggerWithID(int id)
	{
		if (m_isStart)
		{
			return -1;
		}
		string fileName = "tempCmds_" + id;
		VideoLogger videoLogger = new VideoLogger(m_queue, m_syncEvents, m_videoPath, fileName);
		m_videoLoggerThread = new Thread(videoLogger.ThreadRun);
		m_videoLoggerThread.Start();
		m_isStart = true;
		return 0;
	}

	public int Cmds2File(string cmd)
	{
		if (!m_isStart)
		{
			return -1;
		}
		lock (((ICollection)m_queue).SyncRoot)
		{
			m_queue.Enqueue(cmd);
		}
		m_syncEvents.NewCmdsEvent.Set();
		return 0;
	}

	public int StopVideoLogger(string _newName, string _otherData)
	{
		if (!m_isStart)
		{
			return -1;
		}
		try
		{
			m_syncEvents.ExitThreadEvent.Set();
			m_videoLoggerThread.Join();
			m_syncEvents.ExitThreadEvent.Reset();
			m_isStart = false;
			if (string.IsNullOrEmpty(_newName))
			{
				_newName = "录制于_" + DateTime.Now.ToString("yyyy年MM月dd日HH时mm分ss秒", CultureInfo.InvariantCulture);
			}
			Debug.Log("----------输入的名字为:" + _newName);
			FileInfo fileInfo = new FileInfo(m_videoPath + "tempCmds.tmp");
			if (File.Exists(m_videoPath + _newName + m_videoExtension))
			{
				_newName = _newName + "_" + DateTime.Now.ToString("yyyy年MM月dd日HH时mm分ss秒", CultureInfo.InvariantCulture);
			}
			fileInfo.MoveTo(m_videoPath + _newName + m_videoExtension);
			videoIndexData2File(_newName + "|" + _otherData);
			return 0;
		}
		catch (Exception ex)
		{
			Debug.LogError("-------StopVideoLogger抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return -1;
		}
	}

	public int GiveUpVideo()
	{
		if (!m_isStart)
		{
			return -1;
		}
		try
		{
			m_syncEvents.ExitThreadEvent.Set();
			m_videoLoggerThread.Join();
			m_syncEvents.ExitThreadEvent.Reset();
			m_isStart = false;
			FileInfo fileInfo = new FileInfo(m_videoPath + "tempCmds.tmp");
			if (fileInfo.Exists)
			{
				fileInfo.Delete();
			}
			return 0;
		}
		catch (Exception ex)
		{
			Debug.LogError("-------GiveUpVideo 抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return -1;
		}
	}

	private int videoIndexData2File(string _videoData)
	{
		try
		{
			if (!new FileInfo(m_videoIndexPath).Exists)
			{
				File.Create(m_videoIndexPath).Dispose();
			}
			StreamWriter streamWriter = new StreamWriter(m_videoIndexPath, append: true, Encoding.UTF8);
			streamWriter.WriteLine(_videoData);
			streamWriter.Close();
			return 0;
		}
		catch (Exception ex)
		{
			Debug.LogError("-------VideoIndexData2File 抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return -1;
		}
	}

	public int VideoIndexData34File(string _videoName)
	{
		if (string.IsNullOrEmpty(_videoName))
		{
			return -1;
		}
		try
		{
			FileInfo fileInfo = new FileInfo(m_videoPath + _videoName + m_videoExtension);
			if (fileInfo.Exists)
			{
				fileInfo.Delete();
			}
			if (!new FileInfo(m_videoIndexPath).Exists)
			{
				return -1;
			}
			string text = "";
			StreamReader streamReader = new StreamReader(m_videoIndexPath, Encoding.UTF8);
			long position = streamReader.BaseStream.Position;
			while (streamReader.Peek() >= 0)
			{
				string text2 = streamReader.ReadLine();
				if (text2.Substring(0, text2.IndexOf('|')).Equals(_videoName))
				{
					text = text2;
					streamReader.ReadToEnd();
					break;
				}
			}
			string value = "";
			if (!string.IsNullOrEmpty(text))
			{
				streamReader.BaseStream.Position = position;
				value = streamReader.ReadToEnd();
				int startIndex = value.IndexOf(text);
				int count = text.Length + 2;
				value = value.Remove(startIndex, count);
			}
			streamReader.Close();
			if (!string.IsNullOrEmpty(value))
			{
				StreamWriter streamWriter = new StreamWriter(m_videoIndexPath);
				streamWriter.Write(value);
				streamWriter.Close();
			}
			return 0;
		}
		catch (Exception ex)
		{
			Debug.LogError("-------VideoIndexData34File 抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return -1;
		}
	}

	public int VideoIndexDataChangeName(string _oldName, string _newName)
	{
		if (!m_isStart)
		{
			return -1;
		}
		try
		{
			string value = "";
			StreamReader streamReader = new StreamReader(m_videoIndexPath, Encoding.UTF8);
			long position = streamReader.BaseStream.Position;
			while (streamReader.Peek() >= 0)
			{
				string text = streamReader.ReadLine();
				if (text.Substring(0, text.IndexOf('|')).Equals(_oldName))
				{
					value = text;
					streamReader.ReadToEnd();
					break;
				}
			}
			string value2 = "";
			if (!string.IsNullOrEmpty(value))
			{
				streamReader.BaseStream.Position = position;
				value2 = streamReader.ReadToEnd();
				int startIndex = value2.IndexOf(value);
				int length = _oldName.Length;
				value2 = value2.Remove(startIndex, length);
				value2 = value2.Insert(startIndex, _newName);
			}
			streamReader.Close();
			if (!string.IsNullOrEmpty(value2))
			{
				StreamWriter streamWriter = new StreamWriter(m_videoIndexPath);
				streamWriter.Write(value2);
				streamWriter.Close();
			}
			new FileInfo(m_videoPath + _oldName + ".viddat").MoveTo(m_videoPath + _newName + ".viddat");
			return 0;
		}
		catch (Exception ex)
		{
			Debug.LogError("-------VideoIndexDataChangeName 抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return -1;
		}
	}

	public string GetVideoIndexDataByName(string _videoName)
	{
		try
		{
			if (!new FileInfo(m_videoIndexPath).Exists)
			{
				Debug.LogError("--------索引文件不存在:" + m_videoIndexPath);
				return "";
			}
			string text = "";
			StreamReader streamReader = new StreamReader(m_videoIndexPath, Encoding.UTF8);
			long position = streamReader.BaseStream.Position;
			while (streamReader.Peek() >= 0)
			{
				string text2 = streamReader.ReadLine();
				if (text2.Substring(0, text2.IndexOf('|')).Equals(_videoName))
				{
					text = text2;
					break;
				}
			}
			if (string.IsNullOrEmpty(text))
			{
				Debug.LogError("--------文件名对应的索引数据不存在:" + text);
				streamReader.Close();
				return "";
			}
			string text3 = text.Substring(0, text.IndexOf('|'));
			if (!new FileInfo(m_videoPath + text3 + m_videoExtension).Exists)
			{
				string text4 = "";
				streamReader.BaseStream.Position = position;
				text4 = streamReader.ReadToEnd();
				int startIndex = text4.IndexOf(text);
				int count = text.Length + 2;
				text4 = text4.Remove(startIndex, count);
				streamReader.Close();
				StreamWriter streamWriter = new StreamWriter(m_videoIndexPath);
				streamWriter.Write(text4);
				streamWriter.Close();
				return "";
			}
			streamReader.Close();
			return text;
		}
		catch (Exception ex)
		{
			Debug.LogError("-------GetVideoIndexDataByName 抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return "";
		}
	}

	public string GetVideoIndexData()
	{
		try
		{
			if (!new DirectoryInfo(m_videoPath).Exists)
			{
				return "";
			}
			if (!new FileInfo(m_videoIndexPath).Exists)
			{
				return "";
			}
			StreamReader streamReader = new StreamReader(m_videoIndexPath, Encoding.UTF8);
			string result = streamReader.ReadToEnd();
			streamReader.Close();
			return result;
		}
		catch (Exception ex)
		{
			Debug.LogError("-------GetVideoFiles 抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return "";
		}
	}

	public string GetVideoFiles()
	{
		try
		{
			if (!new DirectoryInfo(m_videoPath).Exists)
			{
				return "";
			}
			if (!new FileInfo(m_videoIndexPath).Exists)
			{
				return "";
			}
			string text = "";
			StreamReader streamReader = new StreamReader(m_videoIndexPath, Encoding.UTF8);
			while (streamReader.Peek() >= 0)
			{
				string text2 = streamReader.ReadLine();
				text = text + text2.Substring(0, text2.IndexOf('|')) + "|";
			}
			streamReader.Close();
			return text;
		}
		catch (IOException ex)
		{
			Debug.LogError("-------GetVideoFiles 抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return "";
		}
	}

	public int IsExistForVideo(string _videoName)
	{
		try
		{
			if (new FileInfo(m_videoPath + _videoName + m_videoExtension).Exists)
			{
				return 1;
			}
			VideoIndexData34File(_videoName);
			return -1;
		}
		catch (Exception ex)
		{
			Debug.LogError("-------GetVideoFiles 抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return -1;
		}
	}

	public string GetVideoDataByFileName(string fileName)
	{
		try
		{
			FileInfo fileInfo = new FileInfo(m_videoPath + fileName + ".viddat");
			if (!fileInfo.Exists)
			{
				Debug.LogError("--------要播放的录像文件为空,路径为：" + fileInfo.FullName);
				return "";
			}
			StreamReader streamReader = new StreamReader(fileInfo.FullName);
			string result = streamReader.ReadToEnd();
			streamReader.Close();
			return result;
		}
		catch (IOException ex)
		{
			Debug.LogError("-------GetVideoDataByFileName 抛出异常,异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
			return "";
		}
	}

	public int FileExit(string _name)
	{
		if (File.Exists(m_videoPath + _name + m_videoExtension))
		{
			return 1;
		}
		return -1;
	}
}
