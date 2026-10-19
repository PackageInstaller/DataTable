using System;
using ACT.Config;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class ConnectNodeData : StateWorldAssetData
{
	public ConnectNodeType nodeType = ConnectNodeType.Normal;

	[Tooltip("旋转动画持续时间（秒），0表示瞬间切换")]
	[Range(0f, 10f)]
	public float rotationDuration = 1f;

	[Tooltip("定义传输节点的形状。T型有4个槽位，根据旋转角度自动计算可连通的槽位")]
	public TransferNodeShape nodeShape;

	[SerializeField]
	private TransferStateConfig[] _transferStates;

	[Tooltip("传输节点的管道槽位配置，下标对应位置信息（0=上, 1=右, 2=下, 3=左）")]
	[SerializeField]
	private StateCondition[] _stateConditions;

	[SerializeField]
	private StateWorldUid[] linkedNodes;

	[SerializeField]
	private BoxColliderParameters _triggerField;

	[Tooltip("用于自动连接工具检测节点相交的Bounds大小")]
	public Vector3 linkBoundsSize = new Vector3(2f, 2f, 2f);

	[Tooltip("Bounds中心相对于节点位置的偏移")]
	public Vector3 linkBoundsCenter = Vector3.zero;

	[SerializeField]
	private EndNodeLinkStateObj[] _endNodeLinkStateObjs;

	[SerializeField]
	private Pos _tipTransform;

	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	public int weight;

	public LocalizedString name;

	public int iconId;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public TransferStateConfig[] TransferStates => _transferStates;

	public StateCondition[] StateConditions => _stateConditions;

	public StateWorldUid[] LinkedNodes => linkedNodes;

	public BoxColliderParameters TriggerField => _triggerField;

	public EndNodeLinkStateObj[] EndNodeLinkStateObjs => _endNodeLinkStateObjs;

	public Pos TipTransform => _tipTransform;

	public override void Bake(object assetComp)
	{
	}
}
