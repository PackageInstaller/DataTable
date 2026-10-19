using System;
using System.Reflection;
using ACT.DebugGUI;
using ACT.Net;
using Bamboo.AssetField;
using UnityEngine;

namespace ACT.Initialize.Flow;

public class InitDebugTool : RuntimeLoadFlow
{
	private class LuminLogHandler : ILogHandler
	{
		private readonly ILogHandler _defaultLogHandler;

		public LuminLogHandler()
		{
			_defaultLogHandler = ExtractDefaultLogHandler(Debug.unityLogger.logHandler);
		}

		private static ILogHandler ExtractDefaultLogHandler(ILogHandler handler)
		{
			if (handler == null)
			{
				return null;
			}
			try
			{
				Type type = handler.GetType();
				Type typeFromHandle = typeof(LuminApplication.APM);
				if (type.DeclaringType != typeFromHandle || type.Name != "LuminLogHandler")
				{
					return null;
				}
				FieldInfo field = type.GetField("_defaultLogHandler", BindingFlags.Instance | BindingFlags.NonPublic);
				if (field == null)
				{
					Debug.LogWarning("[InitDebugTool] 未找到 LuminApplication.APM.LuminLogHandler._defaultLogHandler 字段");
					return null;
				}
				return field.GetValue(handler) as ILogHandler;
			}
			catch (Exception ex)
			{
				Debug.LogWarning("[InitDebugTool] 反射获取 _defaultLogHandler 失败: " + ex.Message);
				return null;
			}
		}

		public void LogFormat(LogType logType, UnityEngine.Object context, string format, params object[] args)
		{
			if (logType == LogType.Exception || logType == LogType.Error)
			{
				_defaultLogHandler?.LogFormat(logType, context, format, args);
			}
		}

		public void LogException(Exception exception, UnityEngine.Object context)
		{
			_defaultLogHandler?.LogException(exception, context);
		}
	}

	public InitDebugTool()
		: base("InitDebugTool")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(3L);
		WaitInitializer.CompleteOne();
		ResetLogHandler();
		DebugWindowManager.instance?.SetVisible(isVisible: false);
		WaitInitializer.CompleteOne();
		AssetStationManager.Root.LoadAsync<NetDebugConfig>("netdebug", (AssetLoadHandle result) =>
		{
			NetDebugConfig.config = result.As<NetDebugConfig>();
			WaitInitializer.CompleteOne();
		});
	}

	private static void ResetLogHandler()
	{
		Debug.unityLogger.logHandler = new LuminLogHandler();
	}
}
