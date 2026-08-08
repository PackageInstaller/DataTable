using GraphicGadgets.Runtime.Fluid2D;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineFluidNodeBehaviour : PlayableBehaviour
{
	public FluidNodeType fluidType;

	public string sceneFluidPath;

	public string sourceName;

	public string attachPoint;

	public Vector3 localOffset;

	public Color color;

	public bool localPlayer;

	public float radius;

	public float size;

	private AgitatorController com;

	private FluidLocal fluidLocal;

	private Fluid2D fluid2D;

	private bool added;

	public void InitAgitatorController(object playerData)
	{
		if (com != null)
		{
			return;
		}
		if (!(playerData is Animator { transform: var transform }))
		{
			Debug.LogError("StoryTimelineFluidNodeBehaviour.animator == null");
		}
		else
		{
			if (transform == null)
			{
				return;
			}
			if (!string.IsNullOrEmpty(attachPoint))
			{
				Transform transform2 = transform.Find(attachPoint);
				if (transform2 != null)
				{
					transform = transform2;
				}
			}
			Transform transform3 = transform.Find(sourceName);
			if (transform3 == null)
			{
				GameObject gameObject = new GameObject(sourceName);
				com = gameObject.AddComponent<AgitatorController>();
				gameObject.transform.parent = transform;
			}
			else
			{
				com = transform3.GetComponent<AgitatorController>();
				if (com != null)
				{
					com = transform3.gameObject.AddComponent<AgitatorController>();
				}
			}
			if (!(com == null))
			{
				com.agitatorColor = color;
				com.radius = radius;
				com.size = size;
				com.mainCharacter = localPlayer;
				com.transform.localPosition = localOffset;
			}
		}
	}

	public void InitFluid()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null || battleScene.sceneSetting == null)
		{
			return;
		}
		Transform transform = battleScene.sceneSetting.transform.Find(sceneFluidPath);
		if (fluidType == FluidNodeType.FluidLocal)
		{
			if (transform != null && fluidLocal == null)
			{
				fluidLocal = transform.GetComponent<FluidLocal>();
			}
		}
		else if (transform != null && fluid2D == null)
		{
			fluid2D = transform.GetComponent<Fluid2D>();
		}
	}

	public void Add()
	{
		if (!added)
		{
			if (fluidType == FluidNodeType.FluidLocal && fluidLocal != null)
			{
				fluidLocal.AddAgitator(com);
			}
			else if (fluidType == FluidNodeType.Fluid2D && fluid2D != null)
			{
				fluid2D.AddAgitator(com);
			}
			added = true;
		}
	}

	public void Remove()
	{
		if (added)
		{
			if (fluidType == FluidNodeType.FluidLocal && fluidLocal != null)
			{
				fluidLocal.RemoveAgitator(com);
			}
			else if (fluidType == FluidNodeType.Fluid2D && fluid2D != null)
			{
				fluid2D.RemoveAgitator(com);
			}
			added = false;
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!added)
		{
			InitAgitatorController(playerData);
			InitFluid();
			Add();
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		Remove();
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		Remove();
	}
}
