using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class Uid<T> where T : Component, IUidProvider
{
	private T component;

	[SerializeField]
	[HideInInspector]
	private int id;

	private bool m_LockUid = true;

	public int Value
	{
		get
		{
			return id;
		}
		set
		{
			id = value;
		}
	}

	public Uid(T component)
	{
		this.component = component;
	}
}
