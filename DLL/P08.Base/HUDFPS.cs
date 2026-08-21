using UnityEngine;

public class HUDFPS : MonoBehaviour
{
	public float updateInterval = 0.5f;

	private float accum;

	private int frames;

	private float timeleft;

	private string fpsDesc;

	private Color fpsColor;

	private float worst;

	private string worstDesc;

	private GUIStyle style;

	private Rect rect;

	private void Start()
	{
		style = new GUIStyle();
		style.fontSize = 24;
		rect = new Rect(Screen.width / 2 - 100, 0f, 200f, 200f);
		fpsDesc = string.Empty;
		worstDesc = string.Empty;
		timeleft = updateInterval;
	}

	private void Update()
	{
		float unscaledDeltaTime = Time.unscaledDeltaTime;
		if (0f == unscaledDeltaTime)
		{
			return;
		}
		timeleft -= unscaledDeltaTime;
		accum += unscaledDeltaTime;
		frames++;
		if (unscaledDeltaTime > worst)
		{
			worst = unscaledDeltaTime;
		}
		if ((double)timeleft <= 0.0)
		{
			float num = (float)frames / accum;
			string text = $"FPS:{num:F2}";
			fpsDesc = text;
			if (num < 30f)
			{
				fpsColor = Color.yellow;
			}
			else if (num < 20f)
			{
				fpsColor = Color.blue;
			}
			else if (num < 10f)
			{
				fpsColor = Color.red;
			}
			else
			{
				fpsColor = Color.green;
			}
			worstDesc = $"Worst:{1f / worst:F2}";
			timeleft = updateInterval;
			accum = 0f;
			frames = 0;
			worst = 0f;
		}
	}

	private void OnGUI()
	{
		GUILayout.BeginArea(rect);
		GUILayout.BeginVertical();
		GUI.backgroundColor = new Color(0.6f, 0.6f, 0.6f, 0.7f);
		style.normal.textColor = fpsColor;
		GUILayout.Label(fpsDesc, style);
		style.normal.textColor = new Color(1f, 1f, 0f, 1f);
		GUILayout.Label(worstDesc, style);
		GUILayout.EndVertical();
		GUILayout.EndArea();
	}
}
