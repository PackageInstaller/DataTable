using UnityEngine;

namespace Ase;

public class WeaknessEffect : MonoBehaviour
{
	private float life;

	public float maxLife;

	public ParticleSystem particleSystem;

	public void Init(Color color, float scale)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		life = 0f;
		MainModule main = particleSystem.main;
		((MainModule)(ref main)).startColor = MinMaxGradient.op_Implicit(color);
		GetComponent<RectTransform>().localScale = new Vector3(scale / 2f, 1f, 1f);
		GetComponent<RectTransform>().anchoredPosition3D = Vector3.zero;
		particleSystem.Play();
	}

	public void AddLife(float delta)
	{
		life += delta;
	}

	public bool Finish()
	{
		return life >= maxLife;
	}

	private void OnDisable()
	{
		life = 0f;
	}
}
