namespace AIScript;

public abstract class TowerDefenseThemeEnvironmentBase
{
	protected ITowerDefenseGameplayHost host;

	public virtual void Init(ITowerDefenseGameplayHost host)
	{
		this.host = host;
	}

	public virtual void SeedGrid(TowerDefenseMapData.TowerGrid grid)
	{
	}

	public virtual void OnStart()
	{
	}

	public virtual void OnUpdate()
	{
	}

	public virtual void Clear()
	{
	}

	public virtual void OnRolePlaced(int gridIndex)
	{
	}

	public virtual bool IsGridSprayed(int gridIndex)
	{
		return false;
	}

	public virtual bool IsGridOnFire(int gridIndex)
	{
		return false;
	}

	public virtual bool IsGridDeployable(int gridIndex)
	{
		return true;
	}

	public virtual bool IsGridLit(int gridIndex)
	{
		return false;
	}
}
