using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ES3GameObject : MonoBehaviour
{
	public List<Component> components = new List<Component>();

	private void Update()
	{
		_ = Application.isPlaying;
	}
}
