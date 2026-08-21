using UnityEngine;

namespace Ase;

public class PerCallBack : MonoBehaviour
{
	public void OnIsAgreePermission(string data)
	{
		KiifInterface._IsAgreePermission = data;
	}
}
