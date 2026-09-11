using System.Collections.Generic;
using UnityEngine;

namespace RogueCard;

public class InputLockWatcher : MonoBehaviour
{
	private List<InputLockToken> tokens = new List<InputLockToken>();

	public void Watch(InputLockToken token)
	{
		if (!tokens.Contains(token))
		{
			tokens.Add(token);
		}
	}

	private void OnDestroy()
	{
		foreach (InputLockToken token in tokens)
		{
			if (token != null && !token.isReleased)
			{
				token.Release();
			}
		}
		tokens.Clear();
	}
}
