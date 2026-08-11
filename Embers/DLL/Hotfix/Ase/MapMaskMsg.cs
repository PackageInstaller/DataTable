using System;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class MapMaskMsg : MessageBase, IReference
{
	private int index;

	public int Index => index;

	public MapMaskMsg(object sender, int index)
		: base(sender)
	{
		this.index = index;
	}

	public void Clear()
	{
		throw new NotImplementedException();
	}
}
