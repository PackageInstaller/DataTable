using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class Reporter : MonoBehaviour
{
	public enum _LogType
	{
		Assert = 1,
		Error = 0,
		Exception = 4,
		Log = 3,
		Warning = 2
	}

	public class Log
	{
		public int count = 1;

		public _LogType logType;

		public string condition;

		public string stacktrace;

		public DateTime localTime;
	}

	private enum ReportView
	{
		None,
		Logs,
		Info,
		Snapshot
	}

	private List<Log> logs = new List<Log>();

	private List<Log> collapsedLogs = new List<Log>();

	private List<Log> currentLog = new List<Log>();

	private MultiKeyDictionary<string, string, Log> logsDic = new MultiKeyDictionary<string, string, Log>();

	private Dictionary<string, string> cachedString = new Dictionary<string, string>();

	[HideInInspector]
	public bool show;

	private bool collapse;

	private bool showLog = true;

	private bool showWarning = true;

	private bool showError = true;

	private int numOfLogs;

	private int numOfLogsWarning;

	private int numOfLogsError;

	private int numOfCollapsedLogs;

	private int numOfCollapsedLogsWarning;

	private int numOfCollapsedLogsError;

	private ReportView currentView = ReportView.Logs;

	private static bool created;

	private GUIContent logContent;

	private GUIContent warningContent;

	private GUIContent errorContent;

	private GUIStyle barStyle;

	private GUIStyle buttonActiveStyle;

	private GUIStyle nonStyle;

	private GUIStyle backStyle;

	private GUIStyle evenLogStyle;

	private GUIStyle oddLogStyle;

	private GUIStyle logButtonStyle;

	private GUIStyle selectedLogFontStyle;

	private GUIStyle stackLabelStyle;

	private GUIStyle searchStyle;

	private GUIStyle sliderBackStyle;

	private GUIStyle sliderThumbStyle;

	public Vector2 size = new Vector2(32f, 32f);

	private string filterText = "";

	private Rect screenRect = Rect.zero;

	private Rect toolBarRect = Rect.zero;

	private Rect logsRect = Rect.zero;

	private Rect stackRect = Rect.zero;

	private Rect buttomRect = Rect.zero;

	private Vector2 stackRectTopLeft;

	private Rect detailRect = Rect.zero;

	private Vector2 scrollPosition;

	private Vector2 scrollPosition2;

	private Vector2 toolbarScrollPosition;

	private Log selectedLog;

	private float toolbarOldDrag;

	private float oldDrag;

	private float oldDrag2;

	private int startIndex;

	private Rect countRect = Rect.zero;

	private GUIContent tempContent = new GUIContent();

	private Vector2 infoScrollPosition;

	private Vector2 oldInfoDrag;

	private Rect tempRect;

	private Vector2 downPos;

	private Vector2 mousePosition;

	private List<Log> threadedLogs = new List<Log>();

	private void Awake()
	{
		Initialize();
	}

	private void OnEnable()
	{
		if (logs.Count == 0)
		{
			clear();
		}
	}

	public void Initialize()
	{
		if (!created)
		{
			Application.logMessageReceivedThreaded += CaptureLogThread;
			created = true;
			logContent = new GUIContent("", CreatColoTexture(Color.green, 20, 20), "show or hide logs");
			warningContent = new GUIContent("", CreatColoTexture(Color.yellow, 20, 20), "show or hide warnings");
			errorContent = new GUIContent("", CreatColoTexture(Color.red, 20, 20), "show or hide errors");
			initializeStyle();
		}
		else
		{
			Debug.LogWarning("tow manager is exists delete the second");
			UnityEngine.Object.DestroyImmediate(base.gameObject, allowDestroyingAssets: true);
		}
	}

	private Texture2D CreatColoTexture(Color color, int width = 1, int height = 1)
	{
		Color[] array = new Color[width * height];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = color;
		}
		Texture2D texture2D = new Texture2D(width, height);
		texture2D.SetPixels(array);
		texture2D.Apply();
		return texture2D;
	}

	private void initializeStyle()
	{
		Texture2D background = CreatColoTexture(new Color(0.04f, 0.63f, 1f, 0.1f));
		Texture2D background2 = CreatColoTexture(new Color(0.9f, 0.9f, 0.9f, 0.6f));
		Texture2D background3 = CreatColoTexture(new Color(0.8f, 0.8f, 0.8f, 0.6f));
		Texture2D background4 = CreatColoTexture(new Color(0.6f, 0.6f, 0.6f, 0.6f));
		int num = (int)(size.x * 0.2f);
		int num2 = (int)(size.y * 0.2f);
		nonStyle = new GUIStyle();
		nonStyle.clipping = TextClipping.Clip;
		nonStyle.border = new RectOffset(0, 0, 0, 0);
		nonStyle.normal.background = null;
		nonStyle.fontSize = (int)(size.y / 2f);
		nonStyle.alignment = TextAnchor.MiddleCenter;
		barStyle = new GUIStyle();
		barStyle.border = new RectOffset(1, 1, 1, 1);
		barStyle.normal.background = CreatColoTexture(new Color(0.9f, 0.9f, 0.9f, 1f));
		barStyle.active.background = CreatColoTexture(new Color(0.8f, 0.8f, 0.8f, 1f));
		barStyle.alignment = TextAnchor.MiddleCenter;
		barStyle.margin = new RectOffset(1, 1, 1, 1);
		barStyle.clipping = TextClipping.Clip;
		barStyle.fontSize = (int)(size.y / 2f);
		buttonActiveStyle = new GUIStyle();
		buttonActiveStyle.border = new RectOffset(1, 1, 1, 1);
		buttonActiveStyle.normal.background = background3;
		buttonActiveStyle.alignment = TextAnchor.MiddleCenter;
		buttonActiveStyle.margin = new RectOffset(1, 1, 1, 1);
		buttonActiveStyle.fontSize = (int)(size.y / 2f);
		backStyle = new GUIStyle();
		backStyle.normal.background = background3;
		backStyle.clipping = TextClipping.Clip;
		backStyle.fontSize = (int)(size.y / 2f);
		evenLogStyle = new GUIStyle();
		evenLogStyle.normal.background = background3;
		evenLogStyle.fixedHeight = size.y;
		evenLogStyle.clipping = TextClipping.Clip;
		evenLogStyle.alignment = TextAnchor.UpperLeft;
		evenLogStyle.imagePosition = ImagePosition.ImageLeft;
		evenLogStyle.fontSize = (int)(size.y / 2f);
		oddLogStyle = new GUIStyle();
		oddLogStyle.normal.background = background2;
		oddLogStyle.fixedHeight = size.y;
		oddLogStyle.clipping = TextClipping.Clip;
		oddLogStyle.alignment = TextAnchor.UpperLeft;
		oddLogStyle.imagePosition = ImagePosition.ImageLeft;
		oddLogStyle.fontSize = (int)(size.y / 2f);
		logButtonStyle = new GUIStyle();
		logButtonStyle.fixedHeight = size.y;
		logButtonStyle.clipping = TextClipping.Clip;
		logButtonStyle.alignment = TextAnchor.UpperLeft;
		logButtonStyle.fontSize = (int)(size.y / 2f);
		logButtonStyle.padding = new RectOffset(num, num, num2, num2);
		selectedLogFontStyle = new GUIStyle();
		selectedLogFontStyle.normal.background = background;
		selectedLogFontStyle.fixedHeight = size.y;
		selectedLogFontStyle.clipping = TextClipping.Clip;
		selectedLogFontStyle.alignment = TextAnchor.UpperLeft;
		selectedLogFontStyle.normal.textColor = Color.white;
		selectedLogFontStyle.fontSize = (int)(size.y / 2f);
		selectedLogFontStyle.padding = new RectOffset(num, num, num2, num2);
		stackLabelStyle = new GUIStyle();
		stackLabelStyle.wordWrap = true;
		stackLabelStyle.fontSize = (int)(size.y / 2f);
		stackLabelStyle.padding = new RectOffset(num, num, num2, num2);
		searchStyle = new GUIStyle();
		searchStyle.clipping = TextClipping.Clip;
		searchStyle.alignment = TextAnchor.LowerCenter;
		searchStyle.fontSize = (int)(size.y / 2f);
		searchStyle.wordWrap = true;
		sliderBackStyle = new GUIStyle();
		sliderBackStyle.normal.background = background2;
		sliderBackStyle.fixedHeight = size.y;
		sliderBackStyle.border = new RectOffset(1, 1, 1, 1);
		sliderThumbStyle = new GUIStyle();
		sliderThumbStyle.normal.background = background4;
		sliderThumbStyle.fixedWidth = size.x;
	}

	private void clear()
	{
		logs.Clear();
		collapsedLogs.Clear();
		currentLog.Clear();
		logsDic.Clear();
		selectedLog = null;
		numOfLogs = 0;
		numOfLogsWarning = 0;
		numOfLogsError = 0;
		numOfCollapsedLogs = 0;
		numOfCollapsedLogsWarning = 0;
		numOfCollapsedLogsError = 0;
		GC.Collect();
		selectedLog = null;
	}

	private void calculateCurrentLog()
	{
		bool flag = !string.IsNullOrEmpty(filterText);
		string value = "";
		if (flag)
		{
			value = filterText.ToLower();
		}
		currentLog.Clear();
		if (collapse)
		{
			for (int i = 0; i < collapsedLogs.Count; i++)
			{
				Log log = collapsedLogs[i];
				if ((log.logType == _LogType.Log && !showLog) || (log.logType == _LogType.Warning && !showWarning) || (log.logType == _LogType.Error && !showError) || (log.logType == _LogType.Assert && !showError) || (log.logType == _LogType.Exception && !showError))
				{
					continue;
				}
				if (flag)
				{
					if (log.condition.ToLower().Contains(value))
					{
						currentLog.Add(log);
					}
				}
				else
				{
					currentLog.Add(log);
				}
			}
		}
		else
		{
			for (int j = 0; j < logs.Count; j++)
			{
				Log log2 = logs[j];
				if ((log2.logType == _LogType.Log && !showLog) || (log2.logType == _LogType.Warning && !showWarning) || (log2.logType == _LogType.Error && !showError) || (log2.logType == _LogType.Assert && !showError) || (log2.logType == _LogType.Exception && !showError))
				{
					continue;
				}
				if (flag)
				{
					if (log2.condition.ToLower().Contains(value))
					{
						currentLog.Add(log2);
					}
				}
				else
				{
					currentLog.Add(log2);
				}
			}
		}
		if (selectedLog == null)
		{
			return;
		}
		int num = currentLog.IndexOf(selectedLog);
		if (num == -1)
		{
			Log item = logsDic[selectedLog.condition][selectedLog.stacktrace];
			num = currentLog.IndexOf(item);
			if (num != -1)
			{
				scrollPosition.y = (float)num * size.y;
			}
		}
		else
		{
			scrollPosition.y = (float)num * size.y;
		}
	}

	private void DrawInfo()
	{
		GUILayout.BeginArea(screenRect, backStyle);
		Vector2 drag = getDrag();
		if (drag.x != 0f && downPos != Vector2.zero)
		{
			infoScrollPosition.x -= drag.x - oldInfoDrag.x;
		}
		if (drag.y != 0f && downPos != Vector2.zero)
		{
			infoScrollPosition.y += drag.y - oldInfoDrag.y;
		}
		oldInfoDrag = drag;
		GUI.skin.verticalScrollbar.fixedWidth = size.x;
		GUI.skin.horizontalScrollbar.fixedHeight = 0f;
		GUI.skin.verticalScrollbarThumb.fixedWidth = size.x;
		GUI.skin.horizontalScrollbarThumb.fixedHeight = 0f;
		infoScrollPosition = GUILayout.BeginScrollView(infoScrollPosition);
		GUILayout.Space(size.x);
		GUILayout.BeginHorizontal();
		GUILayout.Space(size.x);
		GUILayout.Label("Size = " + size.x.ToString("0.0"), nonStyle, GUILayout.Height(size.y));
		GUILayout.Space(size.x);
		float num = GUILayout.HorizontalSlider(size.x, 16f, 64f, sliderBackStyle, sliderThumbStyle, GUILayout.Width((float)Screen.width * 0.5f));
		if (size.x != num)
		{
			size.x = (size.y = num);
			initializeStyle();
		}
		GUILayout.FlexibleSpace();
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal();
		GUILayout.Space(size.x);
		if (GUILayout.Button("返回", barStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			currentView = ReportView.Logs;
		}
		GUILayout.FlexibleSpace();
		GUILayout.EndHorizontal();
		GUILayout.EndScrollView();
		GUILayout.EndArea();
	}

	private void drawToolBar()
	{
		toolBarRect.x = 0f;
		toolBarRect.y = 0f;
		toolBarRect.width = Screen.width;
		toolBarRect.height = size.y * 2f;
		GUI.skin.verticalScrollbar.fixedWidth = size.x;
		GUI.skin.horizontalScrollbar.fixedHeight = 0f;
		GUI.skin.verticalScrollbarThumb.fixedWidth = size.x;
		GUI.skin.horizontalScrollbarThumb.fixedHeight = 0f;
		Vector2 drag = getDrag();
		if (drag.x != 0f && downPos != Vector2.zero && downPos.y > (float)Screen.height - size.y * 2f)
		{
			toolbarScrollPosition.x -= drag.x - toolbarOldDrag;
		}
		toolbarOldDrag = drag.x;
		GUILayout.BeginArea(toolBarRect);
		toolbarScrollPosition = GUILayout.BeginScrollView(toolbarScrollPosition);
		GUILayout.BeginHorizontal(barStyle);
		if (GUILayout.Button("清理", barStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			clear();
		}
		if (GUILayout.Button("折叠", collapse ? buttonActiveStyle : barStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			collapse = !collapse;
			calculateCurrentLog();
		}
		GUILayout.Box("搜索", barStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f));
		tempRect = GUILayoutUtility.GetLastRect();
		string text = GUI.TextField(tempRect, filterText, searchStyle);
		if (text != filterText)
		{
			filterText = text;
			calculateCurrentLog();
		}
		if (GUILayout.Button("拷贝", barStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			if (selectedLog == null)
			{
				GUIUtility.systemCopyBuffer = "No log selected";
			}
			else
			{
				GUIUtility.systemCopyBuffer = selectedLog.condition + Environment.NewLine + Environment.NewLine + selectedLog.stacktrace;
			}
		}
		if (GUILayout.Button("保存", barStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			SaveLogsToDevice();
		}
		if (GUILayout.Button("信息", barStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			currentView = ReportView.Info;
		}
		GUILayout.FlexibleSpace();
		string text2 = " ";
		text2 = ((!collapse) ? (text2 + numOfLogs) : (text2 + numOfCollapsedLogs));
		string text3 = " ";
		text3 = ((!collapse) ? (text3 + numOfLogsWarning) : (text3 + numOfCollapsedLogsWarning));
		string text4 = " ";
		text4 = ((!collapse) ? (text4 + numOfLogsError) : (text4 + numOfCollapsedLogsError));
		GUILayout.BeginHorizontal(showLog ? buttonActiveStyle : barStyle);
		if (GUILayout.Button(logContent, nonStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			showLog = !showLog;
			calculateCurrentLog();
		}
		if (GUILayout.Button(text2, nonStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			showLog = !showLog;
			calculateCurrentLog();
		}
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal(showWarning ? buttonActiveStyle : barStyle);
		if (GUILayout.Button(warningContent, nonStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			showWarning = !showWarning;
			calculateCurrentLog();
		}
		if (GUILayout.Button(text3, nonStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			showWarning = !showWarning;
			calculateCurrentLog();
		}
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal(showError ? buttonActiveStyle : nonStyle);
		if (GUILayout.Button(errorContent, nonStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			showError = !showError;
			calculateCurrentLog();
		}
		if (GUILayout.Button(text4, nonStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			showError = !showError;
			calculateCurrentLog();
		}
		GUILayout.EndHorizontal();
		if (GUILayout.Button("关闭", barStyle, GUILayout.Width(size.x * 2f), GUILayout.Height(size.y * 2f)))
		{
			show = false;
		}
		GUILayout.EndHorizontal();
		GUILayout.EndScrollView();
		GUILayout.EndArea();
	}

	private void DrawLogs()
	{
		GUILayout.BeginArea(logsRect, backStyle);
		GUI.skin.verticalScrollbar.fixedWidth = size.x;
		GUI.skin.horizontalScrollbar.fixedHeight = 0f;
		GUI.skin.verticalScrollbarThumb.fixedWidth = size.x;
		GUI.skin.horizontalScrollbarThumb.fixedHeight = 0f;
		Vector2 drag = getDrag();
		if (drag.y != 0f && logsRect.Contains(new Vector2(downPos.x, (float)Screen.height - downPos.y)))
		{
			scrollPosition.y += drag.y - oldDrag;
		}
		scrollPosition = GUILayout.BeginScrollView(scrollPosition);
		oldDrag = drag.y;
		int a = (int)((float)Screen.height * 0.75f / size.y);
		int count = currentLog.Count;
		a = Mathf.Min(a, count - startIndex);
		int num = 0;
		int num2 = (int)((float)startIndex * size.y);
		if (num2 > 0)
		{
			GUILayout.BeginHorizontal(GUILayout.Height(num2));
			GUILayout.Label("---");
			GUILayout.EndHorizontal();
		}
		int value = startIndex + a;
		value = Mathf.Clamp(value, 0, count);
		bool flag = a < count;
		int num3 = startIndex;
		while (startIndex + num < value && num3 < currentLog.Count)
		{
			Log log = currentLog[num3];
			if ((log.logType != _LogType.Log || showLog) && (log.logType != _LogType.Warning || showWarning) && (log.logType != _LogType.Error || showError) && (log.logType != _LogType.Assert || showError) && (log.logType != _LogType.Exception || showError))
			{
				if (num >= a)
				{
					break;
				}
				GUIContent gUIContent = null;
				gUIContent = ((log.logType == _LogType.Log) ? logContent : ((log.logType != _LogType.Warning) ? errorContent : warningContent));
				GUIStyle style = (((startIndex + num) % 2 == 0) ? evenLogStyle : oddLogStyle);
				float num4 = 0f;
				if (collapse)
				{
					tempContent.text = log.count.ToString();
					num4 = barStyle.CalcSize(tempContent).x + 3f;
				}
				else
				{
					tempContent.text = log.localTime.ToString();
					num4 = barStyle.CalcSize(tempContent).x + 3f;
				}
				countRect.x = (float)Screen.width - num4;
				countRect.y = size.y * (float)num3;
				if (num2 > 0)
				{
					countRect.y += 8f;
				}
				countRect.width = num4;
				countRect.height = size.y;
				if (flag)
				{
					countRect.x -= size.x * 2f;
				}
				GUILayout.BeginHorizontal(style);
				if (log == selectedLog)
				{
					GUILayout.Box(gUIContent, nonStyle, GUILayout.Width(size.x), GUILayout.Height(size.y));
					GUILayout.Label(log.condition, selectedLogFontStyle);
				}
				else
				{
					if (GUILayout.Button(gUIContent, nonStyle, GUILayout.Width(size.x), GUILayout.Height(size.y)))
					{
						selectedLog = log;
					}
					if (GUILayout.Button(log.condition, logButtonStyle))
					{
						selectedLog = log;
					}
				}
				if (collapse)
				{
					GUI.Label(countRect, log.count.ToString(), barStyle);
				}
				else
				{
					GUI.Label(countRect, log.localTime.ToString(), barStyle);
				}
				GUILayout.EndHorizontal();
				num++;
			}
			num3++;
		}
		int num5 = (int)((float)(count - (startIndex + a)) * size.y);
		if (num5 > 0)
		{
			GUILayout.BeginHorizontal(GUILayout.Height(num5));
			GUILayout.Label(" ");
			GUILayout.EndHorizontal();
		}
		GUILayout.EndScrollView();
		GUILayout.EndArea();
		buttomRect.x = 0f;
		buttomRect.y = (float)Screen.height - size.y;
		buttomRect.width = Screen.width;
		buttomRect.height = size.y;
		drawStack();
	}

	private void drawStack()
	{
		if (selectedLog != null)
		{
			Vector2 drag = getDrag();
			if (drag.y != 0f && stackRect.Contains(new Vector2(downPos.x, (float)Screen.height - downPos.y)))
			{
				scrollPosition2.y += drag.y - oldDrag2;
			}
			oldDrag2 = drag.y;
			GUILayout.BeginArea(stackRect, backStyle);
			scrollPosition2 = GUILayout.BeginScrollView(scrollPosition2);
			GUILayout.BeginHorizontal();
			GUILayout.Label(selectedLog.condition, stackLabelStyle);
			GUILayout.EndHorizontal();
			GUILayout.Space(size.y * 0.25f);
			GUILayout.BeginHorizontal();
			GUILayout.Label(selectedLog.stacktrace, stackLabelStyle);
			GUILayout.EndHorizontal();
			GUILayout.Space(size.y);
			GUILayout.EndScrollView();
			GUILayout.EndArea();
		}
		else
		{
			GUILayout.BeginArea(stackRect, backStyle);
			GUILayout.EndArea();
			GUILayout.BeginArea(buttomRect, backStyle);
			GUILayout.EndArea();
		}
	}

	public void OnGUIDraw()
	{
		if (show)
		{
			screenRect.x = 0f;
			screenRect.y = 0f;
			screenRect.width = Screen.width;
			screenRect.height = Screen.height;
			getDownPos();
			logsRect.x = 0f;
			logsRect.y = size.y * 2f;
			logsRect.width = Screen.width;
			logsRect.height = (float)Screen.height * 0.75f - size.y * 2f;
			stackRectTopLeft.x = 0f;
			stackRect.x = 0f;
			stackRectTopLeft.y = (float)Screen.height * 0.75f;
			stackRect.y = (float)Screen.height * 0.75f;
			stackRect.width = Screen.width;
			stackRect.height = (float)Screen.height * 0.25f - size.y;
			detailRect.x = 0f;
			detailRect.y = (float)Screen.height - size.y * 3f;
			detailRect.width = Screen.width;
			detailRect.height = size.y * 3f;
			if (currentView == ReportView.Info)
			{
				DrawInfo();
			}
			else if (currentView == ReportView.Logs)
			{
				drawToolBar();
				DrawLogs();
			}
		}
	}

	private Vector2 getDownPos()
	{
		if (Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.IPhonePlayer)
		{
			if (Input.touches.Length == 1 && Input.touches[0].phase == TouchPhase.Began)
			{
				downPos = Input.touches[0].position;
				return downPos;
			}
		}
		else if (Input.GetMouseButtonDown(0))
		{
			downPos.x = Input.mousePosition.x;
			downPos.y = Input.mousePosition.y;
			return downPos;
		}
		return Vector2.zero;
	}

	private Vector2 getDrag()
	{
		if (Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.IPhonePlayer)
		{
			if (Input.touches.Length != 1)
			{
				return Vector2.zero;
			}
			return Input.touches[0].position - downPos;
		}
		if (Input.GetMouseButton(0))
		{
			mousePosition = Input.mousePosition;
			return mousePosition - downPos;
		}
		return Vector2.zero;
	}

	private void calculateStartIndex()
	{
		startIndex = (int)(scrollPosition.y / size.y);
		startIndex = Mathf.Clamp(startIndex, 0, currentLog.Count);
	}

	public void doShow()
	{
		show = true;
		currentView = ReportView.Logs;
	}

	private void Update()
	{
		calculateStartIndex();
		if (threadedLogs.Count <= 0)
		{
			return;
		}
		lock (threadedLogs)
		{
			for (int i = 0; i < threadedLogs.Count; i++)
			{
				Log log = threadedLogs[i];
				AddLog(log.condition, log.stacktrace, (LogType)log.logType, log.localTime);
			}
			threadedLogs.Clear();
		}
	}

	private void AddLog(string condition, string stacktrace, LogType type, DateTime localTime)
	{
		string text = "";
		if (cachedString.ContainsKey(condition))
		{
			text = cachedString[condition];
		}
		else
		{
			text = condition;
			cachedString.Add(text, text);
		}
		string text2 = "";
		if (cachedString.ContainsKey(stacktrace))
		{
			text2 = cachedString[stacktrace];
		}
		else
		{
			text2 = stacktrace;
			cachedString.Add(text2, text2);
		}
		bool flag = false;
		Log log = new Log
		{
			logType = (_LogType)type,
			condition = text,
			stacktrace = text2,
			localTime = localTime
		};
		bool flag2 = false;
		if (logsDic.ContainsKey(text, stacktrace))
		{
			flag2 = false;
			logsDic[text][stacktrace].count++;
		}
		else
		{
			flag2 = true;
			collapsedLogs.Add(log);
			logsDic[text][stacktrace] = log;
			switch (type)
			{
			case LogType.Log:
				numOfCollapsedLogs++;
				break;
			case LogType.Warning:
				numOfCollapsedLogsWarning++;
				break;
			default:
				numOfCollapsedLogsError++;
				break;
			}
		}
		switch (type)
		{
		case LogType.Log:
			numOfLogs++;
			break;
		case LogType.Warning:
			numOfLogsWarning++;
			break;
		default:
			numOfLogsError++;
			break;
		}
		logs.Add(log);
		if (!collapse | flag2)
		{
			bool flag3 = false;
			if (log.logType == _LogType.Log && !showLog)
			{
				flag3 = true;
			}
			if (log.logType == _LogType.Warning && !showWarning)
			{
				flag3 = true;
			}
			if (log.logType == _LogType.Error && !showError)
			{
				flag3 = true;
			}
			if (log.logType == _LogType.Assert && !showError)
			{
				flag3 = true;
			}
			if (log.logType == _LogType.Exception && !showError)
			{
				flag3 = true;
			}
			if (!flag3 && (string.IsNullOrEmpty(filterText) || log.condition.ToLower().Contains(filterText.ToLower())))
			{
				currentLog.Add(log);
				flag = true;
			}
		}
		if (flag)
		{
			calculateStartIndex();
			int count = currentLog.Count;
			int num = (int)((float)Screen.height * 0.75f / size.y);
			if (startIndex >= count - num)
			{
				scrollPosition.y += size.y;
			}
		}
	}

	private void CaptureLogThread(string condition, string stacktrace, LogType type)
	{
		Log item = new Log
		{
			condition = condition,
			stacktrace = stacktrace,
			logType = (_LogType)type,
			localTime = DateTime.Now
		};
		lock (threadedLogs)
		{
			threadedLogs.Add(item);
		}
	}

	private void SaveLogsToDevice()
	{
		string text = Application.persistentDataPath + "/logs.txt";
		List<string> list = new List<string>();
		Debug.Log("Saving logs to " + text);
		File.Delete(text);
		for (int i = 0; i < logs.Count; i++)
		{
			list.Add(logs[i].logType.ToString() + "\n" + logs[i].condition + "\n" + logs[i].stacktrace);
		}
		File.WriteAllLines(text, list.ToArray());
	}
}
