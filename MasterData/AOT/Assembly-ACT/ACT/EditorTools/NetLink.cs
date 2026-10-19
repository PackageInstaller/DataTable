using System.Diagnostics;
using UnityEngine;

namespace ACT.EditorTools;

public class NetLink : MonoBehaviour
{
	[TextArea]
	public string desc;

	public string link;

	private void linkThoughts()
	{
		Process.Start(link);
	}
}
