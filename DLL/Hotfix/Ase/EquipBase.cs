using System.Collections.Generic;

namespace Ase;

public struct EquipBase
{
	public int Type;

	public int EquipId;

	public long Uuid;

	public long RoleId;

	public int Level;

	public int Exp;

	public bool Locked;

	public int Star;

	public int Refine;

	public int Rank;

	public int SubType;

	public List<AttributeBase> AttributeBaseList;

	public List<EntryBase> EntryBaseList;

	public List<EntryBase> BackUpEntryList;
}
