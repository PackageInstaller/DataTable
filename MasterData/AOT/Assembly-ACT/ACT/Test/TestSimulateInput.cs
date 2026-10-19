using ACT.RichText;
using UnityEngine;

namespace ACT.Test;

public class TestSimulateInput : MonoBehaviour
{
	public string formula;

	public int id;

	public void Calculate()
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(CustomTagParser.ReplaceText(id, formula, 1));
		}
	}
}
