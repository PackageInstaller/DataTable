namespace Capture.Runtime;

public class ComponentsManager
{
	public ComponentAccessor<TransformComponent> transformComponents;

	public ComponentAccessor<OBBComponent> obbComponents;

	public ComponentAccessor<OcculuderComponent> occuluderComponents;

	public ComponentAccessor<OcculusionComponent> occulusionComponents;

	public ComponentsManager()
	{
		Init();
	}

	public void Init()
	{
		transformComponents = new ComponentAccessor<TransformComponent>();
		obbComponents = new ComponentAccessor<OBBComponent>();
		occuluderComponents = new ComponentAccessor<OcculuderComponent>();
		occulusionComponents = new ComponentAccessor<OcculusionComponent>();
	}

	public long AllocComponent(int type)
	{
		if (type == ComponentConst.TransformComponentType)
		{
			return transformComponents.AllocComponent();
		}
		if (type == ComponentConst.OBBComponentType)
		{
			return obbComponents.AllocComponent();
		}
		if (type == ComponentConst.OccluderComponentType)
		{
			return occuluderComponents.AllocComponent();
		}
		if (type == ComponentConst.OcclusionComponentType)
		{
			return occulusionComponents.AllocComponent();
		}
		return -1L;
	}

	public void ReleaseComponnet(int type, long id)
	{
		if (type == ComponentConst.TransformComponentType)
		{
			transformComponents.ReleaseComponent(id);
		}
		else if (type == ComponentConst.OBBComponentType)
		{
			obbComponents.ReleaseComponent(id);
		}
		else if (type == ComponentConst.OccluderComponentType)
		{
			occuluderComponents.ReleaseComponent(id);
		}
		else if (type == ComponentConst.OcclusionComponentType)
		{
			occulusionComponents.ReleaseComponent(id);
		}
	}
}
