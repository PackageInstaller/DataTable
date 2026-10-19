using System.Collections.Generic;
using UnityEngine;

namespace ACT.Model;

internal static class FacePushFlowLog
{
	private static readonly HashSet<string> s_reported = new HashSet<string>();

	public static void Success(string step, string detail = null)
	{
		Write(failed: false, step, detail, dedupe: true);
	}

	public static void Fail(string step, string reason)
	{
		Write(failed: true, step, reason, dedupe: true);
	}

	public static void SuccessAlways(string step, string detail = null)
	{
		Write(failed: false, step, detail, dedupe: false);
	}

	public static void FailAlways(string step, string reason)
	{
		Write(failed: true, step, reason, dedupe: false);
	}

	private static void Write(bool failed, string step, string detail, bool dedupe)
	{
		if (!LuminApplication.LogEnabled)
		{
			return;
		}
		if (failed && string.IsNullOrEmpty(detail))
		{
			detail = "未提供原因";
		}
		string text;
		if (failed)
		{
			text = "[拍脸] " + step + "失败：" + detail;
		}
		else
		{
			text = (string.IsNullOrEmpty(detail) ? ("[拍脸] " + step + "成功") : ("[拍脸] " + step + "成功：" + detail));
		}
		if (!dedupe || s_reported.Add(text))
		{
			if (failed)
			{
				Debug.LogWarning(text);
			}
			else
			{
				Debug.Log(text);
			}
		}
	}
}
