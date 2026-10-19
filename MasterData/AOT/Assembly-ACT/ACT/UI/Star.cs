using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class Star : MonoBehaviour
{
	public Animation animation;

	public Image starImage;

	public GameObject spark;

	public GameObject starGlow;

	public Image starGlowImage;

	public void FadeIn()
	{
		animation.Play("Star");
	}

	public void SetDark()
	{
		Color color = starImage.color;
		color.a = 0f;
		starImage.color = color;
		spark.SetActive(value: false);
		starGlow.SetActive(value: false);
		Color color2 = starGlowImage.color;
		color2.a = 1f;
		starGlowImage.color = color2;
	}

	public void SetLight()
	{
		Color color = starImage.color;
		color.a = 1f;
		starImage.color = color;
		starGlow.SetActive(value: false);
		Color color2 = starGlowImage.color;
		color2.a = 0f;
		starGlowImage.color = color2;
	}
}
