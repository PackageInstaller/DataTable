using System;

namespace UnityEngine;

public sealed class AddComponentMenu : Attribute
{
	private string m_AddComponentMenu;

	private int m_Ordering;

	public string componentMenu => m_AddComponentMenu;

	public int componentOrder => m_Ordering;

	public AddComponentMenu(string menuName)
	{
		m_AddComponentMenu = menuName;
		m_Ordering = 0;
	}

	public AddComponentMenu(string menuName, int order)
	{
		m_AddComponentMenu = menuName;
		m_Ordering = order;
	}
}
