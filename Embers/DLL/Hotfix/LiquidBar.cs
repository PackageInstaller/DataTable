using System.Collections;
using UnityEngine;
using UnityEngine.UI;

[ExecuteInEditMode]
public class LiquidBar : MonoBehaviour
{
	public enum Rotation
	{
		Right,
		Left,
		Up,
		Down
	}

	[Tooltip("Bar-Z material")]
	public Material material;

	private Image mask;

	[Header("--- Bar Script Parameters ---")]
	[Tooltip("Do the transition effect automaticaly when the fill amount reach 1")]
	public bool automaticTransitionEffect;

	[Tooltip("Amount of the bar shown, (f.ex: 0.5 is 50%), the bar go to this value more or less quickly depending of the smoothness.")]
	[Range(0f, 1f)]
	public float targetFillAmount;

	[Tooltip("Defines how fast the bar will go to its target fill amount value")]
	public float smoothness;

	[HideInInspector]
	public float currentFillAmount;

	[Header("--- Shader Parameters ---")]
	[Space]
	[Tooltip("Tick this if you'll have more than one instance of this bar. Otherwise the parameters like the fill amount will be shared")]
	public bool instanciatedMaterial;

	[Header("Colors")]
	[Tooltip("The bar color, handles transparency too")]
	[ColorUsage(true, true)]
	public Color barColor;

	[Tooltip("The background color, handles transparency too")]
	public Color backgroundColor;

	[Header("UVs")]
	[Range(0.01f, 1f)]
	[Tooltip("The resolution of the bar, try 0.2 for a pixelated result")]
	public float resolution = 1f;

	[Tooltip("Spherize the UV, usefull with a circle mask")]
	public bool spherize;

	[Tooltip("Bar rotation")]
	public Rotation rotation;

	[Header("Inside Noise")]
	[Tooltip("The scale of the noise inside of the bar")]
	[Range(1f, 200f)]
	public float insideNoiseScale = 25f;

	[Tooltip("Defines how visible is the noise inside the bar")]
	[Range(0f, 1f)]
	public float insideNoiseIntensity = 0.25f;

	[Tooltip("Defines how detailed is the noise inside the bar")]
	[Range(1f, 255f)]
	public float insideNoiseColorVariation = 50f;

	[Header("Border")]
	[Tooltip("The scale of the noise applied to the border, set to 0 for a straight line")]
	[Range(0f, 50f)]
	public float borderNoiseScale = 3f;

	[Tooltip("The amount of distortion applied to the border, set to 0 for a straight line")]
	[Range(0f, 0.3f)]
	public float borderDistortionAmount = 0.1f;

	[Tooltip("Defines how reactive the border light is to the fill amount changes. (f.ex: 100 makes the bar lights up to small value variation)")]
	public float borderLightReactivity = 10f;

	private Vector2 pixelSize;

	private Vector2 ratio;

	private bool onTransition;

	private void Awake()
	{
		if (material == null)
		{
			if (instanciatedMaterial)
			{
				material = new Material(Shader.Find("Shader Graphs/Bar"));
				UpdateMaterial();
				GetComponent<Image>().material = material;
			}
			else
			{
				material = GetComponent<Image>().material;
			}
		}
		mask = GetComponent<Image>();
	}

	private void Update()
	{
		if (automaticTransitionEffect && currentFillAmount >= 0.99f && !onTransition)
		{
			StartTransition();
		}
		float num = Mathf.Abs(currentFillAmount - targetFillAmount);
		material.SetFloat("_MovingAmount", num * borderLightReactivity);
		if (!onTransition)
		{
			currentFillAmount = Mathf.Lerp(currentFillAmount, targetFillAmount, Time.deltaTime * smoothness);
		}
		material.SetFloat("_Amount", currentFillAmount);
	}

	public void StartTransition()
	{
		onTransition = true;
		currentFillAmount = 1f;
		StopAllCoroutines();
		StartCoroutine(Transition());
	}

	private IEnumerator Transition()
	{
		float t = 0f;
		while (t < 1f)
		{
			t += Time.deltaTime;
			material.SetFloat("_DissolveTransition", t);
			yield return null;
		}
		currentFillAmount = 0f;
		targetFillAmount = 0f;
		t = 0f;
		while (t < 1f)
		{
			t += Time.deltaTime;
			material.SetFloat("_DissolveAmount", t);
			yield return null;
		}
		material.SetFloat("_DissolveAmount", 0f);
		material.SetFloat("_DissolveTransition", 0f);
		onTransition = false;
	}

	private void UpdateMaterial()
	{
		if (mask == null)
		{
			mask = GetComponent<Image>();
		}
		switch (rotation)
		{
		case Rotation.Down:
			material.SetFloat("_Rotation", 270f);
			break;
		case Rotation.Up:
			material.SetFloat("_Rotation", 90f);
			break;
		case Rotation.Left:
			material.SetFloat("_Rotation", 180f);
			break;
		case Rotation.Right:
			material.SetFloat("_Rotation", 0f);
			break;
		}
		pixelSize = (mask.preserveAspect ? (mask.sprite.rect.size * resolution) : (GetComponent<RectTransform>().sizeDelta * resolution));
		ratio = (spherize ? Vector2.one : pixelSize.normalized);
		material.SetVector("_PixelSize", pixelSize);
		material.SetVector("_Ratio", ratio);
		material.SetFloat("_BorderNoiseScale", borderNoiseScale);
		material.SetColor("_Color", barColor);
		material.SetFloat("_InsideNoiseScale", insideNoiseScale);
		material.SetFloat("_Spherize", spherize ? 1 : 0);
		material.SetFloat("_InsideNoiseIntensity", insideNoiseIntensity);
		material.SetFloat("_BorderDistortionAmount", borderDistortionAmount);
		material.SetColor("_BackgroundColor", backgroundColor);
		material.SetFloat("_InsideNoiseRoundFactor", insideNoiseColorVariation);
	}

	private void OnApplicationQuit()
	{
		material.SetFloat("_DissolveAmount", 0f);
		material.SetFloat("_DissolveTransition", 0f);
	}
}
