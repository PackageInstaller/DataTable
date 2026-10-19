using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class MaterialColorPropotySet : MonoBehaviour
{
	public List<Material> _mats = new List<Material>();

	public List<string> _names = new List<string>();

	[ColorUsage(true, true)]
	public Color _color = Color.white;

	private void Update()
	{
		if (_mats.Count < 1 || _names.Count < 1)
		{
			return;
		}
		foreach (Material mat in _mats)
		{
			foreach (string name in _names)
			{
				mat.SetVector(name, _color);
			}
		}
	}
}
