using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class DamageNumberWeakEffect : MonoBehaviour
{
	[SerializeField]
	private int ByteNumOffset = 32;

	[SerializeField]
	private Animation animation;

	[SerializeField]
	private RectTransform glowAndboardRoot;

	[SerializeField]
	private Image glow;

	[SerializeField]
	private Image board;

	[SerializeField]
	private ParticleSystem glow1;

	[SerializeField]
	private ParticleSystem glow2;

	[SerializeField]
	private ParticleSystem glow3;

	[SerializeField]
	private RectTransform arrowLeft;

	[SerializeField]
	private Image arrow1;

	[SerializeField]
	private Image arrow3;

	[SerializeField]
	private RectTransform arrowRight;

	[SerializeField]
	private Image arrow2;

	[SerializeField]
	private Image arrow4;

	public void Init(WeakColor color)
	{
		glow.color = color.glow;
		arrow1.color = color.arrowColor;
		arrow2.color = color.arrowColor;
		arrow3.color = color.arrowColor;
		arrow4.color = color.arrowColor;
		SetParticleColor(glow1, color.glow1);
		SetParticleColor(glow2, color.glow2);
		SetParticleColor(glow3, color.glow3);
		animation.Play("Show");
	}

	public void SetWidth(int value)
	{
		int num = ByteNumOffset * ((value < 3) ? 2 : (value - 1)) / 4;
		arrowLeft.localPosition = new Vector3(-num, arrowLeft.localPosition.y, arrowLeft.localPosition.z);
		arrowRight.localPosition = new Vector3(num, arrowLeft.localPosition.y, arrowLeft.localPosition.z);
	}

	public void ScaleWeakEffect(Transform target, float digits)
	{
		Vector3 localScale = target.transform.localScale;
		localScale.x = digits / 7f;
		target.transform.localScale = localScale;
	}

	private void SetParticleColor(ParticleSystem particleSystem, ParticleSystem.MinMaxGradient color)
	{
		ParticleSystem.MainModule main = particleSystem.main;
		main.startColor = color;
	}
}
