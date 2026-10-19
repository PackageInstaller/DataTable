using ACT.Utility;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle;

public class CameraShow : MonoBehaviour
{
	public bool isUseScreenTurnDark;

	public Volume volume;

	private Vignette vignette;

	[Header("压暗效果的变化速度")]
	[Range(0f, 5f)]
	[SerializeField]
	private float fadeSpeed = 1f;

	[Header("压暗强度最大值")]
	[Range(0f, 1f)]
	[SerializeField]
	private float effectMax = 0.6f;

	public Color defaultColor;

	private bool IsFadeIn;

	private bool IsFadeOut;

	public bool isUseSceneTurnDark;

	public float time;

	private bool isStart;

	private float m_time;

	public bool IsGetAttribute { get; private set; }

	private void Start()
	{
		IsFadeIn = false;
		isStart = false;
		IsGetAttribute = volume.profile.TryGet<Vignette>(out vignette);
		if (!IsGetAttribute)
		{
			CreatVignetteEffect(defaultColor);
		}
	}

	private void Update()
	{
		if (IsFadeIn)
		{
			vignette.intensity.value += fadeSpeed * Time.deltaTime;
			IsFadeIn = vignette.intensity.value < effectMax;
			IsFadeOut = !IsFadeIn;
		}
		if (IsFadeOut)
		{
			vignette.intensity.value -= fadeSpeed * Time.deltaTime;
			IsFadeOut = vignette.intensity.value < effectMax;
		}
		if (isStart)
		{
			GameUtility.mainLight.cullingMask = 64;
			if (GameManager.timeSystem.time - m_time >= time)
			{
				GameUtility.mainLight.cullingMask = -1;
				isStart = false;
			}
		}
	}

	public void TriggerEffect()
	{
		if (IsGetAttribute)
		{
			IsFadeIn = true;
		}
	}

	public void StartScreenDarkEffect()
	{
		isStart = true;
		m_time = GameManager.timeSystem.time;
	}

	private void CreatVignetteEffect(Color color)
	{
		vignette = volume.profile.Add<Vignette>(overrides: true);
		vignette.color.value = color;
		vignette.intensity.value = 0f;
		IsGetAttribute = true;
	}
}
