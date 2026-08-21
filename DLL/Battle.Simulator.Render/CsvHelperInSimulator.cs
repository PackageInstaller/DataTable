using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;

public class CsvHelperInSimulator
{
	private StreamReader sr;

	private bool hasNext = true;

	public static int INITIAL_READ_SIZE = 64;

	private CsvHelperInSimulator(byte[] bytes)
	{
		sr = new StreamReader(new MemoryStream(bytes), Encoding.UTF8);
	}

	public void Dispose()
	{
		if (sr != null)
		{
			sr.Dispose();
			sr = null;
		}
	}

	public string[] ReadNext()
	{
		string nextLine = GetNextLine();
		if (!hasNext)
		{
			return null;
		}
		return ParseLine(nextLine);
	}

	private string GetNextLine()
	{
		try
		{
			string text = sr.ReadLine();
			if (text == null)
			{
				hasNext = false;
			}
			return hasNext ? text : null;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			hasNext = false;
			return null;
		}
	}

	private string[] ParseLine(string nextLine)
	{
		if (nextLine == null)
		{
			return null;
		}
		List<string> list = new List<string>();
		StringBuilder stringBuilder = new StringBuilder(INITIAL_READ_SIZE);
		bool flag = false;
		do
		{
			if (flag)
			{
				stringBuilder.Append("\n");
				nextLine = GetNextLine();
				if (nextLine == null)
				{
					break;
				}
			}
			char[] array = nextLine.ToCharArray();
			for (int i = 0; i < array.Length; i++)
			{
				char c = array[i];
				switch (c)
				{
				case '\\':
					if (flag && array.Length > i + 1 && (array[i + 1] == '"' || array[i + 1] == '\\'))
					{
						stringBuilder.Append('\\');
						stringBuilder.Append(array[i + 1]);
						i++;
					}
					else
					{
						stringBuilder.Append('\\');
					}
					continue;
				case '"':
					if (flag && array.Length > i + 1 && array[i + 1] == '"')
					{
						stringBuilder.Append('\\');
						stringBuilder.Append(array[i + 1]);
						i++;
					}
					else
					{
						flag = !flag;
						stringBuilder.Append('"');
					}
					continue;
				case ',':
					if (!flag)
					{
						list.Add(stringBuilder.ToString());
						stringBuilder = new StringBuilder(INITIAL_READ_SIZE);
						continue;
					}
					break;
				}
				stringBuilder.Append(c);
			}
		}
		while (flag);
		list.Add(stringBuilder.ToString());
		return list.ToArray();
	}

	private static string ImplodeString(string[] lines)
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (string text in lines)
		{
			if (text == null)
			{
				stringBuilder.Append("");
			}
			else
			{
				stringBuilder.Append(text);
			}
			stringBuilder.Append(",");
		}
		return stringBuilder.ToString();
	}

	public static List<List<string>> TryParse(byte[] content, bool isTrim = true)
	{
		CsvHelperInSimulator csvHelperInSimulator = null;
		List<List<string>> list = new List<List<string>>();
		try
		{
			csvHelperInSimulator = new CsvHelperInSimulator(content);
			string[] array;
			while ((array = csvHelperInSimulator.ReadNext()) != null)
			{
				if (array.Length == 0)
				{
					continue;
				}
				bool flag = false;
				List<string> list2 = new List<string>();
				for (int i = 0; i < array.Length; i++)
				{
					if (isTrim)
					{
						array[i] = array[i].Trim();
					}
					string text = array[i];
					if (i == 0 && text.Length != 0 && text[0] == '#')
					{
						flag = true;
						break;
					}
					list2.Add(text);
				}
				if (!flag)
				{
					list.Add(list2);
				}
			}
		}
		catch (Exception exception)
		{
			list = null;
			Debug.LogException(exception);
		}
		finally
		{
			csvHelperInSimulator?.Dispose();
		}
		return list;
	}

	public static List<List<string>> GetOriCsvData(string path)
	{
		byte[] bytes = File.ReadAllBytes(path);
		CsvHelperInSimulator csvHelperInSimulator = null;
		List<List<string>> list = new List<List<string>>();
		try
		{
			csvHelperInSimulator = new CsvHelperInSimulator(bytes);
			string[] array;
			while ((array = csvHelperInSimulator.ReadNext()) != null)
			{
				List<string> list2 = new List<string>();
				foreach (string item in array)
				{
					list2.Add(item);
				}
				list.Add(list2);
			}
		}
		catch (Exception exception)
		{
			list = null;
			Debug.LogException(exception);
		}
		finally
		{
			csvHelperInSimulator?.Dispose();
		}
		return list;
	}

	public static bool SaveCsvData(List<List<string>> data, string path)
	{
		try
		{
			StringBuilder stringBuilder = new StringBuilder();
			for (int i = 0; i < data.Count; i++)
			{
				stringBuilder.AppendLine(string.Join(",", data[i]));
			}
			File.WriteAllText(path, stringBuilder.ToString());
			return true;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return false;
		}
	}
}
