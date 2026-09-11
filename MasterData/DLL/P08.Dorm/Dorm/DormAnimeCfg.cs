using System.Collections.Generic;
using UnityEngine;

namespace Dorm;

[CreateAssetMenu(fileName = "DormAnimeCfg", menuName = "ScriptableObjects/后宅角色动画名配置")]
public class DormAnimeCfg : ScriptableObject
{
	public string moveAnime;

	public string standAnime;

	public string idleAnime;

	public IEnumerable<string> EnumerateAnime()
	{
		yield return standAnime;
		yield return idleAnime;
		yield return moveAnime;
	}
}
