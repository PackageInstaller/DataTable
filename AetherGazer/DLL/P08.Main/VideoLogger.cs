using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading;
using UnityEngine;

public class VideoLogger
{
	private Queue<string> m_queue;

	private VideoSyncEvents m_syncEvents;

	private StreamWriter m_sw;

	private string m_videoPath;

	private string m_filePath;

	public VideoLogger(Queue<string> _queue, VideoSyncEvents _syncEvents, string _videoPath, string _fileName)
	{
		try
		{
			m_videoPath = _videoPath;
			DirectoryInfo directoryInfo = new DirectoryInfo(_videoPath);
			if (!directoryInfo.Exists)
			{
				directoryInfo.Create();
			}
			string text = _videoPath + _fileName + ".tmp";
			FileInfo fileInfo = new FileInfo(text);
			if (fileInfo.Exists)
			{
				fileInfo.Delete();
			}
			File.Create(text).Dispose();
			m_filePath = text;
			m_sw = new StreamWriter(text, append: true, Encoding.UTF8);
			m_queue = _queue;
			m_syncEvents = _syncEvents;
		}
		catch (Exception ex)
		{
			Debug.LogError("-------异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
		}
	}

	public void ThreadRun()
	{
		try
		{
			string text = string.Empty;
			while (WaitHandle.WaitAny(m_syncEvents.EventArray) != 1)
			{
				lock (((ICollection)m_queue).SyncRoot)
				{
					while (m_queue.Count > 0)
					{
						text += m_queue.Dequeue();
					}
				}
				m_sw.Write(text);
				text = string.Empty;
			}
			text = string.Empty;
			lock (((ICollection)m_queue).SyncRoot)
			{
				while (m_queue.Count > 0)
				{
					text += m_queue.Dequeue();
				}
			}
			m_sw.Write(text);
			m_sw.Close();
		}
		catch (Exception ex)
		{
			Debug.LogError("-------异常类型:" + ex.GetType()?.ToString() + ",信息:" + ex.Message);
		}
	}
}
