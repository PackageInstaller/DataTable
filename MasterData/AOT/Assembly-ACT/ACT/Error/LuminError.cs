using System;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.LocalLoader;
using ACT.Net;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.Error;

public static class LuminError
{
	private enum MsgCodePopupType
	{
		None,
		Dialog,
		Toast
	}

	private readonly struct ErrorDisplayInfo(string code, string message, MsgCodePopupType popupType, int rank, bool trackingUpload, bool isConfigured)
	{
		public readonly string Code = code;

		public readonly string Message = message;

		public readonly MsgCodePopupType PopupType = popupType;

		public readonly int Rank = rank;

		public readonly bool TrackingUpload = trackingUpload;

		public readonly bool IsConfigured = isConfigured;
	}

	private const string DefaultErrorTitle = "系统提示";

	private const string DefaultErrorMessage = "出现错误";

	public static ErrorHandleResult Handle(ErrorAck errorAck)
	{
		return Handle(errorAck, default(ErrorHandleOptions));
	}

	public static ErrorHandleResult Handle(ErrorAck errorAck, in ErrorHandleOptions options)
	{
		if (errorAck == null)
		{
			return CreateInvalidResult();
		}
		return HandleError((CodeType)errorAck.CodeType, (CodeModule)errorAck.CodeModule, errorAck.SubCode, errorAck.Param, null, null, in options);
	}

	public static ErrorHandleResult Handle(LuminErrorException exception)
	{
		return Handle(exception, default(ErrorHandleOptions));
	}

	public static ErrorHandleResult Handle(LuminErrorException exception, in ErrorHandleOptions options)
	{
		if (exception == null)
		{
			return CreateInvalidResult();
		}
		return HandleError(exception.CodeType, exception.CodeModule, exception.SubCode, exception.Param, exception.TitleOverride, exception.MessageOverride, in options, exception.HideErrorCode);
	}

	public static ErrorHandleResult Handle(CodeType codeType, CodeModule codeModule, int subCode)
	{
		return Handle(codeType, codeModule, subCode, default(ErrorHandleOptions));
	}

	public static ErrorHandleResult Handle(CodeType codeType, CodeModule codeModule, int subCode, in ErrorHandleOptions options)
	{
		return HandleError(codeType, codeModule, subCode, null, null, null, in options);
	}

	public static ErrorHandleResult Handle(int codeType, int codeModule, int subCode)
	{
		return Handle((CodeType)codeType, (CodeModule)codeModule, subCode, default(ErrorHandleOptions));
	}

	public static ErrorHandleResult Handle(int codeType, int codeModule, int subCode, in ErrorHandleOptions options)
	{
		return Handle((CodeType)codeType, (CodeModule)codeModule, subCode, in options);
	}

	public static string FormatErrorCode(CodeType codeType, CodeModule codeModule, int subCode)
	{
		return $"{codeType switch
		{
			CodeType.SERVER => 'S', 
			CodeType.DATABASE => 'D', 
			CodeType.CLIENT => 'C', 
			_ => 'U', 
		}}{(int)codeModule:D2}-{subCode:D4}";
	}

	private static ErrorHandleResult HandleError(CodeType codeType, CodeModule codeModule, int subCode, ErrorParam param, string sourceTitleOverride, string sourceMessageOverride, in ErrorHandleOptions options, bool sourceHideErrorCode = false)
	{
		ErrorDisplayInfo errorDisplayInfo = ResolveErrorDisplayInfo(codeType, codeModule, subCode, options.Arguments);
		string title = ResolveOverride(options.TitleOverride, sourceTitleOverride, "系统提示");
		string message = ResolveOverride(options.MessageOverride, sourceMessageOverride, errorDisplayInfo.Message);
		ResolvedError error = new ResolvedError(isValid: true, codeType, codeModule, subCode, errorDisplayInfo.Code, title, message, errorDisplayInfo.Rank, errorDisplayInfo.TrackingUpload, errorDisplayInfo.IsConfigured, param);
		bool wasReported = errorDisplayInfo.TrackingUpload && ReportErrorCode(codeModule, errorDisplayInfo.Code, errorDisplayInfo.Rank);
		if (TryCustomHandle(options.TryCustomHandle, error))
		{
			return new ErrorHandleResult(error, wasReported, wasCustomHandled: true, ErrorPresentation.None);
		}
		ErrorPresentation errorPresentation = ResolvePresentation(options.Presentation, errorDisplayInfo.PopupType, errorDisplayInfo.IsConfigured);
		if (options.Presentation != ErrorPresentation.None && (options.OnConfirm != null || options.OnCancel != null) && errorPresentation != ErrorPresentation.Dialog)
		{
			errorPresentation = ErrorPresentation.Dialog;
		}
		Present(error, errorPresentation, options.OnConfirm, options.OnCancel, options.HideErrorCode | sourceHideErrorCode);
		return new ErrorHandleResult(error, wasReported, wasCustomHandled: false, errorPresentation);
	}

	private static string ResolveOverride(string optionOverride, string sourceOverride, string fallback)
	{
		if (!string.IsNullOrWhiteSpace(optionOverride))
		{
			return optionOverride;
		}
		if (!string.IsNullOrWhiteSpace(sourceOverride))
		{
			return sourceOverride;
		}
		return fallback;
	}

	private static bool TryCustomHandle(Func<ResolvedError, bool> tryCustomHandle, ResolvedError error)
	{
		if (tryCustomHandle == null)
		{
			return false;
		}
		try
		{
			return tryCustomHandle(error);
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Failed to custom handle error code {error.Code}: {arg}");
			}
			return false;
		}
	}

	private static ErrorHandleResult CreateInvalidResult()
	{
		return new ErrorHandleResult(new ResolvedError(isValid: false, (CodeType)0, (CodeModule)0, 0, string.Empty, "系统提示", "出现错误", 0, trackingUpload: false, isConfigured: false, null), wasReported: false, wasCustomHandled: false, ErrorPresentation.None);
	}

	private static ErrorDisplayInfo ResolveErrorDisplayInfo(CodeType codeType, CodeModule codeModule, int subCode, object[] arguments)
	{
		string text = FormatErrorCode(codeType, codeModule, subCode);
		Msgcode msgcode = RuntimeConfigs.data?.GetMsgcodeByCodeTypeCodeModuleSubCode((int)codeType, (int)codeModule, subCode);
		if (msgcode == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Missing msgcode config: " + text);
			}
			return new ErrorDisplayInfo(text, "出现错误", MsgCodePopupType.Dialog, 0, trackingUpload: false, isConfigured: false);
		}
		if (!string.IsNullOrWhiteSpace(msgcode.code) && !string.Equals(msgcode.code, text, StringComparison.Ordinal) && LuminApplication.LogEnabled)
		{
			Debug.LogError("Msgcode identity mismatch: expected " + text + ", configured " + msgcode.code);
		}
		string message = ((msgcode.text > 0) ? GetLocalizedErrorMessage(msgcode.text, arguments) : "出现错误");
		MsgCodePopupType popupType = (Enum.IsDefined(typeof(MsgCodePopupType), msgcode.popupType) ? ((MsgCodePopupType)msgcode.popupType) : MsgCodePopupType.None);
		return new ErrorDisplayInfo(text, message, popupType, msgcode.rank, msgcode.trackingUpload, isConfigured: true);
	}

	private static string GetLocalizedErrorMessage(int localizeId, object[] arguments)
	{
		try
		{
			if (arguments == null || arguments.Length == 0)
			{
				return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, localizeId);
			}
			return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, localizeId, arguments);
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Failed to resolve error localization id {localizeId}: {arg}");
			}
			return "出现错误";
		}
	}

	private static ErrorPresentation ResolvePresentation(ErrorPresentation requested, MsgCodePopupType popupType, bool isConfigured)
	{
		switch (requested)
		{
		case ErrorPresentation.Dialog:
			return ErrorPresentation.Dialog;
		case ErrorPresentation.Toast:
			return ErrorPresentation.Toast;
		case ErrorPresentation.None:
			return ErrorPresentation.None;
		default:
			return ResolvePresentation(ErrorPresentation.Configured, popupType, isConfigured);
		case ErrorPresentation.Configured:
			if (!isConfigured)
			{
				return ErrorPresentation.Dialog;
			}
			return popupType switch
			{
				MsgCodePopupType.Dialog => ErrorPresentation.Dialog, 
				MsgCodePopupType.Toast => ErrorPresentation.Toast, 
				_ => ErrorPresentation.None, 
			};
		}
	}

	private static bool ReportErrorCode(CodeModule codeModule, string code, int rank)
	{
		try
		{
			ClientErrorCode evt = EventTrackSolver.Instance.GetEvt<ClientErrorCode>();
			int num = (int)codeModule;
			evt.systemModule = num.ToString("D2");
			evt.errorCode = code;
			evt.rank = rank;
			EventTrackSolver.Instance.Dispatch(evt);
			return true;
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Failed to report error code {code}: {arg}");
			}
			return false;
		}
	}

	private static void Present(ResolvedError error, ErrorPresentation presentation, Action onConfirm, Action onCancel, bool hideErrorCode)
	{
		switch (presentation)
		{
		case ErrorPresentation.Dialog:
			ShowDialog(error.Code, error.Title, error.Message, onConfirm, onCancel, hideErrorCode);
			break;
		case ErrorPresentation.Toast:
			GameUtility.OpenToolTip(hideErrorCode ? error.Message : (error.Message + " code：" + error.Code));
			break;
		}
	}

	private static void ShowDialog(string code, string title, string message, Action onConfirm, Action onCancel, bool hideErrorCode)
	{
		if (!Singleton<NewUIManager>.instance.ShowMessage(new MonoMessageBox.Message
		{
			btn1Text = "确认",
			btn2Text = ((onCancel != null) ? "取消" : null),
			callBack = (onConfirm ?? ((Action)(() =>
			{
			}))),
			callBack2 = onCancel,
			content = (hideErrorCode ? message : (message + "\ncode：" + code)),
			titleText = title,
			isShowSingle = (onCancel == null)
		}))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Unable to show error dialog " + code + " because MessageBox is not ready.");
			}
			onConfirm?.Invoke();
		}
	}
}
