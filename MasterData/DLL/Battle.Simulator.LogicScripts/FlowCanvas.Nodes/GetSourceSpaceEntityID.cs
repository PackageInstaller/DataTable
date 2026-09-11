using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("环境实体(逻辑)", 0)]
[Category("Logic/修正模式")]
[Description("获取环境实体ID")]
public class GetSourceSpaceEntityID : PureFunctionNode<int>
{
	private SimEntity mSourceSpaceEntity;

	public override int Invoke()
	{
		if (!base.parentNode.mSimContext.hasEntitySourceSpace)
		{
			Debug.LogError("未进入间层");
			return 0;
		}
		if (mSourceSpaceEntity == null)
		{
			mSourceSpaceEntity = base.parentNode.mSimContext.entitySourceSpaceEntity;
		}
		return mSourceSpaceEntity.creationIndex;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		mSourceSpaceEntity = null;
	}
}
