using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class BlastParameter : MonoBehaviour
{
	public float power = 10f;

	public float radius = 5f;

	public float upwards = 3f;

	public AnimationCurve curve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 0f));

	public float gemDrag = 3f;

	public float touchTime = 1f;

	public GameObject blast;

	public float blastTime = 1f;

	public GameObject GoldBlast;

	public float GoldblastTime = 1f;

	public GameObject GoldBlastEffect;

	public float GoldBlastEffectTime = 3f;

	public GameObject GoldDelayBlastEffect;

	public float GoldDelayBlastEffectTime = 4f;

	[SerializeField]
	public List<GameObject> blastList;

	public async Task Init()
	{
		Transform[] transforms = base.gameObject.GetComponentsInChildren<Transform>();
		foreach (Transform transform in transforms)
		{
			Blast component = transform.GetComponent<Blast>();
			if ((bool)component && transform.gameObject.transform.parent == base.gameObject.transform)
			{
				component.SetBlastParameter(this);
				await component.SetupCollider();
			}
		}
	}
}
