using System.Collections.Generic;
using UnityEngine;

public class EffectScaleOnAttach : MonoBehaviour
{
	public List<string> AttachTransformNameList = new List<string>();

	public List<Vector3> EffectScaleList = new List<Vector3>();

	private Dictionary<string, Vector3> Attach2Scale;

	private void OnEnable()
	{
		Init();
	}

	private void Init()
	{
		if (Attach2Scale == null)
		{
			Attach2Scale = new Dictionary<string, Vector3>();
		}
		for (int i = 0; i < AttachTransformNameList.Count; i++)
		{
			if (!Attach2Scale.ContainsKey(AttachTransformNameList[i]))
			{
				Attach2Scale.Add(AttachTransformNameList[i], EffectScaleList[i]);
			}
		}
	}

	public bool TryGetEffectScale(string attachName, out Vector3 scale)
	{
		if (Attach2Scale == null)
		{
			Init();
		}
		return Attach2Scale.TryGetValue(attachName, out scale);
	}
}
