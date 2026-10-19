using System.Collections.Generic;

namespace Bamboo.Command;

internal class PeekInfosCache
{
	private bool _isUsing;

	public readonly List<BasePeekInfo> Infos = new List<BasePeekInfo>();

	public bool IsUsing => _isUsing;

	public void Use()
	{
		_isUsing = true;
		Infos.Clear();
	}

	public void Recycle()
	{
		Infos.Clear();
		_isUsing = false;
	}
}
