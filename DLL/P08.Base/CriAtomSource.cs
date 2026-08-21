using System.Collections;
using UnityEngine;

[AddComponentMenu("CRIWARE/CRI Atom Source")]
public class CriAtomSource : CriAtomSourceBase
{
	[SerializeField]
	private string _cueName = "";

	[SerializeField]
	private string _cueSheet = "";

	public string cueName
	{
		get
		{
			return _cueName;
		}
		set
		{
			_cueName = value;
		}
	}

	public string cueSheet
	{
		get
		{
			return _cueSheet;
		}
		set
		{
			_cueSheet = value;
		}
	}

	public override CriAtomExPlayback Play()
	{
		return Play(cueName);
	}

	protected override CriAtomExAcb GetAcb()
	{
		CriAtomExAcb result = null;
		if (!string.IsNullOrEmpty(cueSheet))
		{
			result = CriAtom.GetAcb(cueSheet);
		}
		return result;
	}

	protected override void PlayOnStart()
	{
		if (base.playOnStart && !string.IsNullOrEmpty(cueName))
		{
			StartCoroutine(PlayAsync(cueName));
		}
	}

	private IEnumerator PlayAsync(string cueName)
	{
		CriAtomExAcb acb = null;
		while (acb == null && !string.IsNullOrEmpty(cueSheet))
		{
			acb = CriAtom.GetAcb(cueSheet);
			if (acb == null)
			{
				yield return null;
			}
		}
		base.player.SetCue(acb, cueName);
		InternalPlayCue();
	}
}
