using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class PrologueBattleLevelMsg : LogicEntity
{
	protected static PrologueBattleLevelMsg g_instance;

	public TSVector2 revivalPos;

	public List<string> btnNames = new List<string>();

	public static PrologueBattleLevelMsg Instance
	{
		get
		{
			if (g_instance == null)
			{
				PrologueBattleLevelMsg[] array = Object.FindObjectsOfType<PrologueBattleLevelMsg>();
				int num = array.Length;
				if (num > 1 || num == 1)
				{
					g_instance = array[0];
				}
			}
			return g_instance;
		}
	}
}
