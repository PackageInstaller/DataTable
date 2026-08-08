using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.CriLipsEx;

public class CriLipsExAtom : MonoBehaviour
{
	public const string CriLipsExDataFolder = "CriLipsExData";

	private static List<string> _nullFileList = new List<string>();

	private Dictionary<string, CriLipsExSheetData> _sheetDataDict = new Dictionary<string, CriLipsExSheetData>();

	private static CriLipsExAtom _instance = null;

	public static CriLipsExAtom Instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = new GameObject("CriLipsExAtom").AddComponent<CriLipsExAtom>();
				_nullFileList.Clear();
			}
			return _instance;
		}
		set
		{
			_instance = value;
		}
	}

	private void Awake()
	{
		_instance = this;
	}

	public static void AddCueSheet(string pSheetName)
	{
		Instance.AddCueSheetInternal(pSheetName);
	}

	private void AddCueSheetInternal(string pSheetName)
	{
		if (!_sheetDataDict.ContainsKey(pSheetName) && TryLoadFile(pSheetName, out var data))
		{
			_sheetDataDict.Add(pSheetName, data);
		}
	}

	public static void RemoveCueSheet(string pSheetName)
	{
		Instance.RemoveCueSheetInternal(pSheetName);
	}

	private void RemoveCueSheetInternal(string pSheetName)
	{
		_sheetDataDict.Remove(pSheetName);
	}

	public static CriLipsExCueData GetCueSheet(string pSheetName, string pCueName)
	{
		return Instance.GetCueSheetInternal(pSheetName, pCueName);
	}

	public CriLipsExCueData GetCueSheetInternal(string pSheetName, string pCueName)
	{
		if (!_sheetDataDict.TryGetValue(pSheetName, out var value))
		{
			if (!TryLoadFile(pSheetName, out value))
			{
				return null;
			}
			_sheetDataDict.Add(pSheetName, value);
		}
		for (int i = 0; i < value.m_criLipsExCueDatas.Length; i++)
		{
			if (value.m_criLipsExCueDatas[i].m_cueName == pCueName)
			{
				return value.m_criLipsExCueDatas[i];
			}
		}
		return null;
	}

	private bool TryLoadFile(string pSheetName, out CriLipsExSheetData data)
	{
		if (_nullFileList.Contains(pSheetName))
		{
			data = null;
			return false;
		}
		try
		{
			TextAsset textAsset = Asset.Load<TextAsset>("CriLipsExData/" + CriWareExtension.localizationFlag + "/" + pSheetName);
			if (textAsset != null)
			{
				data = new CriLipsExSheetData(textAsset.bytes);
				return true;
			}
		}
		catch (Exception)
		{
			Debug.LogError("=====>>>>> 口型二进制数据错误,无法解析");
		}
		_nullFileList.Add(pSheetName);
		data = null;
		return false;
	}

	public static bool TryGetCueLength(string pSheetName, string pCueName, out int pMilliLength)
	{
		return Instance.TryGetCueLengthInternal(pSheetName, pCueName, out pMilliLength);
	}

	public bool TryGetCueLengthInternal(string pSheetName, string pCueName, out int pMilliLength)
	{
		CriLipsExCueData cueSheetInternal = GetCueSheetInternal(pSheetName, pCueName);
		if (cueSheetInternal != null)
		{
			pMilliLength = cueSheetInternal.m_cueLength;
			return true;
		}
		pMilliLength = -1;
		return false;
	}

	public static void ClearNullFileList()
	{
		_nullFileList.Clear();
	}
}
