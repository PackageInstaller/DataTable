using System;
using System.Collections.Generic;
using ACT.World.Asset;
using UnityEngine;

namespace ACT.Config;

public class ConnectNodeModelConfig : ScriptableObject
{
	[Serializable]
	public class TransferShapeModel
	{
		[SerializeField]
		private TransferNodeShape _shape;

		[SerializeField]
		private YooAssetReference _modelAsset;

		public TransferNodeShape Shape => _shape;

		public YooAssetReference ModelAsset => _modelAsset;
	}

	[SerializeField]
	private YooAssetReference _startNodeModel;

	[SerializeField]
	private YooAssetReference _endNodeModel;

	[SerializeField]
	private YooAssetReference _normalNodeModel;

	[Tooltip("根据不同形状配置不同的模型")]
	[SerializeField]
	private List<TransferShapeModel> _transferNodeModels = new List<TransferShapeModel>();

	public YooAssetReference StartNodeModel => _startNodeModel;

	public YooAssetReference EndNodeModel => _endNodeModel;

	public YooAssetReference NormalNodeModel => _normalNodeModel;

	public YooAssetReference GetModelAsset(ConnectNodeType nodeType, TransferNodeShape shape = TransferNodeShape.Straight)
	{
		return nodeType switch
		{
			ConnectNodeType.Start => StartNodeModel, 
			ConnectNodeType.Normal => NormalNodeModel, 
			ConnectNodeType.Transfer => GetTransferModelAsset(shape), 
			ConnectNodeType.End => EndNodeModel, 
			_ => null, 
		};
	}

	private YooAssetReference GetTransferModelAsset(TransferNodeShape shape)
	{
		if (_transferNodeModels == null || _transferNodeModels.Count == 0)
		{
			return null;
		}
		return _transferNodeModels.Find((TransferShapeModel x) => x.Shape == shape)?.ModelAsset;
	}
}
