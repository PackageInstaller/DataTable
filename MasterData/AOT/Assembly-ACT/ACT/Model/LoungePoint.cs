using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.Model;

public class LoungePoint
{
	public int id;

	public List<int> character = new List<int>();

	public int waitStory;

	public int performID;

	public int name;

	public bool performToday;

	public int idleID;

	public LoungeInteractPointUseType useType;
}
