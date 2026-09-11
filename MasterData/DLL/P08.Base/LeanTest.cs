using UnityEngine;

public class LeanTest
{
	public static int expected = 0;

	private static int tests = 0;

	private static int passes = 0;

	public static float timeout = 15f;

	public static bool timeoutStarted = false;

	public static bool testsFinished = false;

	public static void debug(string name, bool didPass, string failExplaination = null)
	{
		expect(didPass, name, failExplaination);
	}

	public static void expect(bool didPass, string definition, string failExplaination = null)
	{
		float num = printOutLength(definition);
		int totalWidth = 40 - (int)(num * 1.05f);
		string text = "".PadRight(totalWidth, "_"[0]);
		string text2 = formatB(definition) + " " + text + " [ " + (didPass ? formatC("pass", "green") : formatC("fail", "red")) + " ]";
		if (!didPass && failExplaination != null)
		{
			text2 = text2 + " - " + failExplaination;
		}
		Debug.Log(text2);
		if (didPass)
		{
			passes++;
		}
		tests++;
		if (tests == expected && !testsFinished)
		{
			overview();
		}
		else if (tests > expected)
		{
			Debug.Log(formatB("Too many tests for a final report!") + " set LeanTest.expected = " + tests);
		}
		if (!timeoutStarted)
		{
			timeoutStarted = true;
			GameObject obj = new GameObject
			{
				name = "~LeanTest"
			};
			(obj.AddComponent(typeof(LeanTester)) as LeanTester).timeout = timeout;
			obj.hideFlags = HideFlags.HideAndDontSave;
		}
	}

	public static string padRight(int len)
	{
		string text = "";
		for (int i = 0; i < len; i++)
		{
			text += "_";
		}
		return text;
	}

	public static float printOutLength(string str)
	{
		float num = 0f;
		for (int i = 0; i < str.Length; i++)
		{
			num = ((str[i] != "I"[0]) ? ((str[i] != "J"[0]) ? (num + 1f) : (num + 0.85f)) : (num + 0.5f));
		}
		return num;
	}

	public static string formatBC(string str, string color)
	{
		return formatC(formatB(str), color);
	}

	public static string formatB(string str)
	{
		return "<b>" + str + "</b>";
	}

	public static string formatC(string str, string color)
	{
		return "<color=" + color + ">" + str + "</color>";
	}

	public static void overview()
	{
		testsFinished = true;
		int num = expected - passes;
		string text = ((num > 0) ? formatBC(num.ToString() ?? "", "red") : (num.ToString() ?? ""));
		Debug.Log(formatB("Final Report:") + " _____________________ PASSED: " + formatBC(passes.ToString() ?? "", "green") + " FAILED: " + text + " ");
	}
}
