using System.Collections.Generic;
using Ase.ECS;
using UnityEngine.EventSystems;

namespace Ase;

public class StatInfoViewBase : UIBehaviour
{
	public void OnShow(bool isShow)
	{
		this.SetVisibility(isShow);
	}

	public virtual void OnInit()
	{
	}

	public virtual void OnInitInfo(List<HeroEntity> heros)
	{
	}

	public virtual void OnRefreshStat(int battleTime, int entityId, EntityStatInfo info, List<EntityStatInfo> infoList)
	{
	}

	public virtual void ResetStatInfo()
	{
	}

	public virtual void OnFixedUpdate(float deltaTime)
	{
	}

	public virtual void UpdateTimer(float timer)
	{
	}
}
