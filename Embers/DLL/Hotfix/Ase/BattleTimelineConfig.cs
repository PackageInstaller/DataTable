using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class BattleTimelineConfig : MonoBehaviour
{
	public bool groupOnly = true;

	public List<string> groupTrack = new List<string>();

	public List<string> track = new List<string>();

	public bool ContainsGroup(string name)
	{
		return groupTrack.Contains(name);
	}

	public bool ContainsTrack(string name)
	{
		return track.Contains(name);
	}
}
