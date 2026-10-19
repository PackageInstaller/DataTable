using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class OperateNode : UIBehaviour
{
	[SerializeReference]
	private BImage nodeImage;

	[SerializeReference]
	private LocalizeStringEvent nodeNameLocalize;

	[SerializeReference]
	private GameObject nodeExtraInfoRoot;

	[SerializeReference]
	private LocalizeStringEvent nodeExtraInfoLocalize;

	[SerializeReference]
	private BetterAnimation betterAnimation;

	[SerializeReference]
	private GameObject arrow;

	[SerializeReference]
	private UpdateSortingLayer updateSortingLayer;

	private BaseUIView _view;

	private int index;

	private OperateNodeOperateType _operateType;

	private GameObject _longPressCircle;

	private bool _suppressLongPressCircle;

	public RectTransform RectTransform => transform as RectTransform;

	public int Index => index;

	private bool _isPc => MonoECS.instance.ispc;

	public void Init(OperateNodeData nodeData, ImageAssetStation imageStation, bool isLast, int nodeId)
	{
		index = nodeData.Index;
		_operateType = nodeData.OperateType;
		Reset();
		NodeMessage data = CoreUtils.GetData(nodeId, RuntimeConfigs.data.nodeMessages);
		if (data == null)
		{
			imageStation.LoadImage(nodeData.NodeImageData.GroupId, nodeData.NodeImageData.ImageId, nodeImage);
			nodeNameLocalize.SetReference(_isPc ? nodeData.PcNodeNameLocalizeData : nodeData.NodeNameLocalizeData);
			if (_isPc)
			{
				nodeExtraInfoRoot.SetActive(nodeData.PcExtraInfoLocalizeData.IsValid());
				nodeExtraInfoLocalize.SetReference(nodeData.PcExtraInfoLocalizeData);
			}
			else
			{
				nodeExtraInfoRoot.SetActive(nodeData.ExtraInfoLocalizeData.IsValid());
				nodeExtraInfoLocalize.SetReference(nodeData.ExtraInfoLocalizeData);
			}
		}
		else
		{
			int nodeNameId = data.nodeNameId;
			int extraTextId = data.extraTextId;
			Nodelist data2 = CoreUtils.GetData(nodeNameId, RuntimeConfigs.data.nodelists);
			if (data2 == null)
			{
				imageStation.LoadImage(nodeData.NodeImageData.GroupId, nodeData.NodeImageData.ImageId, nodeImage);
			}
			else
			{
				int nodeIcon = data2.nodeIcon;
				if (nodeIcon > 0)
				{
					imageStation.LoadImage(106, nodeIcon, nodeImage);
				}
				else
				{
					imageStation.LoadImage(nodeData.NodeImageData.GroupId, nodeData.NodeImageData.ImageId, nodeImage);
				}
				if (data2.nodeName > 0)
				{
					LocalizeStringConfig config = new LocalizeStringConfig
					{
						table = LocalizeTable.ShortCommon,
						id = data2.nodeName
					};
					nodeNameLocalize.SetReference(new LocalizeStringData(config));
				}
				else
				{
					nodeNameLocalize.SetReference(_isPc ? nodeData.PcNodeNameLocalizeData : nodeData.NodeNameLocalizeData);
				}
			}
			nodeExtraInfoRoot.SetActive(extraTextId > 0);
			if (extraTextId > 0)
			{
				ExtraList data3 = CoreUtils.GetData(extraTextId, RuntimeConfigs.data.extraLists);
				if (data3 == null)
				{
					LocalizeStringConfig config2 = new LocalizeStringConfig
					{
						table = LocalizeTable.Common,
						id = extraTextId
					};
					nodeExtraInfoLocalize.SetReference(new LocalizeStringData(config2));
				}
				else
				{
					LocalizeStringConfig config3 = new LocalizeStringConfig
					{
						table = LocalizeTable.ShortCommon,
						id = data3.nodeName
					};
					nodeExtraInfoLocalize.SetReference(new LocalizeStringData(config3));
				}
			}
		}
		arrow.SetActive(!isLast);
		updateSortingLayer?.UpdateLayer();
	}

	private void LateUpdate()
	{
		if (_suppressLongPressCircle)
		{
			GameObject longPressCircle = GetLongPressCircle();
			if (longPressCircle != null && longPressCircle.activeSelf)
			{
				longPressCircle.SetActive(value: false);
			}
		}
	}

	public void Reset()
	{
		SuppressLongPressCircle();
		betterAnimation.GetSequence("NormalStatus").Play();
	}

	public AnimationBuilder SetIsCur()
	{
		if (_operateType == OperateNodeOperateType.Click)
		{
			SuppressLongPressCircle();
			return betterAnimation.GetSequence("OneClick").Play();
		}
		if (_operateType == OperateNodeOperateType.LongPress)
		{
			_suppressLongPressCircle = false;
			return betterAnimation.GetSequence("LongPress").Play();
		}
		return null;
	}

	public AnimationBuilder SetSuccess()
	{
		SuppressLongPressCircle();
		return betterAnimation.GetSequence("Success");
	}

	public AnimationBuilder SetFail()
	{
		SuppressLongPressCircle();
		return betterAnimation.GetSequence("Fail").Play();
	}

	private void SuppressLongPressCircle()
	{
		_suppressLongPressCircle = true;
		GameObject longPressCircle = GetLongPressCircle();
		if (longPressCircle != null && longPressCircle.activeSelf)
		{
			longPressCircle.SetActive(value: false);
		}
	}

	private GameObject GetLongPressCircle()
	{
		if (_longPressCircle == null)
		{
			Transform transform = base.transform.Find("longpress_cir");
			if (transform != null)
			{
				_longPressCircle = transform.gameObject;
			}
		}
		return _longPressCircle;
	}
}
