using Ase;
using Ase.ECS;
using Sirenix.OdinInspector;

public class BaseSceneObject : SerializedMonoBehaviour, IInit, IStart
{
	protected SceneSystem sceneSystem;

	public SceneSystem SceneSystem
	{
		get
		{
			return sceneSystem;
		}
		set
		{
			sceneSystem = value;
		}
	}

	public virtual void OnInit(object data = null)
	{
		sceneSystem = (SceneSystem)data;
	}

	public virtual void OnStart(object data = null)
	{
	}
}
