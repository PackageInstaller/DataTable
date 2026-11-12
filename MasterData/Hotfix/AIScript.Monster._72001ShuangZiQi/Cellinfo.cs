using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72001ShuangZiQi;

public class Cellinfo
{
	public TSVector2 index;

	public TSVector2 worldPos;

	public long gridColor;

	public AdventureActor actor1;

	public AdventureActor actor2;

	public Vector3 position;

	public int cellIndex;

	private PlayFX playFX_last = new PlayFX();

	private PlayFX playFX_current = new PlayFX();

	private PlayFX playFX_Choose_Red = new PlayFX();

	private PlayFX playFX_Choose_Green = new PlayFX();

	private Dictionary<long, AdventureActor> actorDic = new Dictionary<long, AdventureActor>();

	public bool isBossPos
	{
		get
		{
			if (index == Config.redBossPos || index == Config.greenBossPos)
			{
				return true;
			}
			return false;
		}
	}

	public void Clear()
	{
		playFX_Choose_Red.Stop();
		playFX_Choose_Green.Stop();
		playFX_last.Stop();
		playFX_current.Stop();
		actorDic.Clear();
	}

	public void OnEnter(AdventureActor actor, bool needSync)
	{
		if (!actorDic.ContainsKey(actor.Id))
		{
			actorDic.Add(actor.Id, actor);
		}
		if (!(actor is PlayerAdventureActor { isAssist: not false }) && !(actor is MonsterAdventureActor))
		{
			PlayChooseFx(actor);
		}
	}

	public void OnExit(AdventureActor actor, bool needSync)
	{
		if (actorDic.ContainsKey(actor.Id))
		{
			actorDic.Remove(actor.Id);
		}
		if (actor is PlayerAdventureActor { isAssist: false })
		{
			playFX_Choose_Red.Stop();
			playFX_Choose_Green.Stop();
		}
	}

	public void OnUpdate(List<AdventureActor> list)
	{
		_ = gridColor;
	}

	public void RefreshColor(long newColor)
	{
		if (gridColor != newColor)
		{
			RefreshFx(gridColor, newColor);
			gridColor = newColor;
			RefreshCellByColor();
		}
		gridColor = newColor;
	}

	private void RefreshFx(long lastColor, long newColor)
	{
		playFX_last.Stop();
		string fxAlias = "";
		switch (lastColor)
		{
		case 0L:
			switch (newColor)
			{
			case 1L:
				fxAlias = Config.FX_W2R;
				break;
			case 2L:
				fxAlias = Config.FX_W2G;
				break;
			}
			break;
		case 1L:
			switch (newColor)
			{
			case 0L:
				fxAlias = Config.FX_R2W;
				break;
			case 2L:
				fxAlias = Config.FX_R2G;
				break;
			}
			break;
		case 2L:
			switch (newColor)
			{
			case 0L:
				fxAlias = Config.FX_G2W;
				break;
			case 1L:
				fxAlias = Config.FX_G2R;
				break;
			}
			break;
		}
		AdventureActor adventureActor = (actor1 ? actor1 : actor2);
		if (!(adventureActor == null))
		{
			playFX_current.Play(adventureActor, fxAlias, 1f, position, adventureActor.transform.rotation);
			playFX_current.fxInstance.ownerActor = null;
			playFX_last = playFX_current;
		}
	}

	private void RefreshCellByColor()
	{
		foreach (KeyValuePair<long, AdventureActor> item in actorDic)
		{
			AdventureActor value = item.Value;
			if (!(value == null) && value.actorHealthInfo.isAlive && value is PlayerAdventureActor { isAssist: false })
			{
				PlayChooseFx(value);
			}
		}
	}

	private void PlayChooseFx(AdventureActor actor)
	{
		if (gridColor == 1)
		{
			playFX_Choose_Green.Stop();
			if (!playFX_Choose_Red.isPlaying)
			{
				AdventureActor adventureActor = (actor1 ? actor1 : actor2);
				if (!(adventureActor == null))
				{
					playFX_Choose_Red.Play(adventureActor, Config.FX_Player_Red, 1f, position, Quaternion.identity);
					playFX_Choose_Red.fxInstance.ownerActor = null;
				}
			}
		}
		else
		{
			if (gridColor != 2)
			{
				return;
			}
			playFX_Choose_Red.Stop();
			if (!playFX_Choose_Green.isPlaying)
			{
				AdventureActor adventureActor2 = (actor1 ? actor1 : actor2);
				if (!(adventureActor2 == null))
				{
					playFX_Choose_Green.Play(adventureActor2, Config.FX_Player_Green, 1f, position, Quaternion.identity);
					playFX_Choose_Green.fxInstance.ownerActor = null;
				}
			}
		}
	}
}
