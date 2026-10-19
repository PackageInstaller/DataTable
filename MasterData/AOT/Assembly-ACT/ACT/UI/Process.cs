using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using DG.Tweening;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class Process : UIBehaviour
{
	[SerializeReference]
	private GameObject operateNodePrefab;

	[SerializeReference]
	private RectTransform nodeRoot;

	[SerializeReference]
	private ScrollRect nodeScrollRect;

	[SerializeReference]
	private HorizontalLayoutGroup nodeLayoutGroup;

	[SerializeReference]
	private GameObject processDesRoot;

	[SerializeReference]
	private LocalizeStringEvent processDesLocalize;

	[SerializeReference]
	private LocalizeStringEvent processTitleLocalize;

	[SerializeReference]
	private UpdateSortingLayer updateSortingLayer;

	[SerializeReference]
	private BetterAnimation processAnimation;

	[SerializeReference]
	private float nodeToCenterTime;

	private int _maxNodeNum;

	private float lastNodeNormalizedX;

	private List<OperateNode> _operateNodes = new List<OperateNode>();

	private OperateNode _curOperateNode;

	private bool _isPlayingLastNodeSuccess;

	private Tweener _nodeToCenterTween;

	private const string _finishProcessQueueName = "CharacterTutorialFinishProcess";

	private const string _clearEffectRootName = "pt_spark";

	private ImageAssetStation _imageStation;

	private Transform _clearEffectRoot;

	private int _totalNodeNum => _operateNodes.Count;

	public void Init(ImageAssetStation imageStation)
	{
		_imageStation = imageStation;
		float x = (operateNodePrefab.transform as RectTransform).sizeDelta.x;
		float spacing = nodeLayoutGroup.spacing;
		float width = nodeScrollRect.viewport.rect.width;
		float f = (width + spacing) / (x + spacing);
		_maxNodeNum = Mathf.FloorToInt(f);
		float num = (width - (float)_maxNodeNum * x - (float)(_maxNodeNum - 1) * spacing) / 2f;
		lastNodeNormalizedX = 1f - (num + x / 2f) / width;
	}

	public void UnInit()
	{
	}

	public void StartProcess(PromptProcessData processData)
	{
		EnsureCanvasHierarchyReady();
		CreateNode(processData);
		ProcessMessage data = CoreUtils.GetData(processData.id, RuntimeConfigs.data.processMessages);
		if (data != null)
		{
			int processTitle = data.processTitle;
			int processText = data.processText;
			processDesRoot.SetActive(processText > 0);
			if (processTitle > 0)
			{
				LocalizeStringConfig config = new LocalizeStringConfig
				{
					table = LocalizeTable.ShortCommon,
					id = processTitle
				};
				processTitleLocalize.SetReference(new LocalizeStringData(config));
			}
			if (processText > 0)
			{
				LocalizeStringConfig config2 = new LocalizeStringConfig
				{
					table = LocalizeTable.LongCommon,
					id = processText
				};
				processDesLocalize.SetReference(new LocalizeStringData(config2));
			}
		}
		else
		{
			processDesRoot.SetActive(processData.describeLocalizeData.IsValid());
			processDesLocalize.SetReference(processData.describeLocalizeData);
			processTitleLocalize.SetReference(processData.titleLocalizeData);
		}
		updateSortingLayer.UpdateLayer();
		processAnimation.GetSequence("OperateRefresh").Play();
		Model<CharacterTutorialModel>.Interface.CanOperate = true;
	}

	public void FinishProcess()
	{
		if (!_isPlayingLastNodeSuccess)
		{
			nodeRoot.DestroyChildren();
			_operateNodes.Clear();
			_curOperateNode = null;
		}
		Model<CharacterTutorialModel>.Interface.CanOperate = false;
	}

	private void EnsureCanvasHierarchyReady()
	{
		Transform parent = transform;
		while (parent != null)
		{
			if (!parent.gameObject.activeSelf)
			{
				parent.gameObject.SetActive(value: true);
			}
			Canvas component = parent.GetComponent<Canvas>();
			if (component != null)
			{
				if (!component.enabled)
				{
					component.enabled = true;
				}
				break;
			}
			parent = parent.parent;
		}
	}

	private void CreateNode(PromptProcessData processData)
	{
		if (processData != null)
		{
			nodeRoot.DestroyChildren();
			_operateNodes.Clear();
			for (int i = 0; i < processData.NodeCount; i++)
			{
				OperateNodeData node = processData.GetNode(i);
				int id = processData.id;
				int nodeId = ((node != null && node.MessageId > 0) ? node.MessageId : (id * 100 + i + 1));
				OperateNode component = Object.Instantiate(operateNodePrefab, nodeRoot).GetComponent<OperateNode>();
				_operateNodes.Add(component);
				component.Init(node, _imageStation, i == processData.NodeCount - 1, nodeId);
			}
			LayoutRebuilder.ForceRebuildLayoutImmediate(nodeScrollRect.content);
		}
	}

	public void OnToNextOperateNode(OperateNodeData nodeData)
	{
		bool flag = _curOperateNode == null;
		_curOperateNode = _operateNodes[nodeData.Index];
		_curOperateNode.SetIsCur();
		if (flag)
		{
			ResetNodePos();
		}
		else
		{
			ScrollFollowCurrentNode();
		}
	}

	public void OnOperateNodeSuccess(OperateNodeData nodeData, bool isLast)
	{
		if (_curOperateNode == null)
		{
			return;
		}
		if (_curOperateNode.Index != nodeData.Index)
		{
			if (nodeData.Index < _curOperateNode.Index || nodeData.Index >= _operateNodes.Count)
			{
				return;
			}
			_curOperateNode = _operateNodes[nodeData.Index];
		}
		if (isLast)
		{
			_isPlayingLastNodeSuccess = true;
			_curOperateNode.SetSuccess().OnComplete((AnimationBuilder builder) =>
			{
				nodeRoot.DestroyChildren();
				_operateNodes.Clear();
				_curOperateNode = null;
				_isPlayingLastNodeSuccess = false;
			}).PlayInQueue("CharacterTutorialFinishProcess");
			AnimationBuilder sequence = processAnimation.GetSequence("Clear");
			sequence.OnPlay(SkipClearIfUltraTimeline);
			sequence.PlayInQueue("CharacterTutorialFinishProcess");
		}
		else
		{
			_curOperateNode.SetSuccess().Play();
		}
	}

	private void SkipClearIfUltraTimeline(AnimationBuilder builder)
	{
		if (IsMainEntityInUltraTimeline())
		{
			builder.Goto(builder.Duration());
			HideClearEffectRoot();
			builder.SetLoops(0);
		}
	}

	private void HideClearEffectRoot()
	{
		if (_clearEffectRoot == null)
		{
			_clearEffectRoot = transform.Find("pt_spark");
		}
		if (_clearEffectRoot != null)
		{
			_clearEffectRoot.gameObject.SetActive(value: false);
		}
	}

	public void HideClearEffectRootForUltraTimeline()
	{
		HideClearEffectRoot();
	}

	private bool IsMainEntityInUltraTimeline()
	{
		MonoECS instance = MonoECS.instance;
		if (instance == null)
		{
			return false;
		}
		Entity mainEntity = instance.mainEntity;
		if (!mainEntity.IsValid)
		{
			return false;
		}
		return mainEntity.GetCompEffect()?.bInUltraTimeline ?? false;
	}

	public void OnOperateNodeFail(OperateNodeData failNodeData, OperateNodeData toNodeData)
	{
		if (failNodeData == null || toNodeData == null || toNodeData.Index < 0 || toNodeData.Index >= _operateNodes.Count)
		{
			return;
		}
		int failIndex = failNodeData.Index;
		if (failIndex < 0 || failIndex >= _operateNodes.Count)
		{
			if (_curOperateNode == null)
			{
				return;
			}
			failIndex = _curOperateNode.Index;
		}
		int targetIndex = toNodeData.Index;
		OperateNode failNode = _operateNodes[failIndex];
		Model<CharacterTutorialModel>.Interface.CanOperate = false;
		AnimationBuilder animationBuilder = failNode.SetFail();
		if (animationBuilder == null)
		{
			RestoreNodesAfterFail(targetIndex, failIndex, failNode);
			return;
		}
		animationBuilder.OnComplete((AnimationBuilder _) =>
		{
			RestoreNodesAfterFail(targetIndex, failIndex, failNode);
		});
	}

	private void RestoreNodesAfterFail(int targetIndex, int failIndex, OperateNode failNode)
	{
		if (failNode == null || targetIndex < 0 || targetIndex >= _operateNodes.Count || failIndex < 0 || failIndex >= _operateNodes.Count || _operateNodes[failIndex] != failNode)
		{
			return;
		}
		for (int i = targetIndex; i < _operateNodes.Count; i++)
		{
			if (i != failIndex)
			{
				_operateNodes[i].Reset();
			}
		}
		if (failIndex >= 0 && failIndex < _operateNodes.Count && failIndex != targetIndex)
		{
			_operateNodes[failIndex].Reset();
		}
		_curOperateNode = _operateNodes[targetIndex];
		_curOperateNode.SetIsCur();
		Model<CharacterTutorialModel>.Interface.CanOperate = true;
		ResetNodePos();
	}

	private void ResetNodePos()
	{
		if (!(nodeScrollRect == null) && !(nodeScrollRect.content == null))
		{
			KillNodeScrollTween();
			nodeScrollRect.StopMovement();
			Canvas.ForceUpdateCanvases();
			if (_totalNodeNum <= _maxNodeNum || _maxNodeNum <= 0)
			{
				nodeScrollRect.normalizedPosition = Vector2.one * 0.5f;
			}
			else
			{
				nodeScrollRect.content.localPosition = GetLocalPos(_operateNodes[_maxNodeNum - 1], new Vector2(lastNodeNormalizedX, 0.5f));
			}
		}
	}

	private void ScrollFollowCurrentNode()
	{
		if (!(_curOperateNode == null) && _maxNodeNum > 0 && _totalNodeNum > _maxNodeNum)
		{
			int num = _curOperateNode.Index;
			if (num + 1 < _totalNodeNum)
			{
				num++;
			}
			if (num >= _maxNodeNum)
			{
				MoveNodeToLastSeat(_operateNodes[num], immediate: false);
			}
		}
	}

	private void MoveNodeToLastSeat(OperateNode node, bool immediate)
	{
		if (!(node == null) && !(nodeScrollRect == null) && !(nodeScrollRect.content == null))
		{
			KillNodeScrollTween();
			nodeScrollRect.StopMovement();
			Vector2 localPos = GetLocalPos(node, new Vector2(lastNodeNormalizedX, 0.5f));
			if (immediate)
			{
				nodeScrollRect.content.localPosition = localPos;
			}
			else
			{
				_nodeToCenterTween = nodeScrollRect.DOContentLocalPos(localPos, nodeToCenterTime);
			}
		}
	}

	private void KillNodeScrollTween()
	{
		Tweener nodeToCenterTween = _nodeToCenterTween;
		_nodeToCenterTween = null;
		if (nodeToCenterTween != null && nodeToCenterTween.active)
		{
			nodeToCenterTween.Kill();
		}
	}

	private Vector2 GetLocalPos(OperateNode node, Vector2 pos)
	{
		return nodeScrollRect.GetToTargetContentLocalPos(node.RectTransform, pos);
	}

	public void DestroyAllNode()
	{
		nodeRoot.DestroyChildren();
		_operateNodes.Clear();
		_curOperateNode = null;
	}
}
