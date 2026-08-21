using UnityEngine;

namespace Ase;

public class Type4StarItem : MonoBehaviour
{
	public GameObject maxStar;

	public GameObject noPass;

	public GameObject pass;

	private int state;

	public int State
	{
		get
		{
			return state;
		}
		set
		{
			state = value;
			maxStar.gameObject.SetActive(value == 2);
			pass.gameObject.SetActive(value == 1);
			noPass.gameObject.SetActive(value == 0);
		}
	}

	public int Index { get; set; }
}
