using Bamboo.ECS;

namespace ACT.UI;

public abstract class OperateBtnData
{
	protected OperateBtnFormDataManager _formDataManager;

	public virtual CustomUICompType btnType { get; protected set; }

	public bool configDisableState { get; set; }

	protected virtual void InitFormDataManager(Entity entity)
	{
	}
}
